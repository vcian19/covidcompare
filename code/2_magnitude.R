# ##############################################################################
# Purpose:  Compare and Graph COVID-19 Models - Mortality Magnitude
# Authors:   Joseph Friedman & Patty Liu
# Reviewer: Austin Carter
# ##############################################################################

## Setup
rm(list = ls())
source("code/_init.r")
source("code/_collate.r")

# set which graphs to produce
graph <- 1 ## Any graph
r.forecast_plots <- 1 ## Country specific forecast plots (Figure 1)
number.plug <- 1

# Plot Colors
c.vals <- c(
  "Delphi" = "#e31a1c",
  "IHME" = "#33a02c",
  "Los Alamos Nat Lab" = "#1f78b4",
  "Youyang Gu" = "#ff7f00",
  "Imperial" = "#fb9a99",
  "SIKJalpha" = "#FF1493", 
  "UCLA-ML" = "#cab2d6"
)

#--DATA SETUP-------------------------------------------------

# Load Data
data <- collate.data()

# Drop Ecuador and Peru from framework given known issues in data
data <- data[!(location_name%in%c("Peru","Ecuador"))]

# Remove floating data
data <- data[!(is.na(model))]

# Locations for which we will estimate
locs <- fread("data/ref/locs_ihme.csv")[, c("location_name", "ihme_loc_id", "region_name", "super_region_name")]
locs.list <- locs[nchar(ihme_loc_id) == 3 | grepl(x = ihme_loc_id, pattern = "USA_")]

# Get most current run
cur <- data[, .(model_date = max(model_date)), by = .(model)]
cur[, current := 1]
data <- merge(data, cur, all.x = T, by = c("model", "model_date"))

# Latest total death toll from each current model on last date
data[,max_mod_date:=max(date),by=.(model_short)]

# Add first and last model date by location-model
data[, min_model_date := min(model_date, na.rm = T), by = .(location_name, model)]
data[, max_model_date := max(model_date, na.rm = T), by = .(location_name, model)]

# Last data point in truth
lst.truth <- max(data[!is.na(truth), date], na.rm = T)

# Identify points at n weeks out from model_date to predict
for (i in seq(0, 12)) {
  data[date == model_date + 7 * i, errwk := i]
  ## Create flag for 4 week window
  max.date <- data[errwk==i & !is.na(truth)]$model_date %>% max
  data[errwk==i & !is.na(truth) & model_date >= max.date-28, wkflag := 1]
}
data[is.na(wkflag), wkflag := 0]

# Create timeshfited cum_deaths series
shifts <- data[date == model_date]
shifts[, shift := truth - deaths_cum]
shifts <- shifts[, c("location_name", "model", "model_date", "shift")] %>% unique()
data <- merge(data, shifts, by = c("location_name", "model", "model_date"), all.x = T)
data[!is.na(shift), deaths_cum_shifted := deaths_cum + shift]

# Model month
data <- data[order(model_date)]
data[, model_month := format(model_date, format = "%b, %Y")]
vals <- data$model_month %>% unique
data[, model_month := factor(model_month, levels=vals, order=T)]

data[, model_week := format(model_date, format = "%W")]

# Calculate number of model iterations per month
data[,iter_num:=uniqueN(model_date),by=.(model,model_month)]

# Remove wonky IHME point
data <- data[!(model_long == "IHME" & model_date == "2020-05-29" & location_name == "United States")]

#--CALCULATE ERROR-----------------------------------

# calculate error - no missings, and more than 1 model iteration for the month in question
errors <- data[!is.na(errwk) & !is.na(truth)&iter_num>1]
errors[, error := deaths_cum_shifted - truth]

# Weekly error
errors <- errors[order(location_name, model, model_date, errwk)]
errors[, truth_wk := truth - shift(truth), by = .(location_name, model, model_date)]
errors[, deaths_cum_shifted_wk := deaths_cum_shifted - shift(deaths_cum_shifted), by = .(location_name, model, model_date)]
errors[, wkly_error := deaths_cum_shifted_wk - truth_wk]
errors <- errors[errwk != 0]

# Error stats by location-model-errwk-model_date
errors[, abs_error := abs(error)]
errors[, per_error := (error / truth) * 100]
errors[, abs_per_error := abs(per_error)]

# Errors stats by weekly Weekly
errors[, wkly_abs_error := abs(wkly_error)]
errors[, wkly_per_error := (wkly_error / truth_wk) * 100]
errors[, wkly_abs_per_error := abs(wkly_per_error)]

#----collapse to location specific errors for Figure 1 and Other Country Specific Plots------------------------------------------------------------------------

# cumulative
lme.errors <- errors[, .(
  me = median(error, na.rm = T),
  mae = median(abs_error, na.rm = T),
  mape = median(abs_per_error, na.rm = T),
  mpe = median(per_error)
), by = .(model, model_long, location_name, errwk,model_month)]

