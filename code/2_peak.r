# ##############################################################################
# Purpose:  Peak predictive validity
# Author:  Patty Liu & Joseph Friedman
# ##############################################################################


## Setup
rm(list = ls())
pacman::p_load(data.table, tidyverse, ggplot2, grid, gridExtra, cowplot, reldist, lubridate)

graph.peakmethod <- 1
graph.peakcomparison <- 1
graph.peakpv <- 1

theme <- theme_bw() + theme(
  plot.title = element_text(size = 12, face = "bold"),
  axis.title.x = element_text(size = 10, face = "bold"),
  axis.title.y = element_text(size = 10, face = "bold"),
  axis.text.y = element_text(size = 10, face = "bold"),
  axis.text.x = element_text(size = 10, face = "bold"),
  strip.background = element_rect(fill = "white"),
  strip.text.x = element_text(size = 10, face = "bold"),
  legend.position = "top"
)

c.vals <- c(
  "Delphi" = "#e31a1c",
  "IHME - CF SEIR" = "#6a3d9a",
  "IHME - Curve Fit" = "#cab2d6",
  "IHME - MS SEIR" = "#33a02c",
  "Los Alamos Nat Lab" = "#1f78b4",
  "Youyang Gu" = "#ff7f00",
  "Imperial" = "#fb9a99"
)

#--Setup------

## Load
df <- readRDS("data/processed/data.rds")
df[,super_region_name:=NULL]
locs <- fread("data/ref/locs_map.csv")[, .(ihme_loc_id, super_region_name)]
df <- merge(df, locs, by="ihme_loc_id", all.x=T)
df <- df[order(model, model_date, location_name, date)]

#--Smooth truth data--------

## Subset frame to truth data
tf <- df[!is.na(truth), .(truth, date, location_name, ihme_loc_id)] %>% unique()
tf <- tf[order(location_name, date)]

## Count number of days reporting for each location, subset to locs with >= 7 days
tf[, n := .N, by=.(location_name)]
tf <- tf[n >=7]
tf$n <- NULL

## Create daily
tf[, daily := truth - shift(truth), by = .(location_name)]
tf[daily < 0, daily := 0]

## Locs ordered by cumulative death at current date
locs <- tf[, .(location_name, truth, date)]
locs[, last := max(date), by=.(location_name)]
locs <- locs[date==last, .(location_name, truth)] %>%
  arrange(desc(truth)) %>%
  unique()
locs <- locs$location_name
tf[, location_name := factor(location_name, levels = locs, order = T)]

# Rb Method 10*3 day rolling mean
tf <- tf[order(location_name,date)]
tf[, rb := frollmean(daily, 3, align = "center", na.rm = T), by = .(location_name)]
for (i in 1:9) tf[, rb := frollmean(rb, 3, align = "center", na.rm = T), by = .(location_name)]
# Single 7 day rolling average
tf[, ra7 := frollmean(daily, 7, align = "center", na.rm = T), by = .(location_name)]
# Loess by timeseries, span of .33
tf[!is.na(daily) & !is.na(location_name), loess := loess(daily ~ as.numeric(date), span = 0.33) %>% predict(), by = .(location_name)]

## Reshape long
tf <- melt(tf, id.vars = c("ihme_loc_id", "location_name", "date", "truth", "daily"), value.name = "truth_sm", variable.name = "type")

## Set floor
tf[truth_sm < 0, truth_sm := 0]

#--Define peaks in truth data-------

