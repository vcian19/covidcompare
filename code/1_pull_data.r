# ##############################################################################
# Purpose:  Collate versioned data for model comparison;
# Author:  Patty Liu & Joseph Friedman
# Reviewer: Austin Carter
# ##############################################################################

## Setup
rm(list = ls())
source("code/_init.r")

#--FUNCTIONS----------------------

## Functions that return links for a given model shop

links.ihme <- function() {
  links <- rvest::html("http://www.healthdata.org/covid/data-downloads") %>%
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
  links <- unique(links)
  return(links)
}

links.delphi <- function() {
  github <- "https://github.com/COVIDAnalytics/website/tree/master/"
  req <- GET("https://api.github.com/repos/COVIDAnalytics/website/git/trees/master?recursive=1")
  stop_for_status(req)
  filelist <- unlist(lapply(content(req)$tree, "[", "path"), use.names = F) %>%
    grep("data/predicted/Global_", ., value = T)
  links <- data.table(link = filelist)
  links <- links[!grepl("test|since100", link)]
  links <- links[, date := str_match(link, "[0-9]{8}")]
  ## Keep best version
  links[, n := 1:.N, by=.(date)]
  links[, max := max(n), by=.(date)]
  links <- links[n==max]
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
  ## Get previous dates currently downloaded
  today <- Sys.Date()
  prev.dates <- list.files("data/raw/lanl/") %>% gsub(".csv", "", .)
  if (length(last)==0) {
    last <- "2020-04-12"
  } else {
    last <- max(prev.dates %>% as.Date) 
  }
  ## Sequence through dates until today
  new <- seq.Date(last + 1, today, by = "day") %>% format("%Y-%m-%d")
  all <- c(new, prev.dates)
  
  ## Turn this into a list of links
  links <- data.table(date=all)
  links[date <= "2020-04-22", us := paste0("https://covid-19.bsvgateway.org/forecast/us/", date, "/files/", date, "_deaths_quantiles_us.csv")]
  links[date > "2020-04-22" & date < "2020-11-01", `:=` (
    global = paste0("https://covid-19.bsvgateway.org/forecast/global/", date, "/files/", date, "_deaths_quantiles_global_website.csv"),
    us = paste0("https://covid-19.bsvgateway.org/forecast/us/", date, "/files/", date, "_deaths_quantiles_us_website.csv")
  )]
  links[date >= "2020-11-01", `:=` (
    global = paste0("https://covid-19.bsvgateway.org/forecast/global/", date, "/files/",date,"_global_cumulative_daily_deaths_website.csv"),
    us = paste0("https://covid-19.bsvgateway.org/forecast/us/", date, "/files/",date,"_us_cumulative_daily_deaths_website.csv"),
    global_daily = paste0("https://covid-19.bsvgateway.org/forecast/global/", date, "/files/",date,"_global_incidence_daily_deaths_website.csv"),
    us_daily = paste0("https://covid-19.bsvgateway.org/forecast/us/", date, "/files/",date,"_us_incidence_daily_deaths_website.csv")
  )]
  
  links <- links %>% melt(., id.var="date", variable.name="loc", value.name="link")
  links <- links[!is.na(link)]
  links[, prev := ifelse(date %in% prev.dates, 1, 0)]
  
  ## Check new links
  check <- links[date%in%new]$link
  for (.link in check) {
    live <- tryCatch(url.exists(.link))
    if (!live) links <- links[link!=.link]
  }
  
  ## Return list of links
  links <- links[, .(date, link)]
  
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
  links <- links[, .(link, date)]
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
  ## Issue with a few files
  links <- links[date!="2020-10-05"]
  return(links)
}


