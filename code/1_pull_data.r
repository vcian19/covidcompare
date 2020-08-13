# ##############################################################################
# Purpose:  Collate versioned data for model comparison
# Author:  Patty Liu & Joseph Friedman
# Reviewer: Austin Carter
# ##############################################################################

## Setup
rm(list = ls())
pacman::p_load(data.table, tidyverse, git2r, rvest, stringr, httr, rio, ggplot2, grid, gridExtra, zoo, RCurl, lubridate)
root <- getwd()
data.root <- paste0(root, "/data/raw/")
db <- fread("data/ref/links.csv")

loc.states <- data.table(name = state.name, abb = state.abb)

#--FUNCTIONS----------------------

links.ihme <- function() {
  links <- html("http://www.healthdata.org/covid/data-downloads") %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    str_subset("\\.zip") %>%
    str_subset("archive") %>%
    data.table() %>%
    setnames("link")
  links[, date := tstrsplit(link, "/")[[5]]]
  ## Latest update
  tp.date <- readLines("http://www.healthdata.org/covid/data-downloads") %>%
    grep("last updated", ., value = T) %>%
    strsplit(., ",") %>%
    nth(1) %>%
    nth(2) %>%
    trimws() %>%
    paste0(., ", 2020") %>%
    parse_date_time(., orders = "mdy") %>%
    as.Date() %>%
    format("%Y-%m-%d")
  tp <- data.table(link = "https://ihmecovid19storage.blob.core.windows.net/latest/ihme-covid19.zip", date = tp.date)
  links <- rbind(links, tp)
  return(links)
}

links.delphi <- function() {
  github <- "https://github.com/COVIDAnalytics/website/tree/master/"
  req <- GET("https://api.github.com/repos/COVIDAnalytics/website/git/trees/master?recursive=1")
  stop_for_status(req)
  filelist <- unlist(lapply(content(req)$tree, "[", "path"), use.names = F) %>%
    grep("data/predicted/Global_", ., value = T)
  links <- data.table(link = filelist)
  links <- links[!grepl("test", link)]
  links[, date := tstrsplit(link, "_")[[2]] %>% str_replace(".csv", "")]
  links[grepl("V2", link), date := tstrsplit(link, "_")[[3]] %>% str_replace(".csv", "")]
  ## Keep best version
  links[, version := ifelse(grepl("V2", link), 2, 1)]
  links[, best := max(version), by=.(date)]
  links <- links[version==best]
  links[, date := paste0(str_sub(date, 1, 4), "-", str_sub(date, 5, 6), "-", str_sub(date, 7, 9))]
  links[, link := paste0(github, link) %>% str_replace("tree", "raw")]
  return(links)
}

links.yyg <- function() {
  github <- "https://github.com/youyanggu/covid19_projections/tree/master/"
  req <- GET("https://api.github.com/repos/youyanggu/covid19_projections/git/trees/master?recursive=1")
  stop_for_status(req)
  filelist <- unlist(lapply(content(req)$tree, "[", "path"), use.names = F) %>%
    grep("projections/combined/", ., value = T) %>%
    grep("_global.csv|_us.csv", ., value = T)
  links <- data.table(link = filelist)
  links[, date := tstrsplit(link, "/")[[3]]]
  links[, date := date %>% str_replace("_global.csv|_us.csv", "")]
  links[, link := paste0(github, link) %>% str_replace("tree", "raw")]
  links <- links[!is.na(date) & date != "latest"]
  links <- links[!(date %in% "2020-04-01")]
  return(links)
}

links.lanl <- function() {
  today <- Sys.Date()
  prev.dates <- list.files("data/raw/lanl/") %>% gsub(".csv", "", .)
  last <- max(prev.dates %>% as.Date) 
  seq <- seq.Date(last + 1, today, by = "day") %>% format("%Y-%m-%d")
  dates <- c(seq, prev.dates)
  ## Global
  links1 <- paste0("https://covid-19.bsvgateway.org/forecast/global/files/", dates, "/deaths/", dates, "_deaths_quantiles_global_website.csv")
  ## US
  links2 <- paste0("https://covid-19.bsvgateway.org/forecast/us/files/", dates, "/deaths/", dates, "_deaths_quantiles_us_website.csv")
  ## US Old
  dates <- c("2020-04-22", "2020-04-19", "2020-04-15", "2020-04-12")
  links3 <- paste0("https://covid-19.bsvgateway.org/forecast/us/files/", dates, "/deaths/", dates, "_deaths_quantiles_us.csv")
  check <- c(links1, links2, links3)
  live <- lapply(check, function(x) {
    date <- x %>%
      str_split("/") %>%
      nth(1) %>%
      nth(7) %>%
      as.Date()
    if (date > last ) {
      return(ifelse(tryCatch(url.exists(x)), x, NA))
    }
    if (date <= last) {
      return(x)
    }
  }) %>%
    unlist() %>%
    na.omit()
  dates <- lapply(live, function(x) {
    x %>%
      str_split("/") %>%
      nth(1) %>%
      nth(7)
  }) %>% unlist()
  links <- data.table(link = live, date = dates)
  return(links)
}

