# ##############################################################################
# Purpose:  Peak predictive validity
# Author:  Patty Liu & Joseph Friedman
# ##############################################################################

## Setup
rm(list = ls())
source("code/_init.r")
source("code/_collate.r")

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
  "IHME" = "#33a02c",
  "Los Alamos Nat Lab" = "#1f78b4",
  "Youyang Gu" = "#ff7f00",
  "Imperial" = "#fb9a99",
  "SIKJalpha" = "#FF1493", 
  "UCLA-ML" = "#cab2d6"
)

#--Setup------

# Load Data
df <- collate.data()

## Truth 
jhu <- readRDS("data/processed/jhu.rds")[, .(ihme_loc_id, date, jhu)]
nyt <- readRDS("data/processed/nyt.rds")[, .(ihme_loc_id, date, nyt)]
tf <- merge(jhu, nyt, by=c("date", "ihme_loc_id"), all.x=T)
tf[grepl("USA_", ihme_loc_id), truth := nyt]
tf[is.na(truth), truth := jhu]
locs <- fread("data/ref/locs_ihme.csv")
tf[, c("jhu", "nyt") := NULL]
tf <- merge(tf, locs[, .(ihme_loc_id, location_name)], by="ihme_loc_id", all.x=T)
tf <- tf[order(location_name, date)]

## Data cleaning

## Append on truth data prior to model_date for smoothing
## Set of all model_date, models
t <- df[, .(model_date, model, location_name)] %>% unique
# For every set, create the truth frame prior to the start
pt <- mclapply(1:nrow(t), function(x) {
  .date <- t[x]$model_date
  .loc <- t[x]$location_name
  .model <- t[x]$model
  truth <- tf[date<.date & location_name==.loc]
  truth[, model := .model]
  truth[, model_date := .date]
  return(truth)
}, mc.cores=4) %>% rbindlist
export(pt, "data/processed/pt.rds")

pt <- readRDS("data/processed/pt.rds")

pt %>% setnames("truth", "deaths_cum")
pt[, deaths := deaths_cum - data.table::shift(deaths_cum), by=.(location_name, model_date, model)]

df <- rbind(df, pt, fill=T)

df[, model_short := factor(model,
                           levels = c("delphi", "lanl", "yyg", "imperial", "sikjalpha", "ihme", "ucla"),
                           labels = c("Delphi", "LANL", "YYG", "Imperial", "SIKJalpha", "IHME", "UCLA-ML"), ordered = T
)]

df[, model_long := factor(model,
                          levels =c("delphi", "lanl", "yyg", "imperial", "sikjalpha", "ihme", "ucla"),
                          labels = c("Delphi", "Los Alamos Nat Lab", "Youyang Gu", "Imperial", "SIKJalpha", "IHME", "UCLA-ML"), ordered = T
)]


## Order
df <- df[order(model, model_date, location_name, date)]

#--Smooth truth data--------

## Count number of days reporting for each location, subset to locs with >= 7 days
tf[, n := .N, by=.(location_name)]
tf <- tf[n >=7]
tf$n <- NULL

## Create daily
tf[, daily := truth - shift(truth), by = .(location_name)]
tf[daily < 0, daily := 0]

## China data issue - 1400 daily deaths on 2020-04-17, artificial peak, remove this
## which should not otherwise affect peak detection
tf[date=="2020-04-17" & location_name=="China", daily := 0]

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
tf[, rb := rollapply(daily, FUN=mean, width=3, align = "center", partial=TRUE, na.rm = T), by = .(location_name)]
for (i in 1:9) tf[, rb := rollapply(rb, FUN=mean, width=3, align = "center", partial=TRUE, na.rm = T), by = .(location_name)]
# Single 7 day rolling average
tf[, ra7 := rollapply(daily, FUN=mean, width=7, align = "center", partial=TRUE, na.rm = T), by = .(location_name)]
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
  ## Daily rate of change
  df[, roc := (y - shift(y, n=7))/shift(y, n=7)]
  df[, y.max := rollapply(y, 2 * w, max, align = "center", partial=T, fill = NA)]
  df[, p := y >= y.max]
  #--Conditions-----------
  ## 1. Greater than threshold t
  df[, t := ifelse(y > t, 1, 0)]
  ## 2. Peak not within 1 week of last date and not the first date
  .lastdate <- tail(x, 1)
  df[, d := ifelse((x + 7 < .lastdate) & (x != min(x)), 1, 0)]
  ## 3. Peak is not exceeded by i% after n days
  df[p == 1 & t == 1 & d == 1, m := lapply(x, function(z) df[x %in% (z:(z + 30))]$y %>% max())]
  df[p == 1 & t == 1 & d == 1, e := ifelse(!(y * 1.2 < m), 1, 0)]
  ## Flag where conditions met
  df[, pf := ifelse(p == 1 & t == 1 & e == 1 & d == 1, 1, 0)]
  ## N peak
  df[, n := cumsum(pf)]
  ## 4. Is the peak at least i% greater than last minima
  df[, min := min(y), by=n]
  prev <- df[, .(n, min)] %>% unique ; prev$n <- prev$n+1; prev %>% setnames("min", "prev_min")
  df <- merge(df, prev, by="n", all.x=T)
  df[pf==1, pf := ifelse((y > prev_min * 1.2) & y > prev_min + 5, 1, 0)]
  # Return all peaks
  peaks <- df[pf == 1]$x
  return(peaks)
}