lme.errors.l <- melt.data.table(lme.errors, id.vars = c("model", "model_long", "location_name", "errwk","model_month"))

lme.errors.l[variable == "mape", variable := "Median Absolute Percent Error"]
lme.errors.l[variable == "me", variable := "Median Error"]
lme.errors.l[variable == "mpe", variable := "Median Percent Error"]
lme.errors.l[variable == "mae", variable := "Median Absolute Error"]
lme.errors.l[, model_month := factor(model_month, levels=vals, order=T)]

# weekly
wkly.lme.errors <- errors[, .(
  me = median(error, na.rm = T),
  mae = median(wkly_abs_error, na.rm = T),
  mape = median(wkly_abs_per_error, na.rm = T),
  mpe = median(wkly_per_error)
), by = .(model, model_long, location_name, errwk,model_month)]

wkly.lme.errors.l <- melt.data.table(wkly.lme.errors, id.vars = c("model", "model_long", "location_name", "errwk","model_month"))

wkly.lme.errors.l[variable == "mape", variable := "Median Absolute Percent Error"]
wkly.lme.errors.l[variable == "me", variable := "Median Error"]
wkly.lme.errors.l[variable == "mpe", variable := "Median Percent Error"]
wkly.lme.errors.l[variable == "mae", variable := "Median Absolute Error"]

#--COLLAPSE ERRORS------------------------------------------

me <- errors[, .(location_name, super_region_name, model_short, model_month, errwk, wkflag, truth, truth_wk, error, wkly_error)]
id <- c("location_name", "super_region_name", "model_short", "model_month", "errwk", "wkflag", "truth", "truth_wk")
me <- me %>% melt(., id.vars=id, value.name="error", variable.name="err_type")

me[, abs_error := abs(error)]
me[err_type == "wkly_error", per_error := (error / truth_wk) * 100]
me[err_type != "wkly_error", per_error := (error / truth) * 100]
me[, abs_per_error := abs(per_error)]

#remove infinite errors (dividing by zero)
me <- me[(is.finite(per_error))&(is.finite(abs_per_error))]

## Pooled
pool <- me %>% copy
pool <- pool[, model_short:="Pooled"]
me <- rbind(me, pool)

## Metrics by
metrics.by <- function(df, by) {
  df[is.finite(error), .(
    me = median(error, na.rm = T),
    mae = median(abs_error, na.rm = T),
    mape = median(abs_per_error, na.rm = T),
    mpe = median(per_error, na.rm = T),
    loc_n = uniqueN(location_name)
  ), by = by]
}

## Approach 1 : Most recent model errors by 4 week windows

## Global
me.4w.g <- metrics.by(me, by=c("err_type", "model_short", "errwk", "wkflag")) %>%
          mutate(super_region_name="Global")
## Super Region
me.4w.sr <- metrics.by(me, by=c("err_type", "model_short", "errwk", "wkflag", "super_region_name"))
## Total: Subset to 4 week window (wkflag == 1)
me.4w.t <- rbind(me.4w.g, me.4w.sr) 
me.4w.t <- me.4w.t[wkflag==1]; me.4w.t$wkflag <- NULL
me.4w.t[, approach := "recent"]
me.4w.t[, model_month := "N/A"]


## Approach 2 : Monthly model errors

## Global
me.m.g <-  metrics.by(me, by=c("model_month", "model_short", "err_type", "errwk")) %>%
  mutate(super_region_name="Global")
## Super Region
me.m.sr <- metrics.by(me, by=c("model_month", "model_short", "err_type", "errwk", "super_region_name"))
## Total
me.m.t <- rbind(me.m.g, me.m.sr)
me.m.t[, approach := "monthly"]

## Combine
me.t <- rbind(me.m.t, me.4w.t)

## Clean labels
id <- c("model_month", "model_short", "err_type", "errwk", "loc_n", "super_region_name", "approach")
me.t <- melt(me.t, id.vars=id)
## Subset to where loc_n > 5
me.t <- me.t[loc_n > 5]
## Trim value
me.t[, value_trm2 := value]
me.t[variable %in% c("mape", "mpe") & value > 100, value_trm2 := 100]
me.t[variable %in% c("mape", "mpe") & value < -100, value_trm2 := -100]
me.t[variable %in% c("mae") & value > 1000, value_trm2 := 1000]

me.t[, value_trm := value]
me.t[variable %in% c("mape", "mpe") & value > 50, value_trm := 50]
me.t[variable %in% c("mape", "mpe") & value < -50, value_trm := -50]
me.t[variable %in% c("mae") & value > 1000, value_trm := 1000]