links.imperial <- function() {
  github <- "https://github.com/mrc-ide/global-lmic-reports/tree/master/"
  req <- GET("https://api.github.com/repos/mrc-ide/global-lmic-reports/git/trees/master?recursive=1")
  stop_for_status(req)
  filelist <- unlist(lapply(content(req)$tree, "[", "path"), use.names = F) %>%
    grep("data/", ., value = T) %>%
    grep(".csv", ., value = T)
  links <- data.table(link = filelist)
  links[, date := tstrsplit(link, "/")[[2]] %>% str_replace(".csv", "")]
  links[, link := paste0(github, link) %>% str_replace("tree", "raw")]
  ## Imperial now publishes versions, take the best version
  links[grepl("_v", link), version := tstrsplit(link, "_v")[2]]
  links[grepl("_v", link), date := tstrsplit(date, "_v")[1]]
  links[, version := gsub(".csv.zip", "", version)]
  links[, `:=`(flag = .N > 1, max = version %>% max()), by = "date"]
  links <- links[!(flag == 1 & version != max)]
  links <- links %>% select(!c("version", "flag", "max"))
  links <- rbind(links)
  return(links)
}

links.sikjalpha <- function() {
  github <- "https://github.com/scc-usc/ReCOVER-COVID-19/tree/master/"
  req <- GET("https://api.github.com/repos/scc-usc/ReCOVER-COVID-19/git/trees/master?recursive=1")
  stop_for_status(req)
  filelist <- unlist(lapply(content(req)$tree, "[", "path"), use.names = F)  %>%
    grep("results/historical_forecasts/", ., value = T) %>%
    grep("global_forecasts_deaths.csv|us_forecasts_deaths.csv", ., value = T)
  links <- data.table(link = filelist)
  links[, date := tstrsplit(link, "/")[[3]] %>% str_replace(".csv", "")]
  links[, link := paste0(github, link) %>% str_replace("tree", "raw")]
  return(links)
}

download <- function(link, model) {
  if (model %in% c("yyg", "lanl", "delphi", "sikjalpha")) {
    df <- lapply(link, function(x) {
      temp <- tempfile()
      download.file(x, temp)
      df <- temp %>% fread()
      unlink(temp)
      return(df)
    }) %>% rbindlist(., fill = T)
  }
  if (model %in% "imperial") {
    temp1 <- tempfile()
    temp2 <- tempfile()
    download.file(link, temp1)
    unzip(zipfile = temp1, exdir = temp2)
    df <- list.files(temp2, full.name = T, recursive = T) %>%
      grep(".csv", ., value = T) %>%
      fread()
    unlink(c("temp1", "temp2"))
  }
  if (model %in% "ihme") {
    temp1 <- tempfile()
    temp2 <- tempfile()
    download.file(link, temp1)
    unzip(zipfile = temp1, exdir = temp2)
    files <- list.files(temp2, full.name = T, recursive = T)
    if (grepl("Reference_", files) %>% any()) {
      df <- files %>%
        grep("Reference_", ., value = T) %>%
        grep(".csv", ., value = T) %>%
        fread()
    } else {
      df <- files %>%
        grep("ospital|ihme", ., value = T) %>%
        grep(".csv", ., value = T) %>%
        fread()
    }
    unlink(c("temp1", "temp2"))
    if ("date_reported" %in% names(df)) df %>% setnames("date_reported", "date")
  }

  return(df)
}