## Find peak of smoothed truth data
tf[, peak := ifelse(date %in% findpeak(date, truth_sm, w = 3, t = 5), 1, 0), by = .(location_name, type)]

## graphing name for smoother typs
tf[type == "rb", smooth_type := "3 X 10 Day Rolling Average"]
tf[type == "ra7", smooth_type := "7 Day Rolling Average"]
tf[type == "loess", smooth_type := "Loess"]

## Split off non-loess
tf.other <- tf[type!="loess"]

## Keep loess
tf <- tf[type == "loess"]

## Peak period
tf[, n := cumsum(peak) - peak, by=.(location_name)]

## Peak period end
tf[, p_end := max(date), by=.(n, location_name)]

## Peak period end - 7 days
tf[, p_end_n7 := p_end - 7]

# ## ROC
tf[, roc := (truth_sm - shift(truth_sm)) / shift(truth_sm)]
tf[roc==Inf, roc := -1]
tf[, d := c(diff(sign(roc)), 0), by=.(location_name)]
tf[, p_start := max(date[d>0], na.rm=T), by=.(location_name, n)]

## Remove tail window period
tf[, n_max := max(n), by=.(location_name)]
tf[n==n_max, `:=` (p_start = NA, p_end = NA, p_end_n7 = NA)]

## Frame of true peaks
pf.t <- tf[peak == 1 & type == "loess", .(location_name, date, n)] %>% setnames("date", "date_truth")
pf.t <- pf.t %>% setnames("n", "n_truth")

#--Graph-------

if (graph.peakmethod) {
  pdf(paste0("visuals/Supplemental_Figures_Smoothing_Daily_Deaths_", Sys.Date(), ".pdf"), w = 12, h = 8)
  loc.groups <- split(locs, ceiling(seq_along(locs) / 9))
  for (i in 1:length(loc.groups)) {
    t <- tf[location_name %in% loc.groups[[i]]][, .(location_name, n, p_start, p_end_n7)] %>% unique
    p <- ggplot(tf[location_name %in% loc.groups[[i]]]) +
      geom_rect(data=t, aes(xmin=p_start, xmax=p_end_n7, ymin=-Inf, ymax=Inf), alpha=0.5) + 
      geom_point(aes(x = date, y = daily), size = 2) +
      geom_line(data=tf.other[location_name %in% loc.groups[[i]]], aes(x=date, y=truth_sm, color=smooth_type), size=1.5, alpha=0.8)+
      geom_line(aes(x = date, y = truth_sm, color = smooth_type), size = 1.5, alpha = .8) +
      geom_vline(show.legend = F, aes(xintercept = ifelse(peak == 1, date, NA), color = smooth_type), linetype = "dashed") +
      facet_wrap(~location_name, nrow = 3, scales = "free") +
      theme +
      labs(x = "Month", y = "Daily Deaths") +
      coord_cartesian(xlim=c(ymd("2020-02-01"), ymd("2021-01-31"))) + 
      scale_color_discrete(name = "")
    print(p)
  }
  dev.off()
}

#--Identify Model peaks--------------

## Subset to locations with peaks identified in truth data
loc.peaks <- pf.t$location_name %>%
  unique() %>%
  sort()

df <- df[location_name %in% loc.peaks]

## Update loc.peaks
loc.peaks <- loc.peaks[loc.peaks %in% df$location_name]