findpeak <- function(x, y, w, t) {
  require(zoo)
  ## Drop missings
  i.drop <- is.na(y)
  x <- x[!i.drop]
  y <- y[!i.drop]
  ## Find Peak
  df <- data.table(x = x, y = y)
  df[, y.max := rollapply(y, 2 * w, max, align = "center", partial=T, fill = NA)]
  df[, p := y >= y.max]
  #--Conditions-----------
  ## 1. Greater than threshold t
  df[, t := ifelse(y > t, 1, 0)]
  ## 2. Peak not within 1 week of last date and not the first date
  .lastdate <- tail(x, 1)
  df[, d := ifelse((x + 7 < .lastdate) & (x != min(x)), 1, 0)]
  ## 3. Peak is not exceeded by i% after n days
  df[p == 1 & t == 1 & d == 1, m := lapply(x, function(z) df[x %in% (z:(z + 21))]$y %>% max())]
  df[p == 1 & t == 1 & d == 1, e := ifelse(!(y * 1.2 < m), 1, 0)]
  ## Flag where conditions met
  df[, pf := ifelse(p == 1 & t == 1 & e == 1 & d == 1, 1, 0)]
  ## If multiple peaks, peak is first of such peaks
  x.max <- df[pf == 1]$x
  if (length(x.max) > 1) x.max <- min(x.max)
  return(x.max)
}


## Find peak of smoothed truth data
tf[, peak := ifelse(date %in% findpeak(date, truth_sm, w = 3, t = 5), 1, 0), by = .(location_name, type)]

## Frame of true peaks
pf.t <- tf[peak == 1 & type == "loess", .(location_name, date)] %>% setnames("date", "date_truth")

## graphing name for smoother typs
tf[type == "rb", smooth_type := "3 X 10 Day Rolling Average"]
tf[type == "ra7", smooth_type := "7 Day Rolling Average"]
tf[type == "loess", smooth_type := "Loess"]


#--Graph-------

if (graph.peakmethod) {
  pdf(paste0("visuals/Supplemental_Figures_Smoothing_Daily_Deaths_", Sys.Date(), ".pdf"), w = 12, h = 8)
  loc.groups <- split(locs, ceiling(seq_along(locs) / 9))
  for (i in 1:length(loc.groups)) {
    p <- ggplot(tf[location_name %in% loc.groups[[i]]]) +
      geom_point(aes(x = date, y = daily), size = 2) +
      theme +
      geom_line(aes(x = date, y = truth_sm, color = smooth_type), size = 2, alpha = .8) +
      geom_vline(show.legend = F, aes(xintercept = ifelse(peak == 1, date, NA), color = smooth_type), linetype = "dashed") +
      facet_wrap(~location_name, nrow = 3, scales = "free") +
      theme +
      labs(x = "Month", y = "Daily Deaths") +
      scale_color_discrete(name = "")
    print(p)
  }
  dev.off()
}


## Keep loess
tf <- tf[type == "loess"]

#--Identify Model peaks--------------

## Subset to locations with peaks identified in truth data
loc.peaks <- pf.t$location_name %>%
  unique() %>%
  sort()
df <- df[location_name %in% loc.peaks]

## Subset to model versions that are  at least 7 days prior to the true peak date
df <- merge(df, pf.t, by = "location_name", all.x = T)
df <- df[model_date <= date_truth - 7]

## Update loc.peaks
loc.peaks <- loc.peaks[loc.peaks %in% df$location_name]

## Smooth
df <- df[order(location_name, model, model_date, date)]
df[!is.na(deaths), deaths_sm := predict(loess(deaths ~ as.numeric(date), span = .33)), by = .(model, model_date, location_name)]

## Find peak
df[, peak := ifelse(date %in% findpeak(date, deaths_sm, w = 3, t = 5), 1, 0), by = .(model, model_date, location_name)]

## If the model doesn't identify a peak, set peak as the max
df[, pf := max(peak, na.rm = T), by = .(location_name, model, model_date)]
df[pf == 0, m := max(deaths_sm, na.rm = T), by = .(location_name, model, model_date)]
df[pf == 0, peak := ifelse(m == deaths_sm, 1, 0), by = .(location_name, model, model_date)]

#----------------------------------------