clean <- function(df, .model) {
  if (.model=="ihme") {
    
  }
  if (.model == "yyg") {
    df <- df[region %in% c("ALL", "") | country == "US"]
    df[country == "Georgia", country := "Georgia (Country)"]
    df[country == "US" & region != "", country := region]
    ## Fill in historical input data, creating cumulative deaths from actual_deaths (daily)
    df[, predicted_total_deaths_mean := predicted_total_deaths_mean %>% as.integer()]
    df[!is.na(actual_deaths), predicted_total_deaths_mean := cumsum(actual_deaths), by=.(country, region)]
  }
  if (.model == "imperial") {
    df <- df[country == "Georgia", country := "Georgia (Country)"]
    df <- df[compartment == "deaths" & scenario == "Maintain Status Quo"]
  }
  if (.model == "delphi") {
    df <- df[Province == "None" | Country == "US"]
    df[Country == "Georgia", Country := "Georgia (Country)"]
    df[Country == "US" & Province != "None", Country := Province]
  }
  if (.model == "lanl") {
    if ("countries" %in% names(df)) df[countries == "Georgia", countries := "Georgia (Country)"]
    if ("state" %in% names(df)) df[!is.na(state), countries := state]
  }
  if (.model == "sikjalpha") {
    df <- df[id == 59, Country := "Georgia (Country)"]
    ## Reshape Long
    df <- df %>% melt(., id.vars=c("Country", "id"))
    df %>% setnames(c("Country", "variable", "value"), c("location_name", "date", "deaths"))
    df$id <- NULL
  }
  if (.model %in% c("yyg", "imperial", "delphi", "lanl", "ihme")) {
  ## Subset columns
  cols <- db[model == .model]$cols %>%
    strsplit(",") %>%
    unlist() %>%
    trimws()
  rename <- db[model == .model]$rename %>%
    strsplit(",") %>%
    unlist() %>%
    trimws()
  df <- df %>% select(cols)
  setnames(df, cols, rename)
  }
  return(df)
}


#------------------------

update.files <- function(links, .model) {
  output <- paste0(data.root, "/", .model, "/")
  dates.exist <- list.files(output) %>% str_replace(".csv", "")
  dates.todl <- setdiff(links$date, dates.exist)
  if (length(dates.todl) > 0) {
    lapply(dates.todl, function(.date) {
      ## Download
      link <- links[date == .date]$link
      df <- download(link, .model) %>% clean(., .model)
      df <- df[!is.na(deaths)]
      df <- df[, model_date := .date]
      df <- df[, model := .model]
      ## Save
      export(df, paste0(output, .date, ".csv"))
      print(paste0("Updating ", .model, " ", .date))
    })
  }
}


#--UPDATE DATA--------------------------------------------------

## Update JHU Data
"https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv" %>%
  download.file(., paste0(data.root, "/jhu/global.csv"))

"https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_US.csv" %>%
  download.file(., paste0(data.root, "/jhu/us.csv"))

## Update NYTimes Data
"https://github.com/nytimes/covid-19-data/raw/master/us-states.csv" %>% download.file(., paste0(data.root, "/nyt/us.csv"))

## Pull modeled estimates
update.files(links.lanl(), "lanl")
update.files(links.imperial(), "imperial")
update.files(links.ihme(), "ihme")
update.files(links.yyg(), "yyg")
update.files(links.delphi(), "delphi")
update.files(links.sikjalpha(), "sikjalpha")

## Collate everything together
df <- lapply(db$model, function(model) {
  path <- paste0(data.root, "/", model)
  files <- list.files(path, full.name = T)
  df <- lapply(files, fread) %>% rbindlist(., fill = T)
}) %>% rbindlist(., fill = T)


#--NAME ADJUSTMENTS--------------------------------------------------

## IHME Georgia naming mix-ups
df[model=="ihme" & model_date == "2020-06-05" & location_name == "Georgia_two", location_name := "Georgia"]
## Careful: from 2020-06-24 onwards IHME calls Georgia country and state the same name (ordered country first then state)
n <- df[model=="ihme" & model_date >= "2020-06-24" & location_name=="Georgia"] %>% nrow
df[model=="ihme" & model_date >= "2020-06-24" & location_name=="Georgia", location_name := rep(c("Georgia (Country)", "Georgia"), n/2)]

## Location name standardization
loc.map <- fread("data/ref/missing_locs.csv") %>% unique
df <- merge(df, loc.map, by.x = "location_name", by.y = "orig_name", all.x = T)
df[!is.na(new_name), location_name := new_name]
df <- df[location_name != "drop"] ## Drop subnationals
df$new_name <- NULL
## Manual Edits
df[grepl("d'Ivoire", location_name), location_name := "Cote d'Ivoire"]

## Attempt to map locations onto IHME standard set
locs <- fread("data/ref/locs_map.csv")
locs <- locs[level==3 | grepl("USA_", ihme_loc_id), c("location_name", "ihme_loc_id")]
df <- merge(df, locs, by = "location_name", all.x = T)