# Super Region
me.t[, srn2 := super_region_name]
me.t[srn2 == "Central Europe, Eastern Europe, and Central Asia", srn2 := "Eastern Europe, Central Asia"]
me.t[srn2 == "Southeast Asia, East Asia, and Oceania", srn2 := "Southeast, East Asia, Oceania"]
# Display 
me.t[variable == "mape", disp := "Median Absolute Percent Error"]
me.t[variable == "me", disp := "Median Error"]
me.t[variable == "mpe", disp := "Median Percent Error"]
me.t[variable == "mae", disp := "Median Absolute Error"]
## Month
me.t[, model_month := factor(model_month, levels=vals, order=T)]

## Save
saveRDS(me.t, "data/processed/magnitude.rds")

#--GRAPH----------------------------------------

if (graph) {
  
## Tile plots for errors BY
plot.tile <- function(df, global=F, var, err, facet=F) {
  
    p <- ggplot(df[variable==var & err_type==err], aes(y = errwk, x = model_short, fill = value_trm, label = paste0(round(value, 0), "%"))) +
      geom_tile(alpha = 1) +
      geom_text(size = 2.9) +
      facet_wrap(~srn2,scales="free_y",ncol=2) 
  
  if (global) {
    x.title <- element_blank()
    x.text <-  element_text(size = 8, angle = 0,  face = "bold")
  } else {
    x.title <- element_text(size = 9, face = "bold")
    x.text <- element_text(size = 9, angle = 45, hjust = 1, face = "bold")
  }
  
  p <- p + 
    labs(y = "Forecasting Weeks", x = "Model") +
    scale_y_continuous(breaks=seq(1,12)) +
    theme_bw() + 
    theme(
      strip.background = element_rect(fill = "white"),
      axis.title.x = x.title, 
      axis.title.y = element_text(size = 9, face = "bold"), plot.title = element_text(size = 12, face = "bold"),
      axis.text.x = x.text,
      axis.text.y = element_text(size = 9, face = "bold"), legend.position = "top"
    )
  
  # if (var=="mpe") p <- p + scale_fill_gradient2(high = "#d73027", low = "#d73027", mid = "#4575b4", midpoint = 0, name = "", breaks = seq(-100, 100, 50), labels = c("<-100%",paste0(seq(-50, 50, 50), "%"),">100%"), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(-100, 100))
  # if (var=="mape") p <- p + scale_fill_gradient2(high = "#d73027", low = "#4575b4", mid = "#ffffbf", midpoint = 45, name = "", breaks = seq(0, 100, 10), labels = c(paste0(seq(0, 90, 10), "%"),">100%"), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(0, 100))
  # 
   if (var=="mpe") p <- p + scale_fill_gradient2(high = "#d73027", low = "#d73027", mid = "#4575b4", midpoint = 0, name = "", breaks = seq(-50, 50, 25), labels = c("<-50%",paste0(seq(-50, 50, 50), "%"),">50%"), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(-50, 50))
  if (var=="mape") p <- p + scale_fill_gradient2(high = "#d73027", low = "#4575b4", mid = "#ffffbf", midpoint = 25, name = "", breaks = seq(0, 50, 5), labels = c(paste0(seq(0, 45, 5), "%"),">50%"), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(0, 50))
  
  return(p)
}

## Tile plots: Most Recent: MAPE/MPE by Error Type
pdf(paste0("visuals/tile_recent_", Sys.Date(), ".pdf"), width = 6, height = 10 )
for (err in c("error", "wkly_error")) {
for (var in c("mape", "mpe")) {
  disp.var <- ifelse(var=="mape", "Median Absolute Percent Error", "Median Absolute Error")
  disp.err <- ifelse(err=="error", "Total Cumulative Error", "Weekly Error")
  p.g <- me.t[super_region_name=="Global" & approach=="recent"] %>% 
    plot.tile(., var=var, err=err, global=T) + ggtitle(paste0(disp.err, " (4 Week Window) \n", disp.var))
  p.sr <- me.t[super_region_name!="Global" & approach=="recent"] %>% 
    plot.tile(., var=var, err=err) + theme(legend.position="none")
  gg <- plot_grid(p.g,p.sr,rel_heights = c(1.5,2),align='v',axis='lr',ncol=1)
  print(gg)
}
}
dev.off()


## Tile plots: Monthly: MAPE/MPE by Error Type
month <- "Oct, 2020"
pdf(paste0("visuals/tile_monthly_", month, "_", Sys.Date(), ".pdf"), width = 6, height = 10 )
for (err in c("error", "wkly_error")) {
  for (var in c("mape", "mpe")) {
    disp.var <- ifelse(var=="mape", "Median Absolute Percent Error", "Median Absolute Error")
    disp.err <- ifelse(err=="error", "Total Cumulative Error", "Weekly Error")
    p.g <- me.t[super_region_name=="Global" & approach=="monthly" & model_month==month] %>% 
      plot.tile(., var=var, err=err, global=T) + ggtitle(paste0(disp.err, " (Models from ", month, ") \n", disp.var))
    p.sr <- me.t[super_region_name!="Global" & approach=="monthly" & model_month==month] %>% 
      plot.tile(., var=var, err=err) + theme(legend.position="none")
    gg <- plot_grid(p.g,p.sr,rel_heights = c(1.5,2),align='v',axis='lr',ncol=1)
    print(gg)
  }
}
dev.off()


#--Tile plot helper--------------------------------------------

## Frame for model date ranges using Most Recent approach
df.recent <- data[!is.na(errwk)&wkflag==1 & errwk>0, .(errwk, model_date)] %>% unique
df.recent[, min := min(model_date), by=errwk]
df.recent[, max := max(model_date), by=errwk]
df.recent <- df.recent[, .(errwk, min, max)] %>% unique
df.recent[, mid := max]
df.recent[, mid.end := mid + errwk*7]
df.recent[, errwk := paste0(errwk, " weeks") %>% factor(., levels=paste0(1:12, " weeks"), ordered=T)]

## Frame for model date ranges using Monthly approach
df.monthly <- data.table(errwk=1:12 %>% rev)
df.monthly[, min := ymd("2020-10-01")]
df.monthly[, max:= ymd("2020-10-31")]
df.monthly[, mid := max]
df.monthly[, mid.end := mid + errwk*7]
df.monthly[, errwk := paste0(errwk, " weeks") %>% factor(., levels=paste0(1:12, " weeks"), ordered=T)]

p.recent <- ggplot(df.recent) + 
  geom_segment(aes(x=min, xend=max, y=errwk, yend=errwk), size=4) +
  geom_segment(aes(x=mid, xend=mid.end, y=errwk, yend=errwk)) +
  geom_point(aes(x=mid.end, y=errwk)) + 
  xlim(c(ymd("2020-09-15"), ymd("2021-01-31"))) + 
  scale_y_discrete(position="right") + 
  bbc_style() + 
  ylab("N weeks forecasting") + 
  ggtitle('"Most Current" Analytical Approach') +
  theme(axis.text.y=element_text(size=10), plot.title = element_text(size = 17))

p.monthly <- ggplot(df.monthly) +
  geom_segment(aes(x=min, xend=max, y=errwk, yend=errwk), size=4) +
  geom_segment(aes(x=mid, xend=mid.end, y=errwk, yend=errwk)) +
  geom_point(aes(x=mid.end, y=errwk)) + 
  xlim(c(ymd("2020-09-15"), ymd("2021-01-31"))) + 
  scale_y_discrete(position="right") + 
  bbc_style() + 
  ylab("N weeks forecasting") + 
  ggtitle('"Month Stratified" Analytical Approach')+
  theme(axis.text.y=element_text(size=10), plot.title = element_text(size = 17))


pdf(paste0("visuals/tile_helper_", Sys.Date(), ".pdf"), width = 8, height = 6)
plot_grid(p.recent, p.monthly, ncol=1)
dev.off()






#-------SUPPLEMENTAL FIGURES 1-2-3-----------------------------------

pdf(paste0("visuals/tile_allmonth_", Sys.Date(), ".pdf"), width = 16, height = 16)

c.wks <- 12
c.var <- "Median Absolute Percent Error"
months <- data$model_month %>% unique %>% .[!(.%in%c("Mar, 2020"))]
for (c.var in c("mape", "mpe", "mae")) {
  for (c.tp in c("error", "wkly_error")) {
    
    disp.var <- ifelse(c.var=="mape", "Median Absolute Percent Error", ifelse(c.var=="mpe", "Median Percent Error", "Median Absolute Error"))
    disp.err <- ifelse(c.tp=="error", "Total Cumulative Error", "Weekly Error")
    
    print(c.var)
    print(disp.var)
    print(c.tp)
    print(disp.err)
    
    
    data1 <- me.t[approach=="monthly" & srn2!="Global"&loc_n > 5 & variable == c.var & err_type == c.tp&model_month%in%months&errwk<=c.wks]
    gg1 <- ggplot(data1, aes(y = errwk, x = model_short, fill = value_trm2, label = round(value))) +
      geom_tile(alpha = 1) +
      theme_bw() +
      facet_grid(row=vars(model_month),cols=vars(srn2),scales="free_y",switch="y",as.table=F) +
      geom_text(size = 2.6) +
      labs(y = "Forecasting Weeks", x = "Model", title = paste0(disp.err, " - ", disp.var)) +
      theme(
        axis.title.x = element_text(size = 9, face = "bold"), strip.background = element_rect(fill = "white"),
        axis.title.y = element_text(size = 9, face = "bold"), plot.title = element_text(size = 12, face = "bold"),
        axis.text.x = element_text(size = 9, angle = 45, hjust = 1, face = "bold"),
        axis.text.y = element_text(size = 9, face = "bold"), legend.position = "top"
      ) +
      scale_fill_gradient2(high = "#d73027", low = "#4575b4", mid = "#ffffbf", midpoint = 45, name = "", breaks = seq(0, 100, 10), labels = paste0(seq(0, 100, 10), "%"), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(0, 100))+
      scale_y_continuous(breaks=seq(1,12))
    
    data2 <- me.t[approach=="monthly"&srn2=="Global" &loc_n > 5 & variable == c.var & err_type == c.tp&model_month%in%months&errwk<=c.wks]
    gg2 <- ggplot(data2, aes(y = errwk, x = model_short, fill = value_trm2, label = round(value))) +
      geom_tile(alpha = 1) +
      theme_bw() +
      facet_grid(row=vars(model_month),cols=vars(srn2),scales="free_y",as.table=F) +
      geom_text(size = 2.6) +
      labs(y = "", x = "", title = "") +
      theme(
        axis.title.x = element_text(size = 9, face = "bold"), strip.background = element_rect(fill = "white"),
        axis.title.y = element_text(size = 9, face = "bold"), plot.title = element_text(size = 12, face = "bold"),
        axis.text.x = element_text(size = 9, angle = 45, hjust = 1, face = "bold"),
        axis.text.y = element_blank(), legend.position = "none"
      ) +
      scale_fill_gradient2(high = "#d73027", low = "#4575b4", mid = "#ffffbf", midpoint = 45, name = "", breaks = seq(0, 100, 10), labels = paste0(seq(0, 100, 10), "%"), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(0, 100))+
      scale_y_continuous(breaks=seq(1,12))
    
    
    if (c.var=="mpe") {
      gg1 <- gg1 +scale_fill_gradient2(high = "#d73027", low = "#d73027", mid = "#4575b4", midpoint = 0, name = "", breaks = seq(-100, 100, 20), labels = paste0(seq(-100, 100, 20), "%"), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(-100, 100))
      gg2 <- gg2 +scale_fill_gradient2(high = "#d73027", low = "#d73027", mid = "#4575b4", midpoint = 0, name = "", breaks = seq(-100, 100, 20), labels = paste0(seq(-100, 100, 20), "%"), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(-100, 100))
    }  
    
    if (c.var=="mae" & c.tp =="error") {
      gg1 <- gg1 +scale_fill_gradient2(high = "#d73027", low = "#4575b4", mid = "#ffffbf", midpoint = 500, name = "", breaks = seq(0, 1000, 200), labels = seq(0, 1000, 200), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(0, 1000))
      gg2 <- gg2 +scale_fill_gradient2(high = "#d73027", low = "#4575b4", mid = "#ffffbf", midpoint = 500, name = "", breaks = seq(0, 1000, 200), labels = seq(0, 1000, 200), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(0, 1000))
    }
    if (c.var=="mae" & c.tp =="wkly_error") {
      gg1 <- gg1 +scale_fill_gradient2(high = "#d73027", low = "#4575b4", mid = "#ffffbf", midpoint = 150, name = "", breaks = seq(0, 300, 50), labels = seq(0, 300, 50), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(0, 300))
      gg2 <- gg2 +scale_fill_gradient2(high = "#d73027", low = "#4575b4", mid = "#ffffbf", midpoint = 150, name = "", breaks = seq(0, 300, 50), labels = seq(0, 300, 50), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(0, 300))
    }
    
    gg <- plot_grid(gg1,gg2,rel_widths = c(1,.2),align='h',axis='tb')
    print(gg)
  }
}
dev.off()

#-------Figure 1 and Country-Specific Magnitude Plots -----------------------------------

# set graphing order based on number of cum deaths
c.for <- max(data[!is.na(truth), date])

ord <- data[date == c.for]
ord <- ord[, .(deaths_cum = mean(truth, na.rm = T)), by = .(location_name)]
ord <- ord[order(-deaths_cum)]
locs.list.ord <- merge(locs.list, ord, all = T, by = "location_name")
locs.list.ord <- locs.list.ord[order(-deaths_cum)]

lme.errors.l[variable %in% c("Median Error"), variable := "Med Err"]
lme.errors.l[variable %in% c("Median Absolute Error"), variable := "Med Abs Err"]

c.vals <- c(
  "Delphi" = "#e31a1c",
  "IHME" = "#33a02c",
  "Los Alamos Nat Lab" = "#1f78b4",
  "Youyang Gu" = "#ff7f00",
  "Imperial" = "#fb9a99",
  "SIKJalpha" = "#FF1493", 
  "UCLA-ML" = "#cab2d6"
)

if (r.forecast_plots == 1) {
  
plots <- mclapply(ord[deaths_cum>10, location_name], function(c.loc) {
  # check if US state
  is.state <- ifelse(c.loc %in% locs[grepl(x = ihme_loc_id, pattern = "USA_"), location_name], 1, 0)
  
  # get start date
  c.start <- min(data[location_name == c.loc & truth > 0, date]) - 8
  c.for <- max(data[location_name == c.loc & !is.na(truth), date])
  c.end <- c.for + 127
  
  # Current Forecasts
  # scale y axis to 110% of non-Imperial max model value (prevent scale blowout)
  #c.max <- 1.1 * max(data[current == 1 & location_name == c.loc & date < c.end & date > c.start & !is.na(model) & !(model_long %in% c("Imperial", "SIKJalpha")), upper_cum / 1000], na.rm = T)
  c.max <- .98 * max(data[current == 1 & location_name == c.loc & date < c.end & date > c.start & !is.na(model), upper_cum / 1000], na.rm = T)
  
  gg1 <- ggplot(
    data[current == 1 & location_name == c.loc & date < c.end & date >= c.for & !is.na(model_long) & !(model_long %in% c("IHME - CF SEIR","IHME - Curve Fit"))],
    aes(x = date, color = model_long, fill = model_long)
  ) +
    geom_line(aes(y = deaths_cum / 1000), size = 1.5) +
    geom_ribbon(aes(y = deaths_cum / 1000, ymin = lower_cum / 1000, ymax = upper_cum / 1000), alpha = .3, color = NA) +
    theme_bw() +
    geom_line(data = data[location_name == c.loc & date > c.start & date < c.end & !is.na(model)], fill = "white", color = "black", aes(y = jhu / 1000, shape = "JHU"), size=1.5) +
    geom_line(data = data[location_name == c.loc & date > c.start & date < c.end & !is.na(model)], fill = "white", color = "black", aes(y = nyt / 1000, shape = "NYT"), size=1.5) +
    geom_vline(xintercept = c.for, linetype = "longdash", alpha = .5) +
    scale_x_date(
      breaks = function(x) seq.Date(from = min(x) %>% floor_date("month"), to = max(x), by = "1 months"),
      date_labels = "%b"
    ) +
    labs(y = "Deaths (Thousands)", x = "Week of", title = "Current Forecast") +
    theme(
      plot.title = element_text(size = 12, face = "bold"),
      axis.title.x = element_text(size = 10, face = "bold"),
      axis.text.y = element_text(size = 10, face = "bold"),
      strip.text.x = element_text(size = 10, face = "bold"), 
      legend.position = "top", legend.margin=unit(0, "cm"),
      legend.text = element_text(size = 8)
    ) +
    scale_color_manual(values = c.vals, name = "") +
    scale_fill_manual(values = c.vals, name = "") +
    scale_shape_manual(name = "", values = c("JHU" = 21, "NYT" = 24)) +
    coord_cartesian(ylim = c(0, c.max)) +
    guides(fill=FALSE)
  # remove shape legend if not a US state
  if (is.state == 0) {
    gg1 <- gg1 + guides(shape = F)
  }
  
  # All historical versions    #, "SIKJalpha"
  
  #c.max <- 1.1 * max(data[location_name == c.loc & date < c.end & date > c.start & !is.na(model_long) & !(model_long %in% c("Imperial")), deaths_cum / 1000], na.rm = T)
  c.max <- 1.1 * max(data[location_name == c.loc & date < c.end & date > c.start & !is.na(model_long), deaths_cum / 1000], na.rm = T)
  
  gg2 <- ggplot(
    data[location_name == c.loc & date < c.end & date > c.start & !is.na(model_long)],
    aes(x = date, color = model_long, fill = model_long)
  ) +
    theme_bw() +
    geom_line(aes(y = deaths_cum / 1000, alpha = model_date, group = model_date), size = 2) +
    facet_wrap(~model_long, nrow = 1) +
    geom_line(data = data[location_name == c.loc & date > c.start & date < c.end & !is.na(model) & model != "Ensemble"], fill = "white", color = "black", aes(y = jhu / 1000, shape = "JHU")) +
    geom_line(data = data[location_name == c.loc & date > c.start & date < c.end & !is.na(model) & model != "Ensemble"], fill = "white", color = "black", aes(y = nyt / 1000, shape = "NYT")) +
    geom_vline(aes(xintercept = min_model_date), linetype = "longdash", alpha = .5) +
    geom_vline(aes(xintercept = max_model_date), linetype = "longdash", alpha = .5) +
    scale_x_date(
      breaks = function(x) seq.Date(from = min(x) %>% floor_date("month"), to = max(x), by = "2 months"),
      date_labels = "%b"
    ) +
    labs(y = "Deaths (Thousands)", x = "Week of", title = "All Model Versions") +
    theme(
      plot.title = element_text(size = 12, face = "bold"),
      axis.title.x = element_blank(), legend.title = element_blank(),
      axis.text.y = element_text(size = 10, face = "bold"), strip.background = element_rect(fill = "white"),
      strip.text.x = element_text(size = 10, face = "bold"), legend.position = "none"
    ) +
    scale_color_manual(values = c.vals, name = "") +
    scale_fill_manual(values = c.vals, name = "") +
    guides(color = F, fill = F) +
    scale_shape_manual(name = "", values = c("JHU" = 21, "NYT" = 24)) +
    coord_cartesian(ylim = c(0, c.max))
  
  
  # All Errors
  c.max <- 1.1 * max(errors[location_name == c.loc & date < c.end & date > c.start & !is.na(model_long) & !(model_long %in% c("Imperial", "SIKJalpha")), error / 1000], na.rm = T)
  c.min <- 1.1 * min(errors[location_name == c.loc & date < c.end & date > c.start & !is.na(model_long) & !(model_long %in% c("Imperial", "SIKJalpha")), error / 1000], na.rm = T)
  
  gg3 <- ggplot(
    errors[location_name == c.loc & date < c.end & date > c.start & !is.na(model_long)],
    aes(x = date, color = model_long, fill = model_long, y = error / 1000)
  ) +
    theme_bw() +
    geom_hline(yintercept = 0, alpha = .7) +
    facet_wrap(~model_long, nrow = 1) +
    geom_point() +
    geom_vline(aes(xintercept = min_model_date), linetype = "longdash", alpha = .5) +
    geom_vline(aes(xintercept = max_model_date), linetype = "longdash", alpha = .5) +
    scale_x_date(
      limits = c(c.start, as.Date(c.end)), breaks = function(x) seq.Date(from = c.start %>% floor_date("month"), to = as.Date(c.end), by = "2 months"),
      date_labels = "%b"
    ) +
    labs(y = "Deaths (Thousands)", x = "Month", title = "All Cumulative Errors") +
    theme(
      plot.title = element_text(size = 12, face = "bold"),
      axis.title.x = element_text(size = 10, face = "bold"), legend.title = element_blank(),
      axis.text.y = element_text(size = 10, face = "bold"), strip.background = element_rect(fill = "white"),
      strip.text.x = element_text(size = 10, face = "bold"), legend.position = "none"
    ) +
    scale_color_manual(values = c.vals, name = "") +
    scale_fill_manual(values = c.vals, name = "") +
    guides(color = F, fill = F) +
    coord_cartesian(ylim = c(c.min, c.max))
  
  
  lme.errors.l[variable %in% c("Med Err", "Median Percent Error"), add_line := 0]
  
  # Average Error
  c.max <- 1.1 * max(lme.errors.l[location_name == c.loc & variable %in% c("Med Err", "Med Abs Err") & !(model_long %in% c("Imperial", "SIKJalpha")), value / 1000], na.rm = T)
  c.min <- min(lme.errors.l[location_name == c.loc & variable %in% c("Med Err", "Med Abs Err") & !(model_long %in% c("Imperial", "SIKJalpha")), value / 1000], na.rm = T)
  
  gg4 <- ggplot(
    lme.errors.l[location_name == c.loc & variable %in% c("Med Err", "Med Abs Err")&model_month%in%c("Sep, 2020", "Oct, 2020", "Nov, 2020", "Dec, 2020", "Jan, 2021") & errwk <= 6],
    aes(x = errwk, y = value / 1000, color = model, fill = model_long)
  ) +
    geom_hline(aes(yintercept = add_line), alpha = .7) +
    geom_bar(stat = "identity", position = position_dodge(width = .7)) +
    facet_grid(cols=vars(model_month),rows=vars(variable), scales = "free",as.table=F) +
    theme_bw() +
    scale_x_continuous(breaks = seq(1, 6)) +
    labs(y = "Deaths (Thousands)", x = "Weeks Forecasting", title = paste0("Cumulative Out-Of-Sample Error\n(Post Intercept Shift)\n")) +
    theme(
      plot.title = element_text(size = 12, face = "bold"),
      axis.title.x = element_text(size = 10, face = "bold"), axis.title.y = element_text(size = 10, face = "bold"),
      axis.text.y = element_text(size = 10, face = "bold"), strip.background = element_rect(fill = "white"),
      strip.text.x = element_text(size = 10, face = "bold"),strip.text.y = element_text(size = 10, face = "bold"), legend.position = "none"
    ) +
    scale_color_manual(values = c.vals, name = "") +
    scale_fill_manual(values = c.vals, name = "") 
  #+coord_cartesian(ylim = c(c.min, c.max))
  
  
  lay <- rbind(
    c(1, 1,  4, 4),
    c(1, 1,  4, 4),
    c(2, 2,  2, 2),
    c(3, 3,  3, 3)
  )
  
  grid.arrange(gg1, gg2, gg3, gg4, top = textGrob(paste0(c.loc), gp = gpar(fontsize = 20, fontface = "bold")), ncol = 2, layout_matrix = lay)
  
}, mc.cores=4)


pdf(paste0("visuals/country_forecast_", Sys.Date(), ".pdf"), width = 15, height = 10)
for (i in 1:length(plots)) {
  print(paste0(i, "/", length(plots)))
  grid.draw(plots[[i]])
  grid.newpage()
}
dev.off()

}
}

