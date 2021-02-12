
source("code/_init.r")

#--DATA CLEANING-----------------------------------------------------------
collate.data <- function(cores=1, model_date_end=NA) {
## Collate everything together
  df <- mclapply(db$model, function(model) {
    path <- paste0("data/raw/", model)
    files <- data.table(path=list.files(path, full.name = T))
    if (!is.na(model_date_end)) {
      files[, model_date := as.Date(gsub(paste0("data/raw/", model, "/|.csv"), "", path))]
      files <- files[model_date <= model_date_end]
    }
    df <- lapply(files$path, function(x) fread(x, colClasses=c("model_date"="character", "date"="character"))) %>% rbindlist(., fill = T)
    df[, model_date := as.character(model_date)]
  }, mc.cores=cores) %>% rbindlist(., fill = T)

# Create daily space
df[, `:=` (deaths_cum = deaths, lower_cum = lower, upper_cum=upper)]
df[, c("deaths", "lower", "upper") := NULL]
df[, `:=` (deaths = deaths_cum - data.table::shift(deaths_cum),
           lower = lower_cum - data.table::shift(lower_cum),
           upper = upper_cum - data.table::shift(upper_cum)), by = .(location_name, model_date, model)]
df[!is.na(daily), `:=` (deaths = daily, lower=daily_lower, upper=daily_upper)]
df[, c("daily", "daily_lower", "daily_upper") := NULL]

# Set date format
dates <- data.table(date = c(df$date %>% unique, df$model_date %>% unique)) %>% unique
dates[, date.f := as.Date(date)]
df <- merge(df, dates, by="date", all.x=T)
df[, date := date.f]; df$date.f <- NULL
df <- merge(df, dates, by.x="model_date", by.y="date", all.x=T)
df[, model_date := date.f]; df$date.f <- NULL

## Truth data
jhu <- readRDS("data/processed/jhu.rds")[, .(ihme_loc_id, date, jhu)]
nyt <- readRDS("data/processed/nyt.rds")[, .(ihme_loc_id, date, nyt)]
truth <- merge(jhu, nyt, by=c("date", "ihme_loc_id"), all.x=T)
truth[grepl("USA_", ihme_loc_id), truth := nyt]
truth[is.na(truth), truth := jhu]

## Merge truth
df <- merge(df, truth[, .(ihme_loc_id, date, truth, jhu, nyt)], by=c("date", "ihme_loc_id"), all.x=T)

## Set graphing order
df[, model_short := factor(model,
                           levels = c("delphi", "lanl", "yyg", "imperial", "sikjalpha", "ihme", "ucla"),
                           labels = c("Delphi", "LANL", "YYG", "Imperial", "SIKJalpha", "IHME", "UCLA-ML"), ordered = T
)]

df[, model_long := factor(model,
                          levels =c("delphi", "lanl", "yyg", "imperial", "sikjalpha", "ihme", "ucla"),
                          labels = c("Delphi", "Los Alamos Nat Lab", "Youyang Gu", "Imperial", "SIKJalpha", "IHME", "UCLA-ML"), ordered = T
)]

df <- df[order(model, model_date, location_name, date)]

## Super Region 
locs <- fread("data/ref/locs_ihme.csv")
locs <- locs[level==3 | grepl("USA_", ihme_loc_id), c("location_name", "ihme_loc_id","super_region_name")]
df <- merge(df, locs, by = c("location_name","ihme_loc_id"), all.x = T)

## Drop data error in published IHME 05-29 model
df <- df[!(model_long == "IHME" & model_date == "2020-05-29" & location_name == "United States")]

## 
df[, .(model_short, model_date)] %>% unique
df[, min := min(model_date), by="model_short"]
df[, max := max(model_date), by="model_short"]
print("Model Dates Loaded")
df[, .(model_short, min, max)] %>% unique %>% print

## Print most recent models included
return(df)
}