## Graph - Model daily deaths and peak dates
if (graph.peakcomparison) {
  pdf(paste0("visuals/Supplemental_Figures_Peak_Timing_", Sys.Date(), ".pdf"), width = 12, height = 6)
  
  for (.loc in loc.peaks) {
    print(.loc)
    .max <- 1.1 * max(df[location_name == .loc & model != "imperial", deaths_sm / 1000], tf[location_name == .loc, truth_sm / 1000], na.rm = T)
    .mods <- df[location_name == .loc & peak == 1]$model %>% unique()
    
    
    .start <- min(tf[truth > 0 & location_name==.loc, date]) - 8
    .end <- max(df[location_name==.loc, date]) + 7
    
    d <- df[location_name == .loc & date > .start & model %in% .mods]
    t <- tf[location_name == .loc & date > .start]
    
    
    
    ## Graph of daily death forecasts
    gg1 <- ggplot() +
      ## Model forecasts
      geom_line(data = d, aes(x = date, y = deaths_sm / 1000, group = model_date, color = model_long, alpha = model_date), size = 2) +
      ## Predicted peak
      geom_point(data = d[peak == 1], aes(x = date, y = deaths_sm / 1000, color = model_long), shape = 21, size = 2, fill = "white") +
      ## Truth
      geom_point(data = t, aes(x = date, y = truth_sm / 1000), shape = 21, fill = "white", color = "black") +
      ## True peak
      geom_vline(data = t[peak == 1], aes(xintercept = date), linetype = "dashed") +
      ## Settings
      scale_x_date(breaks = function(x) seq.Date(from = min(x) %>% floor_date("month"), to = max(x), by = "1 months"), date_labels = "%b") +
      theme_bw() +
      theme +
      theme(axis.text.x = element_text(size = 8, face = "bold")) + 
      guides(alpha = F, color = F) +
      labs(y = "Deaths (Thousands)", x = "Week of", title = paste0(.loc, " - Smoothed Daily Deaths")) +
      scale_color_manual(values = c.vals, name = "") +
      coord_cartesian(ylim = c(0, .max), xlim = c(.start, .end)) +
      facet_wrap(~model_long, nrow = 1)
    
    ## Graph of predicted peaks by model date
    gg2 <- ggplot() +
      ## True peak
      geom_vline(data = t[peak == 1], aes(xintercept = date), linetype = "dashed") +
      ## Predicted peaks
      geom_point(data = d[peak == 1], aes(x = date, y = model_date, color = model_long, fill = model_long)) +
      ## Settings
      scale_x_date(breaks = function(x) seq.Date(from = min(x) %>% floor_date("month"), to = max(x), by = "1 months"), date_labels = "%b") +
      scale_color_manual(values = c.vals, name = "") +
      scale_fill_manual(values = c.vals, name = "") +
      labs(y = "Model Date", x = "Actual and Predicted Peak") +
      theme_bw() +
      theme +
      theme(axis.text.x = element_text(size = 8, face = "bold")) + 
      guides(fill = F, color = F) +
      coord_cartesian(xlim = c(.start, .end)) +
      facet_wrap(~model_long, nrow = 1)
    
    gg <- plot_grid(gg1, gg2, align = "v", axis = "lr", ncol = 1, rel_heights = c(1, .5))
    print(gg)
  }
  dev.off()
}

#--Predictive Validity on Peak---------------------------------------

## Subset to peak frame
pf <- df[peak == 1]

## Calculate prediction week
pf[, wk := as.numeric(floor((date_truth - model_date) / 7))]

## Error Stats
pf[, error := as.numeric(date - date_truth)]
pf[, abs_error := abs(error)]

## Create a "pooled" model and refactor
pool <- pf %>% copy()
pool <- pool[, model_short := "Pooled"]
pf <- rbind(pf, pool)
pf[, model_short := factor(model_short, levels = levels(model_short), ordered = T)]

# Month of estimation
pf[, model_month := format(model_date, format = "%b")]
pf[, model_month := factor(model_month, levels = c("Mar", "Apr", "May", "Jun"))]


