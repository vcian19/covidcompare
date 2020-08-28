# ##############################################################################
# Purpose: Update systematic review
# Author:  Patty Liu & Joseph Friedman
# ##############################################################################

rm(list = ls())
pacman::p_load(data.table, tidyverse, rio, medrxivr, easyPubMed, RISmed)

## Toggle to update cache
update <- 1

#--UPDATE PULLS---------------------------------------------------------

if (update) {
  
  ## Update Medrxiv pull
  df.mr <- import("data/review/medrxiv_cache.rds") %>% data.table()
  date.lastpull <- df.mr$date %>% max()
  df.mr.new <- mx_api_content(from.date = date.lastpull) %>% data.table()
  df.mr <- rbind(df.mr, df.mr.new)
  df.mr <- unique(df.mr, by = "doi")
  ## Save
  saveRDS(df.mr, "data/review/medrxiv_cache.rds")
  
  ## Update Pubmed pull
  date.new <- Sys.Date() %>% format("%Y/%m/%d")
  search <- paste0("(covid[tiab] OR coronavirus[tiab]) AND (project*[tiab] OR forecast*[tiab]) AND (2019/01/01:", date.new, "[edat])")
  df.xml <- search %>%
    get_pubmed_ids() %>%
    fetch_pubmed_data() %>%
    articles_to_list()
  df.pm <- do.call(rbind, lapply(df.xml, article_to_df, max_chars = -1, getAuthors = FALSE))
  df.pm <- unique(df.pm, by = "pmid")
  saveRDS(df.pm, "data/review/pubmed_cache.rds")
}

#--CLEAN---------------------------------------------------------

## Bring in and clean cache for Pubmed and MedRxiv
mr <- import("data/review/medrxiv_cache.rds") %>%
  data.table() %>%
  select("doi", "title", "abstract", "date") %>%
  mutate(source = "medrxiv", date = as.Date(date))
mr <- mr[(grepl("covid|coronavirus", title, ignore.case = TRUE) | grepl("covid|coronavirus", abstract, ignore.case = TRUE)) &
           (grepl("projection|forecast", title, ignore.case = TRUE) | grepl("projection|forecast", abstract, ignore.case = TRUE))]
pm <- import("data/review/pubmed_cache.rds") %>%
  data.table() %>%
  select("pmid", "doi", "title", "abstract", "day", "month", "year") %>%
  mutate(source = "pubmed", pmid = as.numeric(pmid), date = as.Date(paste0(year, "-", month, "-", day))) %>%
  select(!c("month", "day", "year"))

## Combine lists
df.new <- rbind(mr, pm, fill = T)
df.new <- unique(df, by = "doi")
df.new[, date := date %>% as.character()]
df.new[, id := .I]

## Bring in existing review
df <- fread("data/review/review.csv")

## Update existing review
mf <- df.new[, .(source, pmid, doi, id)]
tf <- df[, .(source, pmid, doi, reviewed)]
tf <- merge(tf, mf, by=c("source", "pmid", "doi"), all=T)
new <- tf[is.na(reviewed)]$id
add <- df.new[id %in% new]; add$id <- NULL
df <- rbind(df, add, fill=T)
df %>% setcolorder(c("source", "date", "doi", "pmid", "model", "link", "title", "abstract", "reviewed", "forecast", "locations", "deaths", "duration", "public", "duplicate", "included"))

## Export
export(df, "data/review/review.csv")