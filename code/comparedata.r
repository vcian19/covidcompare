# ##############################################################################
# Purpose:  Compare Data Sources
# Author:  Patty Liu & Joseph Friedman
# ##############################################################################

## Setup
rm(list = ls())
pacman::p_load(data.table, tidyverse, git2r, rvest, stringr, httr, rio, ggplot2, grid, gridExtra, zoo, RCurl, lubridate, rasterpdf, cowplot)
db <- fread("data/ref/links.csv")
df <- import("data/processed/data.rds")

#----------------------------

## Subset
tf <- df[, .(location_name, ihme_loc_id, date, nyt, jhu, ihme)] %>% unique
tf <- tf[!(is.na(nyt) & is.na(jhu) & is.na(ihme))]

## Set graphing order
locs <- tf[, .(location_name, jhu, date)]
locs[!is.na(jhu), last := max(date), by=.(location_name)]
locs <- locs[date==last, .(location_name, jhu)] %>%
  arrange(desc(jhu)) %>%
  unique()
locs <- locs$location_name
tf[, location_name := factor(location_name, levels = locs, order = T)]

states <- df[grepl("USA_", ihme_loc_id)]$location_name %>% unique

## Overlap

tf <- tf[date <= "2020-07-11"]
tf[!is.na(jhu) & is.na(ihme), miss := 1 ]
tf[is.na(miss), miss := 0 ]


## Countries
pdf("~/Downloads/data_scatter.pdf", w=20, h=10)
loc.groups <- split(locs[!(locs %in% states)], ceiling(seq_along(locs[!(locs %in% states)]) / 9))
for (i in 1:length(loc.groups)) {
p1 <- ggplot(tf[location_name %in% loc.groups[[i]]]) +
  geom_point(aes(x=jhu, y=ihme, color=date)) +
  geom_abline(intercept=0, slope=1, linetype="dashed") + 
  theme_minimal() + 
  theme(legend.position="none") +
  facet_wrap(~location_name, nrow = 3, scales = "free") 

p2 <- ggplot(tf[location_name %in% loc.groups[[i]]]) +
  geom_point(aes(x=date, y=jhu, color="JHU")) +
  geom_point(aes(x=date, y=ihme, color="IHME")) +
  theme_minimal() + 
  facet_wrap(~location_name, nrow = 3, scales = "free")

p <- plot_grid(p1, p2, nrow=1)
print(p)
}
loc.groups <- split(states, ceiling(seq_along(states) / 9))
for (i in 1:length(loc.groups)) {
p1 <- ggplot(tf[location_name %in% loc.groups[[i]]]) +
    geom_point(aes(x=nyt, y=ihme, color=date)) +
    geom_abline(intercept=0, slope=1, linetype="dashed") + 
    theme_minimal() + 
    theme(legend.position="none") +
    facet_wrap(~location_name, nrow = 3, scales = "free")
  
p2 <- ggplot(tf[location_name %in% loc.groups[[i]]]) +
    geom_point(aes(x=date, y=nyt, color="NYT")) +
    geom_point(aes(x=date, y=ihme, color="IHME")) +
    theme_minimal() + 
    facet_wrap(~location_name, nrow = 3, scales = "free")
  
p <- plot_grid(p1, p2, nrow=1)
print(p)
}
dev.off()


## Tile locations where IHME is misssing from JHU
raster_pdf("~/Downloads/data_overlap.pdf", w=10, h=8)
loc.groups <- split(locs[!(locs %in% states)], ceiling(seq_along(locs[!(locs %in% states)]) / 50))
for (i in 1:length(loc.groups)) {
p <-   ggplot(tf[location_name %in% loc.groups[[i]]]) +
  geom_tile(aes(x=date, y=reorder(location_name, desc(location_name)), fill=as.factor(miss))) +
  geom_vline(aes(xintercept="2020-04-01" %>% as.Date)) +
  guides(fill=guide_legend(title = "Missing In IHME")) +
  xlab("") + ylab("")
print(p)
}
loc.groups <- split(states, ceiling(seq_along(states) / 20))
for (i in 1:length(loc.groups)) {
  p <-   ggplot(tf[location_name %in% loc.groups[[i]]]) +
    geom_tile(aes(x=date, y=reorder(location_name, desc(location_name)), fill=as.factor(miss))) +
    geom_vline(aes(xintercept="2020-04-01" %>% as.Date)) +
    guides(fill=guide_legend(title = "Missing In IHME")) +
    xlab("") + ylab("")
  print(p)
}
dev.off()
  