## Smooth
df <- df[order(location_name, model, model_date, date)]
set <- df[, .(model, model_date, location_name)] %>% unique
smooth <- mclapply(1:nrow(set), function(x) {
  .model <- set[x]$model
  .model_date <- set[x]$model_date
  .location_name <- set[x]$location_name
  tp <- df[model==.model & model_date==.model_date & location_name==.location_name]
  tp[!is.na(deaths),deaths_sm := predict(loess(deaths ~ as.numeric(date), span = .33))]
  return(tp[, .(model, model_date, location_name, date, deaths_sm)])
}, mc.cores=2) %>% rbindlist

df <- merge(df, smooth, by=c("model", "model_date", "location_name", "date"), all.x=T)


## Find peaks
set <- df[, .(model, model_date, location_name)] %>% unique
peaks <- mclapply(1:nrow(set), function(x) {
  .model <- set[x]$model
  .model_date <- set[x]$model_date
  .location_name <- set[x]$location_name
  tp <- df[model==.model & model_date==.model_date & location_name==.location_name]
  peaks <- findpeak(tp$date, tp$deaths_sm, w=3, t=5)
  if (length(peaks)>0) {
    data.table(model=.model, model_date=.model_date, location_name=.location_name, peak_date=peaks)
  } else NULL
}, mc.cores=2) %>% rbindlist


peaks %>% setnames("peak_date", "date")
peaks[, peak := 1]

## Drop if peak < model_date
peaks <- peaks[date > model_date]

df <- merge(df, peaks, by=c("model", "model_date", "location_name", "date"), all.x=T)
df[is.na(peak), peak := 0]

## Merge on windows onto model date
q <- tf[, .(date, p_start, p_end_n7, n, location_name)]
q %>% setnames("n", "n_truth")
q %>% setnames("date", "model_date")
df <- merge(df, q, by=c("model_date", "location_name"), all.x=T)

#----------------------------------------

## Graph - Model daily deaths and peak dates
if (graph.peakcomparison) {
  
  plots <- mclapply(1:length(loc.peaks), function(x) { 
    
    .loc <- loc.peaks[x] %>% as.character()
  
    .max <- 1.5 * max(tf[location_name == .loc, truth_sm / 1000], na.rm = T)
    .mods <- df[location_name == .loc & peak == 1]$model %>% unique()
    
    .start <- min(tf[truth > 0 & location_name==.loc, date]) - 8
    .end <- max(df[location_name==.loc, date]) + 7
    
    d <- df[location_name == .loc & date > .start & model %in% .mods]
    t <- tf[location_name == .loc & date > .start]
    q <- tf[location_name == .loc, .(n, p_start, p_end_n7)] %>% unique
    
    .model_start <- min(d$model_date, na.rm=T)
    .model_end <- max(q$p_end_n7, na.rm=T) + 30
    
    ## Graph of daily death forecasts
    gg1 <- ggplot() +
      ## Model forecasts
      geom_line(data = d[date>model_date], aes(x = date, y = deaths_sm / 1000, group = model_date, color = model_long, alpha = model_date), size = 1, alpha=0.5) +
      ## Predicted peak
      geom_point(data = d[peak == 1], aes(x = date, y = deaths_sm / 1000, color = model_long), shape = 21, size = 2, fill = "white") +
      ## Truth
      geom_line(data = t, aes(x = date, y = truth_sm / 1000), shape = 21, fill = "white", color = "black") +
      ## True peak
      geom_vline(data = t[peak == 1], aes(xintercept = date), linetype = "dashed") +
      ## Settings
      scale_x_date(breaks = function(x) seq.Date(from = min(x) %>% floor_date("month"), to = max(x), by = "3 months"), date_labels = "%b") +
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
      geom_hline(data = t[peak == 1], aes(yintercept = date), linetype = "dashed") +
      ## Window
      geom_rect(data=q, aes(xmin=-Inf %>% as.Date, xmax=Inf %>% as.Date, ymin=p_start, ymax=p_end_n7), alpha=0.25) + 
      ## Predicted peaks
      geom_point(data = d[peak == 1], aes(x = date, y = model_date, color = model_long, fill = model_long)) +
      ## Settings
      scale_x_date(breaks = function(x) seq.Date(from = min(x) %>% floor_date("month"), to = max(x), by = "3 months"), date_labels = "%b") +
      scale_color_manual(values = c.vals, name = "") +
      scale_fill_manual(values = c.vals, name = "") +
      labs(y = "Model Date", x = "Actual and Predicted Peak") +
      theme_bw() +
      theme +
      theme(axis.text.x = element_text(size = 8, face = "bold")) + 
      guides(fill = F, color = F) +
      coord_cartesian(xlim = c(.start, .end), ylim= c(.model_start, .model_end)) +
      facet_wrap(~model_long, nrow = 1)
    
    gg <- plot_grid(gg1, gg2, align = "v", axis = "lr", ncol = 1, rel_heights = c(1, .5))
    
  }, mc.cores=1)
  
  ## Print
  pdf(paste0("visuals/Supplemental_Figures_Peak_Timing_", Sys.Date(), ".pdf"), width = 15, height = 6)
  for (i in 1:length(plots)) {
    print(paste0(i, "/", length(plots)))
    print(plots[[i]])
  }
  dev.off()

}