## Save non-mapped locations
new_locs <- data.table(orig_name = df[is.na(ihme_loc_id)]$location_name %>% unique())
if (new_locs %>% length() > 0) warning(paste0("unmapped locs: ", paste(unlist(new_locs), collapse = ", ")))
loc.map <- rbind(loc.map, new_locs, fill=T) %>% unique
export(loc.map, "data/ref/missing_locs.csv", na="")

## Drop Mexico and Brazil in IHME on dates where wasn't reporting for full country
df <- df[!(model=="ihme" & model_date < "2020-06-05" & location_name %in% c("Brazil", "Mexico"))]

## Drop US run of IHME on 2020-05-29 (Deaths data static at total of 3 through 5/29)
df <- df[!(model=="ihme" & model_date == "2020-05-29" & location_name == "United States")]


## A few model_dates have unexpected drop by 50% in cumulative deaths in IHME on a single day
## replace this with the average between the the preceding and day after

df[location_name=="Italy" & model == "ihme" & model_date %in% c("2020-06-29", "2020-06-25", "2020-06-24", "2020-07-07"), temp := (shift(deaths, 1) + shift(deaths, -1))/2]
df[location_name=="Italy" & model == "ihme" & model_date %in% c("2020-06-29", "2020-06-25", "2020-06-24", "2020-07-07") & date == "2020-05-24", `:=` (deaths=temp, lower=temp, upper=temp)]

df[location_name=="Spain" & model == "ihme" & model_date %in% c("2020-07-07", "2020-06-29", "2020-06-25", "2020-06-24", "2020-06-10", "2020-06-08", "2020-04-17"), temp := (shift(deaths, 1) + shift(deaths, -1))/2]
df[location_name=="Spain" & model == "ihme" & model_date %in% c("2020-07-07", "2020-06-29", "2020-06-25", "2020-06-24", "2020-06-10", "2020-06-08", "2020-04-17") & date == "2020-05-24", `:=` (deaths=temp, lower=temp, upper=temp)]

df[location_name=="Canada" & model == "ihme" & model_date %in% c("2020-07-07"), temp := (shift(deaths, 2) + shift(deaths, -2))/2]
df[location_name=="Canada" & model == "ihme" & model_date %in% c("2020-07-07") & date %in% c("2020-06-26", "2020-06-27"), `:=` (deaths=temp, lower=temp, upper=temp)]

df$temp <- NULL

#--JHU DATA CLEAN--------------------------------------------------

## Load JHU data
jhu <- paste0(data.root, "/jhu/global.csv") %>% fread()
cols <- names(jhu)[5:length(names(jhu))]

## Aggregate up for Australia, China, Canada by province
jhu2 <- jhu[`Country/Region` %in% c("Australia", "China", "Canada")]
jhu2[, c("Lat", "Long", "Province/State") := NULL]
jhu2 <- melt(jhu2, id.vars = "Country/Region", variable.name = "date", value.name = "jhu")
jhu2 <- jhu2[, .(jhu = sum(as.numeric(jhu), na.rm = T)), by = .(date, `Country/Region`)]

## Append onto the rest of JHU data
jhu <- jhu[get("Province/State") == ""]
jhu[, c("Province/State", "Lat", "Long") := NULL]
jhu <- melt(jhu, id.vars = "Country/Region", variable.name = "date", value.name = "jhu")
jhu <- rbind(jhu, jhu2)

## Clean up
jhu %>% setnames("Country/Region", "location_name")
jhu[location_name == "Georgia", location_name := "Georgia (Country)"]

## JHU US State level data
tf <- paste0("data/raw/jhu/us.csv") %>% fread()
tf <- tf %>% select(c("Province_State", grep("/", names(tf), value = T)))
tf <- melt(tf, id.vars = "Province_State", variable.name = "date", value.name = "jhu")
## Aggregate up state
tf[, jhu := sum(jhu), by = c("Province_State", "date")]
tf %>% setnames("Province_State", "location_name")
tf <- tf %>% unique()
jhu <- rbind(jhu, tf)
jhu[, date := as.Date(date, format = c("%m/%d/%y")) %>% format("%Y-%m-%d")]

## Location name standardization
loc.map <- fread("data/ref/missing_locs.csv") %>% unique
jhu <- merge(jhu, loc.map, by.x = "location_name", by.y = "orig_name", all.x = T)
jhu[!is.na(new_name), location_name := new_name]
jhu <- jhu[location_name != "drop"] ## Drop subnationals
jhu[, c("new_name") := NULL]