## Download, based on file structure for a given model shop

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
  if (model %in% "lanl") {
    df <- lapply(link, function(x) {
      temp <- tempfile()
      download.file(x, temp)
      df <- temp %>% fread()
      unlink(temp)
      file <- ifelse(grepl("cumulative", x), "cumulative", "daily")
      df[, type := file]
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
    if (grepl("reference|hospitalization", tolower(files)) %>% any()) {
      files <- files %>% 
        grep("reference|hospitalization", ., value = T) %>%
        grep(".csv", ., value = T) 
      if (length(files)>1) files <- files %>% grep("reference_hosp", ., value=T)
      df <- fread(files)
    } else {
      df <- files %>%
        grep(".csv", ., value = T) %>%
        fread()
    }
    unlink(c("temp1", "temp2"))
    if ("date_reported" %in% names(df)) df %>% setnames("date_reported", "date")
  }

  return(df)
}

## Apply basic column name standardization and location mapping for Georgia (state) and Georgia (country)

clean.ihme <- function(df, .date){
    ## IHME Georgia naming mix-ups
    if (.date=="2020-06-05") df[location_name == "Georgia_two", location_name := "Georgia"]
    ## Careful: from 2020-06-24 onwards IHME calls Georgia country and state the same name (ordered country first then state)
    if (.date>="2020-06-24" & .date <= "2020-08-27") {
      n <- df[location_name=="Georgia"] %>% nrow
      df[location_name=="Georgia", location_name := rep(c("Georgia (Country)", "Georgia"), n/2)]
    }
    if (.date>="2020-08-27") {
      df[location_id == 35, location_name := "Georgia (Country)"]
      df[location_id == 533, location_name := "Georgia"]
    }
  return(df)
}

clean.yyg <- function(df, .date) {
  df <- df[region %in% c("ALL", "") | country == "US"]
  df[country == "Georgia", country := "Georgia (Country)"]
  df[country == "US" & region != "", country := region]
  ## Fill in historical input data, creating cumulative deaths from actual_deaths (daily)
  df[, predicted_total_deaths_mean := predicted_total_deaths_mean %>% as.integer()]
  df[!is.na(actual_deaths), predicted_total_deaths_mean := cumsum(actual_deaths), by=.(country, region)]
  return(df)
}

clean.imperial <- function(df, .date) {
  df <- df[country == "Georgia", country := "Georgia (Country)"]
  if ("cumulative_deaths" %in% unique(df$compartment)) {
    df <- df[, type := compartment]
    df[type=="cumulative_deaths", type := "cumulative"]; df[type=="deaths", type := "daily"]
    df <- df[type %in% c("cumulative", "daily") & scenario == "Maintain Status Quo"]
    
  } else {
    ## Create cumulative deaths
    df <- df[compartment == "deaths" & scenario == "Maintain Status Quo"]
    cols <- c("y_025", "y_mean", "y_975")
    df <- df[, (cols) := lapply(.SD, cumsum), .SDcols=cols, by="country"]
  }
  return(df)
}

clean.delphi <- function(df, .date) {
    df <- df[Province == "None" | Country == "US"]
    df[Country == "Georgia", Country := "Georgia (Country)"]
    df[Country == "US" & Province != "None", Country := Province]
  return(df)
}

clean.lanl <- function(df, .date) {
  if ("countries" %in% names(df)) df[countries == "Georgia", countries := "Georgia (Country)"]
  if ("big_group" %in% names(df)) df[!is.na(big_group) & name=="Georgia", name := "Georgia (Country)"]
  if ("state" %in% names(df)) df[!is.na(state), countries := state]
  if ("name" %in% names(df)) df %>% setnames("name", "countries")
  if ("date" %in% names(df)) df %>% setnames("date", "dates")
  ## Make wide so daily/cumulative
  return(df)
}

clean.sikjalpha <- function(df, .date) {
  df <- df[id == 59, Country := "Georgia (Country)"]
  ## Reshape Long
  df <- df %>% melt(., id.vars=c("Country", "id"))
  df %>% setnames(c("Country", "variable", "value"), c("location_name", "date", "deaths"))
  df$id <- NULL
  return(df)
}

clean.cols <- function(df, .model) {
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
  if(!("lower" %in% names(df))) df[, `:=` (lower = NA, upper = NA)]
  return(df)
}

clean.location_name <- function(df) {
  ## Location name standardization
  df <- merge(df, loc.map, by.x = "location_name", by.y = "orig_name", all.x = T)
  df[!is.na(new_name), location_name := new_name]
  df <- df[location_name != "drop"] ## Drop subnationals
  df$new_name <- NULL
  ## Manual Edits
  df[grepl("d'Ivoire", location_name), location_name := "Cote d'Ivoire"]
  
  ## Attempt to map locations onto IHME standard set
  locs <- loc.ihme[level==3 | grepl("USA_", ihme_loc_id), c("location_name", "ihme_loc_id")]
  df <- merge(df, locs, by = "location_name", all.x = T)
  
  ## Save non-mapped locations
  new_locs <- data.table(orig_name = df[is.na(ihme_loc_id)]$location_name %>% unique())
  if (new_locs %>% length() > 0)  {
    loc.map <- rbind(loc.map, new_locs, fill=T) %>% unique
    export(loc.map, "data/ref/locs_missing.csv", na="")
  }
  return(df)
}

dupe.check <- function(df) {
  if (any(duplicated(df[, .(date, ihme_loc_id)]))) stop("Duplicates in ihme_loc_id, date")
}

make.wide <- function(df) {
  df.daily <- df[type=="daily"]; df.daily$type <- NULL
  df <- df[type=="cumulative"]; df$type <- NULL
  df.daily %>% setnames(c("deaths", "lower", "upper"), c("daily", "daily_lower", "daily_upper"))
  df <- merge(df, df.daily, by=c("location_name", "date", "ihme_loc_id"), all=T)
}

#------------------------

## Function to download and clean forecasts for a given model shop
update.files <- function(links, .model) {
  output <- paste0("data/raw/", .model, "/")
  if (length(list.files(output))>0) {
    dates.exist <- list.files(output) %>% str_replace(".csv", "")
    dates.todl <- setdiff(links$date, dates.exist)
  } else {
    dates.todl <- links$date
  }
  if (length(dates.todl) > 0) {
    for (.date in dates.todl) {
      print(paste0("Updating: ", .model, " ", .date))
      ## Download
      link <- links[date == .date]$link
      df <- download(link, .model) 
      ## Specific model shop cleaning
      df <- do.call(paste0("clean.", .model), list(df, .date))
      ## Column name cleaning
      df <- clean.cols(df, .model)
      ## Clean location_name
      df <- clean.location_name(df)
      ## Make wide if has daily
      if ("type" %in% names(df)) df <- make.wide(df)
      dupe.check(df)
      ## Create date, models cols
      df <- df[!is.na(deaths)]
      df <- df[, model_date := .date]
      df <- df[, model := .model]
      ## Delete data prior to model_date
      df <- df[as.Date(date) >= as.Date(model_date)]
      df %>% setcolorder(c("model", "model_date", "location_name", "ihme_loc_id", "date", "deaths", "lower", "upper"))
      ## Save
      export(df, paste0(output, .date, ".csv"))
    }
  }
}

#--UPDATE JHU DATA-------------------------------------------------

max.jhu <- readRDS("data/processed/jhu.rds")$date %>% max
if (Sys.Date() > max.jhu) {
## Update JHU Data
"https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv" %>%
  download.file(., "data/raw/jhu/global.csv")

"https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_US.csv" %>%
  download.file(., "data/raw/jhu/us.csv")


## Load JHU data
jhu <- paste0("data/raw/jhu/global.csv") %>% fread()
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
loc.map <- fread("data/ref/locs_missing.csv") %>% unique
jhu <- merge(jhu, loc.map, by.x = "location_name", by.y = "orig_name", all.x = T)
jhu[!is.na(new_name), location_name := new_name]
jhu <- jhu[location_name != "drop"] ## Drop subnationals
jhu[, c("new_name") := NULL]

## Attempt to map locations onto IHME standard set
locs <- fread("data/ref/locs_ihme.csv")
locs <- locs[level==3 | grepl("USA_", ihme_loc_id), c("location_name", "ihme_loc_id")]
jhu <- merge(jhu, locs, by = "location_name", all.x = T)

## Save non-mapped locations
new_locs <- data.table(orig_name = jhu[is.na(ihme_loc_id)]$location_name %>% unique())
if (new_locs %>% length() > 0) {
  warning(paste0("unmapped locs: ", paste(unlist(new_locs), collapse = ", ")))
  loc.map <- rbind(loc.map, new_locs, fill=T) %>% unique
  export(loc.map, "data/ref/locs_missing.csv", na="")
}

## Save JHU
jhu[, date := as.Date(date)]
export(jhu, "data/processed/jhu.rds")
}

#--UPDATE NYTIMES DATA----------------------------------------------------------
max.nyt <- readRDS("data/processed/nyt.rds")$date %>% max
if (Sys.Date() > max.nyt) {
## Update NYTimes Data
"https://github.com/nytimes/covid-19-data/raw/master/us-states.csv" %>% 
  download.file(., paste0("data/raw/nyt/us.csv"))

nyt <- ("data/raw/nyt/us.csv") %>%
  fread() %>%
  select(date, state, deaths) %>%
  setnames(c("state", "deaths"), c("location_name", "nyt"))
nyt[location_name == "Virgin Islands", location_name := "Virgin Islands, U.S."]
locs <- fread("data/ref/locs_ihme.csv")
nyt <- merge(nyt, locs, by = "location_name", all.x = T)
## Save JHU
nyt[, date := as.Date(date)]
export(nyt, "data/processed/nyt.rds")
}
#--UPDATE FORECAST DATA--------------------------------------------------

## Update forecast estimates
update.files(links.lanl(), "lanl")
update.files(links.imperial(), "imperial")
tryCatch(update.files(links.ihme(), "ihme"), error=function(x) print("ihme error"))
update.files(links.yyg(), "yyg")
update.files(links.delphi(), "delphi")
update.files(links.sikjalpha(), "sikjalpha")