#--Predictive Validity on Peak---------------------------------------


## Subset to peak frame
pf <- df[peak == 1]

## Consider peaks within the window
pf[is.na(p_start), peak := 0]
pf[model_date < p_start, peak:= 0]
pf[model_date > p_end_n7, peak:=0]

pf <- pf[peak == 1]

## Merge on truth
pf <- merge(pf, pf.t, by=c("location_name", "n_truth"))

pf <- pf[, .(super_region_name, location_name, model, model_long, model_short, model_date, n_truth, date, date_truth)]

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
pf <- pf[order(model_date)]
pf[, model_month := format(model_date, format = "%b, %Y")]
vals <- pf$model_month %>% unique
pf[, model_month := factor(model_month, levels=vals, ordered=T)]

export(pf, "data/processed/peak.rds")

#-----------------------------------

peak.stats <- function(t, by) {
  t[, `:=`(num = uniqueN(location_name), me = median(error, na.rm = T), mae = median(abs_error, na.rm = T)), by = by]
  t <- t[, c(by, "num", "me", "mae"), with = F] %>% unique()
}

error.mod <- peak.stats(pf, by = c("model_short")) %>% mutate(wk = 0) %>% data.table()
error.m.wk <- peak.stats(pf, by = c("model_short", "model_month","wk"))%>% mutate(super_region_name = "Global") %>% data.table()
error.m.wk.sr <- peak.stats(pf, by = c("model_short", "model_month","wk","super_region_name"))
error.wk <- peak.stats(pf, by = c("model_short","wk"))%>% mutate(super_region_name = "Global") %>% mutate(model_month = "Total")%>% data.table()
pf.n <- pf[n_truth==3, n_truth := 2]
error.mod.n <- peak.stats(pf.n, by = c("model_short", "n_truth")) %>% mutate(wk = 0, n_truth = n_truth+1) %>% data.table()
error.mod.n[, disp := ifelse(n_truth==1, "Peak 1", "Peak 2-3")]

## Trim value
error.m.wk[, me_trm := me]
error.m.wk[, mae_trm := mae]
error.m.wk[me > 50, me_trm := 50]
error.m.wk[me < -50, me_trm := -50]
error.m.wk[mae > 50, mae_trm := 50]

#--Graph-------------------------------------------