## Attempt to map locations onto IHME standard set
locs <- fread("data/ref/locs_map.csv")
locs <- locs[level==3 | grepl("USA_", ihme_loc_id), c("location_name", "ihme_loc_id")]
jhu <- merge(jhu, locs, by = "location_name", all.x = T)

## Save non-mapped locations
new_locs <- data.table(orig_name = jhu[is.na(ihme_loc_id)]$location_name %>% unique())
if (new_locs %>% length() > 0) warning(paste0("unmapped locs: ", paste(unlist(new_locs), collapse = ", ")))
loc.map <- rbind(loc.map, new_locs, fill=T) %>% unique
export(loc.map, "data/ref/missing_locs.csv", na="")

## Save JHU
export(jhu, "data/processed/jhu.rds")

jhu$location_name <- NULL

## Merge on to df
df <- merge(df, jhu,  by = c("ihme_loc_id", "date"), all.x = T)


#--NYT DATA CLEAN-----------------------------------------------------------

nyt <- ("data/raw/nyt/us.csv") %>%
  fread() %>%
  select(date, state, deaths) %>%
  setnames(c("state", "deaths"), c("location_name", "nyt"))
nyt[location_name == "Virgin Islands", location_name := "Virgin Islands, U.S."]
nyt <- merge(nyt, locs, by = "location_name", all.x = T)
## Save JHU
export(nyt, "data/processed/nyt.rds")

nyt$location_name <- NULL

df <- merge(df, nyt, by = c("ihme_loc_id", "date"), all.x = T)

#--DATA CLEANING-----------------------------------------------------------

## Drop if no model
df <- df[!(is.na(model))]

# If starts of timeseries are missing 0s
df[is.na(deaths), deaths := 0]

## Convert imperial from daily to cumulative space
cols <- c("deaths", "lower", "upper")
df[model %in% c("imperial"), c(paste0(cols, "_cum")) := lapply(.SD, cumsum), .SDcols = cols, by = c("location_name", "model_date", "model")]

# IHME, LANL, DELPHI are in cumulative space, create daily
df[model != "imperial", `:=` (deaths_cum = deaths, lower_cum = lower, upper_cum=upper)]
df[model != "imperial", `:=` (deaths = deaths_cum - data.table::shift(deaths_cum),
                                                 lower = lower_cum - data.table::shift(lower_cum),
                                                 upper = upper_cum - data.table::shift(upper_cum)), by = .(location_name, model_date, model)]
## Create Truth Variable
df[grepl(x = ihme_loc_id, pattern = "USA_"), truth := nyt]
df[is.na(truth), truth := jhu]

# Set date format
dates <- data.table(date = c(df$date %>% unique, df$model_date %>% unique)) %>% unique
dates[, date.f := as.Date(date)]
df <- merge(df, dates, by="date", all.x=T)
df[, date := date.f]; df$date.f <- NULL
df <- merge(df, dates, by.x="model_date", by.y="date", all.x=T)
df[, model_date := date.f]; df$date.f <- NULL

## Categorize IHME Models
df[model=="ihme" & model_date <= as.Date("2020-04-29"), model := "ihme_cf"]
df[model=="ihme" & model_date >= as.Date("2020-05-04") & model_date <= as.Date("2020-05-26") , model := "ihme_hseir"]
df[model=="ihme" & model_date >= as.Date("2020-05-29"), model := "ihme_elast"]

## Model names

## Set graphing order
df[, model_short := factor(model,
                     levels = c("delphi", "lanl", "yyg", "imperial", "sikjalpha", "ihme_cf", "ihme_hseir", "ihme_elast"),
                     labels = c("Delphi", "LANL", "YYG", "Imperial", "SIKJalpha", "IHME-CF", "IHME-CF-SEIR", "IHME-MS-SEIR"), ordered = T
)]




df[, model_long := factor(model,
                          levels =c("delphi", "lanl", "yyg", "imperial", "sikjalpha", "ihme_cf", "ihme_hseir", "ihme_elast"),
                          labels = c("Delphi", "Los Alamos Nat Lab", "Youyang Gu", "Imperial", "SIKJalpha", "IHME - Curve Fit", "IHME - CF SEIR", "IHME - MS SEIR"), ordered = T
)]

df <- df[order(model, model_date, location_name, date)]

## Super Region 
locs <- fread("data/ref/locs_map.csv")
locs <- locs[level==3 | grepl("USA_", ihme_loc_id), c("location_name", "ihme_loc_id","super_region_name")]
df <- merge(df, locs, by = c("location_name","ihme_loc_id"), all.x = T)

saveRDS(df, "data/processed/data.rds")