#-------------number plug------------------------------------------------------------

if (number.plug) {
  
# Collectively models covered 171 countries, as well as the 50 states of the United States, and Washington, D.C.,
# and accounted for >99% of all reported COVID-19 deaths on June 30th, 2020.
length(unique(data[nchar(ihme_loc_id)==3 | grepl(x=ihme_loc_id,pattern="USA_"),location_name]))
length(unique(data[nchar(ihme_loc_id)==3 ,location_name]))

#We systematically reviewed 383 published and unpublished COVID-19 forecasting models (see supplemental systematic review file). 
rev <- fread("data/review/review.csv")
nrow(rev[forecast==1])

c.var <- "mape"
c.tp <- "error"
me.t[, value := round(value, 1)]

# Number Plug Results for Monthly Approach
me.t[approach=="monthly" & model_month=="Oct, 2020" & super_region_name == "Global" & model_short == "Pooled" & variable == c.var & err_type == c.tp & errwk %in% c(1, 12), value]
me.t[approach=="monthly" & model_month=="Oct, 2020"  & model_short == "Pooled" & variable == c.var & err_type == c.tp & errwk %in% c(6), c("super_region_name","value")]
me.t[approach=="monthly" & model_month=="Jul, 2020"  & model_short == "Pooled" & variable == c.var & err_type == c.tp & errwk %in% c(6), c("super_region_name","value")]

me.t[approach=="monthly" & model_month=="Oct, 2020" & super_region_name == "Global"  & variable == c.var & err_type == c.tp & errwk %in% c(6), c("model_short","value")]
me.t[approach=="monthly" & model_month=="Oct, 2020" & super_region_name == "Global"  & variable == c.var & err_type == c.tp & errwk %in% c(12), c("model_short","value")]
me.t[approach=="monthly" & model_month=="Oct, 2020" & super_region_name == "High-income"  & variable == c.var & err_type == c.tp & errwk %in% c(12), c("model_short","value")]

c.var <- "mpe"
c.tp <- "error"
me.t[approach=="monthly" & model_month=="Oct, 2020" & super_region_name == "Global" & variable == c.var & err_type == c.tp & errwk %in% c(6), c("model_short","value")]



# Number Plug Results for Recent Approach

# For all models, the most recent 1-week errors, reflecting forecasts created in October, ranged from 1% to 2%.
me.t[approach=="recent" & errwk==1&super_region_name=="Global"&err_type=="error"&variable=="mape"]
#12-week median absolute percent errors (MAPE), reflecting models produced in July and August,
#ranged from 22.4% for the SIK-J Alpha model, to 79.9% for the Imperial model. 
me.t[approach=="recent" & errwk==12&super_region_name=="Global"&err_type=="error"&variable=="mape"]
#At the global level pooling across models, the most recent 6-week MAPE value was 7.2%.  
me.t[approach=="recent" & errwk==6&super_region_name=="Global"&model_short=="Pooled"&err_type=="error"&variable=="mape"]
me.t[approach=="recent" & errwk==6&super_region_name=="Global"&err_type=="error"&variable=="mape"]

#---------------------------------------------------------------------------------------
#Numbers in Table 1
unique(data$model)
length(unique(data[model=="ihme" & nchar(ihme_loc_id)==3,location_name]))
length(unique(data[model=="ucla" & nchar(ihme_loc_id)==3,location_name]))
length(unique(data[model=="yyg" & nchar(ihme_loc_id)==3,location_name]))
length(unique(data[model=="delphi" & nchar(ihme_loc_id)==3,location_name]))
length(unique(data[model=="imperial" & nchar(ihme_loc_id)==3,location_name]))
length(unique(data[model=="lanl" & nchar(ihme_loc_id)==3,location_name]))
length(unique(data[model=="sikjalpha" & nchar(ihme_loc_id)==3,location_name]))

(max(data[model=="ucla"&current==1,date]))
(max(data[model=="lanl"&current==1,date]))
(max(data[model=="delphi"&current==1,date]))
(max(data[model=="imperial"&current==1,date]))
(max(data[model=="yyg"&current==1,date]))
(max(data[model=="ihme"&current==1,date]))
(max(data[model=="sikjalpha"&current==1,date]))
}





