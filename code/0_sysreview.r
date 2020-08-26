# ##############################################################################
# Purpose: Update systematic review
# Author:  Patty Liu & Joseph Friedman
# ##############################################################################

rm(list = ls())
pacman::p_load(data.table, tidyverse, rio, medrxivr, easyPubMed, RISmed, parallel)

## Toggle to update cache
update <- 0

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
  date.new <- "2020/07/10" %>% format("%Y/%m/%d") # Sys.Date()
 # search <- paste0("(covid[tiab] OR coronavirus[tiab]) AND (project*[tiab] OR forecast*[tiab]) AND (2019/01/01:", date.new, "[edat])")
  search <- paste0("(covid[tiab] OR coronavirus[tiab]) AND (project*[tiab] OR forecast*[tiab]) AND (2019/01/01:2020/07/10[edat])")
  df.xml <- search %>%
    get_pubmed_ids() %>%
    fetch_pubmed_data() %>%
    articles_to_list()
  
  df.pm <- mclapply(1:length(df.xml), function(x) {
    print(x)
    t <- article_to_df(df.xml[[x]], max_chars = -1, getAuthors = TRUE) %>% data.table
    if ("lastname" %in% names(t)) {
    t[, authors := paste0(lastname, ", ", firstname)]
    t[, authors := paste0(authors, collapse="; ")]
    t <- t[, .(pmid, doi, title, abstract, year, month, day, authors)] %>% unique
    }
    return(t)
  }, mc.cores=4) %>% rbindlist
  df.pm <- unique(df.pm, by = "pmid")
  authors <- df.pm[, .(pmid, authors)]
  
  saveRDS(df.pm, "data/review/pubmed_cache.rds")
}

#--CLEAN---------------------------------------------------------

## Bring in and clean cache for Pubmed and MedRxiv
mr <- import("data/review/medrxiv_cache.rds") %>%
  data.table() %>%
  select("doi", "authors", "title", "abstract", "date", ) %>%
  mutate(source = "medrxiv", date = as.Date(date)) %>% unique
mr <- mr[(grepl("covid|coronavirus", title, ignore.case = TRUE) | grepl("covid|coronavirus", abstract, ignore.case = TRUE)) &
  (grepl("projection|forecast", title, ignore.case = TRUE) | grepl("projection|forecast", abstract, ignore.case = TRUE))]
pm <- import("data/review/pubmed_cache.rds") %>%
  data.table() %>%
  mutate(authors=paste0(lastname, ", ", firstname)) %>% 
  select("pmid", "doi", "authors", "title", "abstract", "day", "month", "year") %>%
  mutate(source = "pubmed", pmid = as.numeric(pmid), date = as.Date(paste0(year, "-", month, "-", day))) %>%
  select(!c("month", "day", "year"))
pm <- pm[date <= "2020-07-10"]

## Combine lists
df.new <- rbind(mr, pm, fill = T)
df.new <- unique(df.new, by = "doi")
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

## Merge on authors column from df.new
df <- fread("data/review/review.csv")[reviewed==1]
df[, order:=.I]

## Merge on authors from medrxiv
authors.mr <- df.new[source=="medrxiv", .(source, doi, authors)]

t <- merge(df, authors.mr, by=c("source", "doi"), all.x=T)

authors[, source := "pubmed"]
authors[, pmid := as.numeric(pmid)]

## Merge on authors from pubmed
t <- merge(t, authors, by=c("source", "pmid"), all.x=T)
t[, authors := ifelse(!is.na(authors.x), authors.x, authors.y) ]

t[order(order)]

t %>% setcolorder(c("source", "date", "doi", "pmid", "model", "link", "authors", "title", "abstract", "reviewed", "forecast", "locations", "deaths", "duration", "public", "duplicate", "included"))
export(t, "~/Desktop/test.csv")




## Export
#export(df, "data/review/review.csv")