peak.stats <- function(t, by) {
  t[, `:=`(num = uniqueN(location_name), me = median(error, na.rm = T), mae = median(abs_error, na.rm = T)), by = by]
  t <- t[, c(by, "num", "me", "mae"), with = F] %>% unique()
}

error.mod <- peak.stats(pf, by = c("model_short")) %>% mutate(wk = 0) %>% data.table()
error.m.wk <- peak.stats(pf, by = c("model_short", "model_month","wk"))%>% mutate(super_region_name = "Global") %>% data.table()
error.m.wk.sr <- peak.stats(pf, by = c("model_short", "model_month","wk","super_region_name"))



#--Graph-------------------------------------------

if (graph.peakpv) {
  pdf(paste0("visuals/Figure_4_", Sys.Date(), ".pdf"), width = 3, height = 8)
  
  bar.mae <- scale_fill_gradient2(high = "#d73027", low = "#4575b4", mid = "#ffffbf", midpoint = 30, name = "", breaks = seq(0, 50, 25), labels = paste0(seq(0, 50, 25), " Days"), guide = guide_colorbar(barwidth = 10, barheight = .3), na.value = "white", limits = c(0, 55))
  bar.me <- scale_fill_gradient2(high = "#ef8a62", low = "#ef8a62", mid = "#67a9cf", midpoint = 0, name = "", breaks = seq(-50, 50, 50), labels = paste0(seq(-50, 50, 50), " Days"), guide = guide_colorbar(barwidth = 10, barheight = .3), na.value = "white", limits = c(-55, 55))
  
  # exclude models with less than 20 total locations for small sample size
  exclude.mods <- error.mod[num < 20, model_short]
  
  
  gg1 <- ggplot(error.m.wk[wk %in% 1:6  & !(model_short %in% exclude.mods)]) +
    geom_tile(aes(y = wk, x = model_short, fill = mae), alpha = 1.0) +
    facet_grid(rows=vars(model_month),cols=vars(super_region_name),as.table = F,scales="free_y")+
    geom_text(aes(y = wk, x = model_short, label = paste0(round(mae)))) +
    theme + 
    theme(
      axis.text.x=element_text(angle=30,face="bold",size=10,hjust=1),
      strip.text.x=element_text(face="bold",size=9),
      strip.text.y=element_text(face="bold",size=9),
      plot.title=element_text(face="bold",size=8)
      
    )+
    xlab("") +
    labs(y = "Forecasting Weeks", title = "A) Accuracy - Median Absolute Error in Days") +
    bar.mae +
    scale_y_continuous(breaks=seq(1,6)) +
    scale_x_discrete(expand = c(0, 0)) #
  
  
  print(gg1)
  dev.off()
  
  
  pdf(paste0("visuals/Extened_Data_Figure_4_", Sys.Date(), ".pdf"), width = 3, height = 8)
  
  
  gg2 <- ggplot(error.m.wk[wk %in% 1:6  & !(model_short %in% exclude.mods)]) +
    geom_tile(aes(y = wk, x = model_short, fill = me), alpha = 1.0) +
    facet_grid(rows=vars(model_month),cols=vars(super_region_name),as.table = F,scales = "free_y")+
    geom_text(aes(y = wk, x = model_short, label = paste0(round(me)))) +
    theme + 
    theme(
      axis.text.x=element_text(angle=30,face="bold",size=10,hjust=1),
      strip.text.x=element_text(face="bold",size=9),
      strip.text.y=element_text(face="bold",size=9),
      plot.title=element_text(face="bold",size=8)
    )+
    xlab("") +
    labs(y = "Forecasting Weeks", title = "A) Bias - Median Error in Days") +
    bar.me +
    scale_y_continuous(breaks=seq(1,6)) +
    scale_x_discrete(expand = c(0, 0)) #
  
  
  print(gg2)
  dev.off()
  
}