if (graph.peakpv) {
  c.wks <- 8
  
  pdf(paste0("visuals/Figure_5_", Sys.Date(), ".pdf"), width = 3, height = 4)
  
  bar.mae <- scale_fill_gradient2(high = "#d73027", low = "#4575b4", mid = "#ffffbf", midpoint = 25, name = "", breaks = seq(0, 50, 25), labels = paste0(seq(0, 50, 25), " Days"), guide = guide_colorbar(barwidth = 10, barheight = .3), na.value = "white", limits = c(0, 50))
  bar.me <- scale_fill_gradient2(high = "#ef8a62", low = "#ef8a62", mid = "#67a9cf", midpoint = 0, name = "", breaks = seq(-50, 50, 50), labels = paste0(seq(-50, 50, 50), " Days"), guide = guide_colorbar(barwidth = 10, barheight = .3), na.value = "white", limits = c(-90, 90))
  
  # exclude models with less than 40 total locations for small sample size
  exclude.mods <- error.mod[num < 40, model_short]
  
  
  gg1 <- ggplot(error.wk[!(model_short %in% exclude.mods) & wk <= c.wks]) +
    geom_tile(aes(y = wk, x = model_short, fill = mae), alpha = 1.0) +
    facet_wrap(~model_month)+
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
    scale_y_continuous(breaks=seq(1,12)) +
    scale_x_discrete(expand = c(0, 0)) #
  
  
  
  print(gg1)
  dev.off()
  
  pdf(paste0("visuals/Supplemental_Figure_4_", Sys.Date(), ".pdf"), width = 6, height = 16)
  
  
  gg1 <- ggplot(error.m.wk[wk %in% 1:6  & !(model_short %in% exclude.mods)]) +
    geom_tile(aes(y = wk, x = model_short, fill = mae_trm), alpha = 1.0) +
    facet_grid(rows=vars(model_month),cols=vars(super_region_name),as.table = F,scales = "free_y")+
    geom_text(aes(y = wk, x = model_short, label = paste0(round(mae)))) +
    theme + 
    theme(
      axis.text.x=element_text(angle=30,face="bold",size=10,hjust=1),
      strip.text.x=element_text(face="bold",size=9),
      strip.text.y=element_text(face="bold",size=9),
      plot.title=element_text(face="bold",size=10)
    )+
    xlab("") +
    labs(y = "Forecasting Weeks", title = "A) Accuracy - Median Absolute Error") +
    bar.mae +
    scale_y_continuous(breaks=seq(1,6)) +
    scale_x_discrete(expand = c(0, 0)) #
  
  gg2 <- ggplot(error.m.wk[wk %in% 1:6  & !(model_short %in% exclude.mods)]) +
    geom_tile(aes(y = wk, x = model_short, fill = me), alpha = 1.0) +
    facet_grid(rows=vars(model_month),cols=vars(super_region_name),as.table = F,scales = "free_y")+
    geom_text(aes(y = wk, x = model_short, label = paste0(round(me)))) +
    theme + 
    theme(
      axis.text.x=element_text(angle=30,face="bold",size=10,hjust=1),
      strip.text.x=element_text(face="bold",size=9),
      strip.text.y=element_text(face="bold",size=9),
      plot.title=element_text(face="bold",size=10)
    )+
    xlab("") +
    labs(y = "Forecasting Weeks", title = "B) Bias - Median Error") +
    bar.me +
    scale_y_continuous(breaks=seq(1,6)) +
    scale_x_discrete(expand = c(0, 0)) #
  
  
  grid.arrange(gg1,gg2,nrow=1)
  dev.off()
  
  
  c.vals.n <- c(
    "Delphi" = "#e31a1c",
    "IHME" = "#33a02c",
    "LANL" = "#1f78b4",
    "YYG" = "#ff7f00",
    "Imperial" = "#fb9a99",
    "SIKJalpha" = "#FF1493", 
    "UCLA-ML" = "#cab2d6",
    "Pooled" = "grey"
  )
  
  a.vals.n <- c(
    "Peak 1" = 0.4,
    "Peak 2-3" = 1
  )
  
  
pdf(paste0("visuals/peak_error_n_", Sys.Date(), ".pdf"), width = 10, height = 5)
  
 gg1<- ggplot(error.mod.n[num>5 & n_truth <=2]) +
    geom_col(aes(x=model_short, y=mae, fill=model_short, alpha=disp, group=n_truth), width=0.7, position=position_dodge(width=0.8, preserve="single")) +
   theme + 
    theme(
      axis.text.x=element_text(angle=30,face="bold",size=10,hjust=1),
      strip.text.x=element_text(face="bold",size=9),
      strip.text.y=element_text(face="bold",size=9),
      plot.title=element_text(face="bold",size=10),
      legend.position="none"
    )+
   scale_fill_manual(values = c.vals.n, name = "") +
   scale_alpha_manual(values = a.vals.n, name = "") +
    xlab("") +
    coord_cartesian(ylim=c(0, 30)) + 
    labs(y = "Median Absolute Error (Days)", title = "A) Accuracy - Median Absolute Error") 
  
  gg2 <- ggplot(error.mod.n[num>5 & n_truth <=2]) +
    geom_col(aes(x=model_short, y=me, fill=model_short, alpha=disp, group=n_truth), width=0.7, position=position_dodge(width=0.8, preserve="single")) +
    theme + 
    theme(
      axis.text.x=element_text(angle=30,face="bold",size=10,hjust=1),
      strip.text.x=element_text(face="bold",size=9),
      strip.text.y=element_text(face="bold",size=9),
      plot.title=element_text(face="bold",size=10),
      legend.position="right"
    )+
    labs(fill="Peak Number") + 
    scale_fill_manual(values = c.vals.n, name = "") +
    scale_alpha_manual(values = a.vals.n, name = "") +
    guides(fill=FALSE) + 
    xlab("") +
    labs(y = "Median Error (Days)", title = "B) Bias - Median Error") 
  
  plot_grid(gg1, gg2, rel_widths = c(0.8, 1), ncol=2)
  
  dev.off()
  

  
}




