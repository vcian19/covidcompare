# ##############################################################################
# Purpose:  Compare and Graph COVID-19 Models - Mortality Magnitude
# Authors:   Joseph Friedman & Patty Liu
# Reviewer: Austin Carter
# ##############################################################################

## Setup
rm(list = ls())
pacman::p_load(data.table, tidyverse, git2r, rvest, stringr, httr, rio, ggplot2, grid, gridExtra, cowplot, reldist)
root <- getwd()

# set which graphs to produce
r.pv_plots <- 1
r.forecast_plots <- 1

# load data
data <- readRDS(paste0(root, "/data/processed/data.rds"))

# locations file
locs <- fread("data/ref/locs_map.csv")
locs <- locs[, c("location_name", "ihme_loc_id", "region_name", "super_region_name")]

# list locations for which we hope to make estimates
locs.list <- locs[nchar(ihme_loc_id) == 3 | grepl(x = ihme_loc_id, pattern = "USA_")]

# Model names
data[, model_short := factor(model,
                           levels = c("delphi", "lanl", "yyg", "imperial", "ihme_cf", "ihme_hseir", "ihme_elast"),
                           labels = c("Delphi", "LANL", "YYG", "Imperial", "IHME-CF", "IHME-CF-SEIR", "IHME-MS-SEIR"), ordered = T)]
# Get most current run
cur <- data[, .(model_date = max(model_date)), by = .(model)]
cur[, current := 1]
data <- merge(data, cur, all.x = T, by = c("model", "model_date"))

# remove floating data
data <- data[!(is.na(model))]

# add first and last model date by location-model
data[, min_model_date := min(model_date, na.rm = T), by = .(location_name, model)]
data[, max_model_date := max(model_date, na.rm = T), by = .(location_name, model)]

# last data point in truth
lst.truth <- max(data[!is.na(truth), date], na.rm = T)

# identify points at 1,2,3,4,5,6 weeks out from model_date to predict
for (i in seq(0, 6)) {
  data[date == model_date + 7 * i, errwk := i]
}

# create timeshfited cum_deaths series
shifts <- data[date == model_date]
shifts[, shift := truth - deaths_cum]
shifts <- shifts[, c("location_name", "model", "model_date", "shift")] %>% unique()
data <- merge(data, shifts, by = c("location_name", "model", "model_date"), all.x = T)
data[!is.na(shift), deaths_cum_shifted := deaths_cum + shift]


# drop points in past that plot strangely due to shifting data formatting
data <- data[!(model_long == "IHME - MS SEIR" & model_date == "2020-05-29" & location_name == "United States")]


#model month
data[, model_month := format(model_date, format = "%b")]

#calculate number of model iterations per month
data[,iter_num:=uniqueN(model_date),by=.(model,model_month)]

# calculate error - no missings, and more than 1 model iteration for the month in question
errors <- data[!is.na(errwk) & !is.na(truth)&iter_num>1]
errors[, error := deaths_cum_shifted - truth]
# smoothed daily actual deaths





# weekly error
errors <- errors[order(location_name, model, model_date, errwk)]
errors[, truth_wk := truth - shift(truth), by = .(location_name, model, model_date)]
errors[, deaths_cum_shifted_wk := deaths_cum_shifted - shift(deaths_cum_shifted), by = .(location_name, model, model_date)]
errors[, wkly_error := deaths_cum_shifted_wk - truth_wk]
errors <- errors[errwk != 0]



# make template to use in visualizing overlap
errors[, present := 1]
template <- data.table(expand.grid(location_name = locs.list$location_name, errwk = seq(1, 6), model_short = unique(errors$model_short)))
template <- merge(template, errors[!is.na(error)], all.x = T, by = c("location_name", "errwk", "model_short"))
template[is.na(present), present := 0]


# Error stats by location-model-errwk-model_date
errors[, abs_error := abs(error)]
errors[, per_error := (error / truth) * 100]
errors[, abs_per_error := abs(per_error)]

#weekly
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

lme.errors.l[, model_month := factor(model_month, levels = c("Mar", "Apr", "May", "Jun"))]


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

wkly.lme.errors.l[, model_month := factor(model_month, levels = c("Mar", "Apr", "May", "Jun","Jul"))]

#-------Figure 2 and Extended Data Figures 1-3 -----------------------------------

mer.wts <- errors[, c("location_name", "super_region_name", "model_short", "errwk", "error", "wkly_error", "truth", "truth_wk", "model_month")]
mer.wts <- mer.wts[!duplicated(mer.wts[, c("location_name", "super_region_name", "model_short", "errwk", "truth", "truth_wk","model_month")])]
mer.wts <- melt.data.table(mer.wts, id.vars = c("location_name", "super_region_name", "model_short", "errwk", "truth", "truth_wk", "model_month"), value.name = "error", variable.name = "err_type")

mer.wts[, abs_error := abs(error)]
mer.wts[err_type == "wkly_error", per_error := (error / truth_wk) * 100]
mer.wts[err_type != "wkly_error", per_error := (error / truth) * 100]


mer.wts[, abs_per_error := abs(per_error)]



mer.wts.gp <- mer.wts[is.finite(error), .(
  me = median(error, na.rm = T),
  mae = median(abs_error, na.rm = T),
  mape = median(abs_per_error, na.rm = T),
  mpe = median(per_error, na.rm = T),
  loc_n = uniqueN(location_name)
), by = .(model_month, errwk, err_type)]

mer.wts.gp[, model_short := "Pooled"]
mer.wts.gp[, super_region_name := "Global"]

mer.wts.g <- mer.wts[is.finite(error), .(
  me = median(error, na.rm = T),
  mae = median(abs_error, na.rm = T),
  mape = median(abs_per_error, na.rm = T),
  mpe = median(per_error, na.rm = T),
  loc_n = uniqueN(location_name)
), by = .(model_short, model_month, errwk, err_type)]

mer.wts.g[, super_region_name := "Global"]

mer.wts.p <- mer.wts[is.finite(error), .(
  me = median(error, na.rm = T),
  mae = median(abs_error, na.rm = T),
  mape = median(abs_per_error, na.rm = T),
  mpe = median(per_error, na.rm = T),
  loc_n = uniqueN(location_name)
), by = .(model_month, errwk, err_type,super_region_name)]

mer.wts.p[, model_short := "Pooled"]

mer.wts <- mer.wts[is.finite(error), .(
  me = median(error, na.rm = T),
  mae = median(abs_error, na.rm = T),
  mape = median(abs_per_error, na.rm = T),
  mpe = median(per_error, na.rm = T),
  loc_n = uniqueN(location_name)
), by = .(model_short, model_month, errwk, err_type,super_region_name)]


mer.wts <- rbind(mer.wts, mer.wts.p,mer.wts.g,mer.wts.gp)

mer.wts.l <- melt.data.table(mer.wts, id.vars = c("model_short", "model_month", "errwk", "err_type", "loc_n","super_region_name"))
mer.wts.l[variable == "mape", variable := "Median Absolute Percent Error"]
mer.wts.l[variable == "me", variable := "Median Error"]
mer.wts.l[variable == "mpe", variable := "Median Percent Error"]
mer.wts.l[variable == "mae", variable := "Median Absolute Error"]
mer.wts.l[err_type == "error", err_type := "Total Cumulative Error"]
mer.wts.l[err_type == "wkly_error", err_type := "Weekly Error"]


# set graphing order
mer.wts.l[, srn2 := super_region_name]
mer.wts.l[srn2 == "Central Europe, Eastern Europe, and Central Asia", srn2 := "Eastern Europe, Central Asia"]
mer.wts.l[srn2 == "Southeast Asia, East Asia, and Oceania", srn2 := "Southeast, East Asia, Oceania"]

mer.wts.l[, model_month := factor(model_month, levels = c("Mar", "Apr", "May", "Jun","Jul"))]

# create new value for fill color
mer.wts.l[, value_trm := value]
mer.wts.l[value > 100, value_trm := 100]
mer.wts.l[value <- 100, value_trm := -100]




if (r.pv_plots == 1) {

pdf(paste0("visuals/Figure_2_", Sys.Date(), ".pdf"), width = 3, height = 8)

c.var <- "Median Absolute Percent Error"
for (c.var in c("Median Absolute Percent Error", "Median Percent Error")) {
  for (c.tp in unique(mer.wts.l$err_type)) {
    gg1 <- ggplot(mer.wts.l[super_region_name=="Global" & loc_n > 5 & variable == c.var & err_type == c.tp&model_month%in%c("Mar","Apr","May","Jun")], aes(y = errwk, x = model_short, fill = value_trm, label = round(value))) +
      geom_tile(alpha = 1) +
      theme_bw() +
      facet_grid(rows=vars(model_month),cols=vars(srn2),scales="free_y",switch="y",as.table=F) +
      geom_text(size = 2.9) +
      labs(y = "Forecasting Weeks", x = "Model", title = paste0(c.tp, "\n", c.var)) +
      theme(
        axis.title.x = element_text(size = 9, face = "bold"), strip.background = element_rect(fill = "white"),
        axis.title.y = element_text(size = 9, face = "bold"), plot.title = element_text(size = 9, face = "bold"),
        axis.text.x = element_text(size = 9, angle = 45, hjust = 1, face = "bold"),
        axis.text.y = element_text(size = 9, face = "bold"), legend.position = "top"
      ) +
      scale_fill_gradient2(high = "#d73027", low = "#4575b4", mid = "#ffffbf", midpoint = 45, name = "", breaks = seq(0, 100, 25), labels = paste0(seq(0, 100, 25), "%"), guide = guide_colorbar(barwidth = 10, barheight = .3), na.value = "white", limits = c(0, 100))+
      scale_y_continuous(breaks=seq(1,20))

    if (c.var=="Median Percent Error")  gg1 <- gg1 +scale_fill_gradient2(high = "#d73027", low = "#d73027", mid = "#4575b4", midpoint = 0, name = "", breaks = seq(-100, 100, 50), labels = paste0(seq(-100, 100, 50), "%"), guide = guide_colorbar(barwidth = 10, barheight = .3), na.value = "white", limits = c(-100, 100))
    print(gg1)
  }
}
dev.off()




pdf(paste0("visuals/Extended_Data_Figures_1_2_3", Sys.Date(), ".pdf"), width = 16, height = 8)

c.var <- "Median Absolute Percent Error"
for (c.var in c("Median Absolute Percent Error", "Median Percent Error")) {
  for (c.tp in unique(mer.wts.l$err_type)) {
    gg1 <- ggplot(mer.wts.l[srn2!="Global"&loc_n > 5 & variable == c.var & err_type == c.tp&model_month%in%c("Mar","Apr","May","Jun")], aes(y = errwk, x = model_short, fill = value_trm, label = round(value))) +
      geom_tile(alpha = 1) +
      theme_bw() +
      facet_grid(row=vars(model_month),cols=vars(srn2),scales="free_y",switch="y",as.table=F) +
      geom_text(size = 2.6) +
      labs(y = "Forecasting Weeks", x = "Model", title = paste0(c.tp, " - ", c.var)) +
      theme(
        axis.title.x = element_text(size = 9, face = "bold"), strip.background = element_rect(fill = "white"),
        axis.title.y = element_text(size = 9, face = "bold"), plot.title = element_text(size = 12, face = "bold"),
        axis.text.x = element_text(size = 9, angle = 45, hjust = 1, face = "bold"),
        axis.text.y = element_text(size = 9, face = "bold"), legend.position = "top"
      ) +
      scale_fill_gradient2(high = "#d73027", low = "#4575b4", mid = "#ffffbf", midpoint = 45, name = "", breaks = seq(0, 100, 10), labels = paste0(seq(0, 100, 10), "%"), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(0, 100))+
      scale_y_continuous(breaks=seq(1,20))
    
    gg2 <- ggplot(mer.wts.l[srn2=="Global"&loc_n > 5 & variable == c.var & err_type == c.tp&model_month%in%c("Mar","Apr","May","Jun")], aes(y = errwk, x = model_short, fill = value_trm, label = round(value))) +
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
      scale_y_continuous(breaks=seq(1,20))
    
    
    if (c.var=="Median Percent Error")  gg1 <- gg1 +scale_fill_gradient2(high = "#d73027", low = "#d73027", mid = "#4575b4", midpoint = 0, name = "", breaks = seq(-100, 100, 20), labels = paste0(seq(-100, 100, 20), "%"), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(-100, 100))
    if (c.var=="Median Percent Error")  gg2 <- gg2 +scale_fill_gradient2(high = "#d73027", low = "#d73027", mid = "#4575b4", midpoint = 0, name = "", breaks = seq(-100, 100, 20), labels = paste0(seq(-100, 100, 20), "%"), guide = guide_colorbar(barwidth = 20, barheight = .5), na.value = "white", limits = c(-100, 100))
    
    gg <- plot_grid(gg1,gg2,rel_widths = c(1,.2),align='h',axis='tb')
    print(gg)
  }
}
dev.off()

}


#-------Figure 1 and Country-Specific Magnitude Plots -----------------------------------


# graphs
c.vals <- c(
  "Delphi" = "#e31a1c",
  "IHME - CF SEIR" = "#6a3d9a",
  "IHME - Curve Fit" = "#cab2d6",
  "IHME - MS SEIR" = "#33a02c",
  "Los Alamos Nat Lab" = "#1f78b4",
  "Youyang Gu" = "#ff7f00",
  "Imperial" = "#fb9a99"
)

# set graphing order based on number of cum deaths
c.for <- max(data[!is.na(truth), date])

ord <- data[date == c.for]
ord <- ord[, .(deaths_cum = mean(truth, na.rm = T)), by = .(location_name)]
locs.list.ord <- merge(locs.list, ord, all = T, by = "location_name")
locs.list.ord <- locs.list.ord[order(-deaths_cum)]
template[, location_name := factor(location_name, levels = rev(locs.list.ord$location_name))]

template[present == 1, shw := errwk]
template[present == 0, shw := 0]

## graph overlap
gg <- ggplot(template[location_name %in% locs.list.ord$location_name], aes(x = model_short, y = location_name, fill = factor(present))) +
  geom_tile() +
  theme_bw() +
  scale_fill_discrete(name = "Present") +
  theme(
    plot.title = element_text(size = 12, face = "bold"),
    axis.title.x = element_text(size = 10),
    axis.text.y = element_text(size = 4), strip.background = element_rect(fill = "white"),
    axis.text.x = element_text(size = 10, angle = 0),
    strip.text.x = element_text(size = 10, face = "bold"), legend.position = "top"
  ) +
  labs(y = "Location", x = "Model", title = "Overlap Between Models by Number of Forecasting Weeks") +
  facet_wrap(~errwk, nrow = 1)
gg



# drop points in past that plot strangely due to shifting data formatting
errors <- errors[!(model_long == "IHME - MS SEIR" & model_date == "2020-05-29" & location_name == "United States")]

data <- data[!(model_long == "IHME - MS SEIR" & location_name == "United States" & truth > 100 & deaths_cum < 100)]



lme.errors.l[variable %in% c("Median Error"), variable := "Med Err"]
lme.errors.l[variable %in% c("Median Absolute Error"), variable := "Med Abs Err"]



if (r.forecast_plots == 1) {
  pdf(paste0("visuals/figure_1_country_plots_", Sys.Date(), ".pdf"), width = 12, height = 8)
  for (c.loc in locs.list.ord[deaths_cum > 10 & (nchar(ihme_loc_id == 1 | grepl(x = ihme_loc_id, pattern = "USA_"))), location_name]) {
    print(c.loc)
   
    # check if US state
    is.state <- ifelse(c.loc %in% locs[grepl(x = ihme_loc_id, pattern = "USA_"), location_name], 1, 0)

    # get start date
    c.start <- min(data[location_name == c.loc & truth > 0, date]) - 8
    c.for <- max(data[location_name == c.loc & !is.na(truth), date])

    # Current Forecasts
    # scale y axis to 110% of non-Imperial max model value (prevent scale blowout)
    c.max <- 1.1 * max(data[current == 1 & location_name == c.loc & date < "2020-10-02" & date > c.start & !is.na(model) & model_long != "Imperial", upper_cum / 1000], na.rm = T)

    gg1 <- ggplot(
      data[current == 1 & location_name == c.loc & date < "2020-10-02" & date >= c.for & !is.na(model_long) & !(model_long %in% c("IHME - CF SEIR","IHME - Curve Fit"))],
      aes(x = date, color = model_long, fill = model_long)
    ) +
      geom_line(aes(y = deaths_cum / 1000), size = 2) +
      geom_ribbon(aes(y = deaths_cum / 1000, ymin = lower_cum / 1000, ymax = upper_cum / 1000), alpha = .1, color = NA) +
      theme_bw() +
      geom_point(data = data[location_name == c.loc & date > c.start & date < "2020-10-02" & !is.na(model)], fill = "white", color = "black", aes(y = jhu / 1000, shape = "JHU")) +
      geom_point(data = data[location_name == c.loc & date > c.start & date < "2020-10-02" & !is.na(model)], fill = "white", color = "black", aes(y = nyt / 1000, shape = "NYT")) +
      geom_vline(xintercept = c.for, linetype = "longdash", alpha = .5) +
      scale_x_date(
        breaks = function(x) seq.Date(from = min(x), to = max(x), by = "1 months"),
        date_labels = "%b%d"
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
      coord_cartesian(ylim = c(0, c.max))
    # remove shape legend if not a US state
    if (is.state == 0) {
      gg1 <- gg1 + guides(shape = F)
    }

    # All historical versions
    c.max <- 1.1 * max(data[location_name == c.loc & date < "2020-10-02" & date > c.start & !is.na(model_long) & model_long != "Imperial", deaths_cum / 1000], na.rm = T)

    gg2 <- ggplot(
      data[location_name == c.loc & date < "2020-10-02" & date > c.start & !is.na(model_long)],
      aes(x = date, color = model_long, fill = model_long)
    ) +
      theme_bw() +
      geom_line(aes(y = deaths_cum / 1000, alpha = model_date, group = model_date), size = 2) +
      facet_wrap(~model_long, nrow = 1) +
      geom_point(data = data[location_name == c.loc & date > c.start & date < "2020-10-02" & !is.na(model) & model != "Ensemble"], fill = "white", color = "black", aes(y = jhu / 1000, shape = "JHU")) +
      geom_point(data = data[location_name == c.loc & date > c.start & date < "2020-10-02" & !is.na(model) & model != "Ensemble"], fill = "white", color = "black", aes(y = nyt / 1000, shape = "NYT")) +
      geom_vline(aes(xintercept = min_model_date), linetype = "longdash", alpha = .5) +
      geom_vline(aes(xintercept = max_model_date), linetype = "longdash", alpha = .5) +
      scale_x_date(
        breaks = function(x) seq.Date(from = min(x), to = max(x), by = "2 months"),
        date_labels = "%b%d"
      ) +
      labs(y = "Deaths (Thousands)", x = "Week of", title = "All Model Versions") +
      theme(
        plot.title = element_text(size = 12, face = "bold"),
        axis.title.x = element_blank(), axis.title.y = element_blank(), legend.title = element_blank(),
        axis.text.y = element_text(size = 10, face = "bold"), strip.background = element_rect(fill = "white"),
        strip.text.x = element_text(size = 10, face = "bold"), legend.position = "none"
      ) +
      scale_color_manual(values = c.vals, name = "") +
      scale_fill_manual(values = c.vals, name = "") +
      guides(color = F, fill = F) +
      scale_shape_manual(name = "", values = c("JHU" = 21, "NYT" = 24)) +
      coord_cartesian(ylim = c(0, c.max))


    # All Errors
    c.max <- 1.1 * max(errors[location_name == c.loc & date < "2020-10-02" & date > c.start & !is.na(model_long) & model_long != "Imperial", error / 1000], na.rm = T)
    c.min <- 1.1 * min(errors[location_name == c.loc & date < "2020-10-02" & date > c.start & !is.na(model_long) & model_long != "Imperial", error / 1000], na.rm = T)

    gg3 <- ggplot(
      errors[location_name == c.loc & date < "2020-10-02" & date > c.start & !is.na(model_long)],
      aes(x = date, color = model_long, fill = model_long, y = error / 1000)
    ) +
      theme_bw() +
      geom_hline(yintercept = 0, alpha = .7) +
      facet_wrap(~model_long, nrow = 1) +
      geom_point() +
      geom_vline(aes(xintercept = min_model_date), linetype = "longdash", alpha = .5) +
      geom_vline(aes(xintercept = max_model_date), linetype = "longdash", alpha = .5) +
      scale_x_date(
        limits = c(c.start, as.Date("2020-10-02")), breaks = function(x) seq.Date(from = c.start, to = as.Date("2020-10-02"), by = "2 months"),
        date_labels = "%b%d"
      ) +
      labs(y = "Deaths (Thousands)", x = "Week of", title = "All Cumulative Errors") +
      theme(
        plot.title = element_text(size = 12, face = "bold"),
        axis.title.x = element_blank(), axis.title.y = element_blank(), legend.title = element_blank(),
        axis.text.y = element_text(size = 10, face = "bold"), strip.background = element_rect(fill = "white"),
        strip.text.x = element_text(size = 10, face = "bold"), legend.position = "none"
      ) +
      scale_color_manual(values = c.vals, name = "") +
      scale_fill_manual(values = c.vals, name = "") +
      guides(color = F, fill = F) +
      coord_cartesian(ylim = c(c.min, c.max))


    lme.errors.l[variable %in% c("Med Err", "Median Percent Error"), add_line := 0]

    # Average Error
    c.max <- 1.1 * max(lme.errors.l[location_name == c.loc & variable %in% c("Med Err", "Med Abs Err") & model_long != "Imperial", value / 1000], na.rm = T)
    c.min <- min(lme.errors.l[location_name == c.loc & variable %in% c("Med Err", "Med Abs Err") & model_long != "Imperial", value / 1000], na.rm = T)

    gg4 <- ggplot(
      lme.errors.l[location_name == c.loc & variable %in% c("Med Err", "Med Abs Err")&model_month%in%c("Mar","Apr","May","Jun")],
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
      scale_fill_manual(values = c.vals, name = "") +coord_cartesian(ylim = c(c.min, c.max))


    lay <- rbind(
      c(1, 1,  4, 4),
      c(1, 1,  4, 4),
      c(2, 2,  2, 2),
      c(3, 3,  3, 3)
    )

    grid.arrange(gg1, gg2, gg3, gg4, top = textGrob(paste0(c.loc), gp = gpar(fontsize = 20, fontface = "bold")), ncol = 2, layout_matrix = lay)
 
     }
  dev.off()
}



#-------------number plug------------------------------------------------------------

#Collectively models covered 171 countries, as well as the 50 states of the United States, and Washington, D.C.,
#and accounted for >99% of all reported COVID-19 deaths on June 30th, 2020.
length(unique(data[nchar(ihme_loc_id)==3 | grepl(x=ihme_loc_id,pattern="USA_"),location_name]))
length(unique(data[nchar(ihme_loc_id)==3 ,location_name]))

#We systematically reviewed 383 published and unpublished COVID-19 forecasting models (see supplemental systematic review file). 
rev <- fread("data/review/review.csv")
nrow(rev[forecast==1])

c.var <- "Median Absolute Percent Error"
c.tp <- "Cumulative Error"
mer.wts.l[, value := round(value, 1)]

#For example, pooling errors across models released in May, the median absolute percent error (MAPE) 
#rose from 3.8% at one week of extrapolation to 14.5% at 6 weeks
mer.wts.l[model_month=="May" & super_region_name == "Global" & model_short == "Pooled" & variable == c.var & err_type == c.tp & errwk %in% c(1, 6), value]

#Pooling across models, the MAPE at 4 weeks of extrapolation was
#10.2% in June, as compared to 13.6% in May, 25.1% in April, and 94.9% in March
prnt <- mer.wts.l[super_region_name == "Global" & model_short == "Pooled" & variable == c.var & err_type == c.tp & errwk %in% c(4), c("value","model_month")]
prnt[order(value)]

#No corresponding improvement over time, however, was seen when examining weekly errors, with a
#MAPE at 4 weeks of 67.0%, 62.5%, and 65.1% for June, May, and April, respectively
prnt <- mer.wts.l[super_region_name == "Global" & model_short == "Pooled" & variable == c.var & err_type == "Weekly Error" & errwk %in% c(4), c("value","model_month")]
prnt[order(model_month)]



#For models released in June, at four weeks of forecasting, the best performing model was the IHME-MS SEIR model, 
#with a cumulative MAPE of 6.4%, followed by YYG (6.5%) and LANL (8.0%)
prnt <- mer.wts.l[model_month=="Jun"&super_region_name == "Global" & model_short != "Pooled" & variable == c.var & err_type == c.tp & errwk == 4, c("value", "model_short")]
prnt[order(value)]

#For models released in May, assessed at six weeks of extrapolation, the IHME-CF SEIR model had a MAPE for 
#cumulative deaths of 11.6%, followed by YYG (13.1%), and LANL (14.0%).
prnt <- mer.wts.l[model_month=="May"&super_region_name == "Global" & model_short != "Pooled" & variable == c.var & err_type == c.tp & errwk == 6, c("value", "model_short")]
prnt[order(value)]

#For models released in April, at six weeks of extrapolation, the best performance was observed for the LANL model with a
#MAPE of 26.5%, followed by YYG at 26.7%, and the Delphi model at 29.3%.
prnt <- mer.wts.l[model_month=="Apr"&super_region_name == "Global" & model_short != "Pooled" & variable == c.var & err_type == c.tp & errwk == 6, c("value", "model_short")]
prnt[order(value)]

#In April, most forecasting models were largely unbiased in short term forecasts, with 
#median percent error (MPE) values at 1 weeks of extrapolation ranging 
#from -5.5% for LANL to +10.1% for Imperial, with a pooled MPE of +0.6%.
c.var <- "Median Percent Error"
prnt <- mer.wts.l[model_month=="Apr" &super_region_name == "Global" & variable == c.var & err_type == c.tp & errwk == 1, c("model_short", "value")]
prnt[order(value)]

#However, by 6 weeks of extrapolation models produced in April proved to be overly optimistic, with a pooled MPE of -10.0%. 
prnt <- mer.wts.l[model_month=="Apr" &super_region_name == "Global" & variable == c.var & err_type == c.tp & errwk == 6, c("model_short", "value")]
prnt[order(value)]

#In contrast, by June, models had become relatively unbiased in longer-term forecasts, with a pooled MPE at 4 weeks of extrapolation of -0.1%. 
prnt <- mer.wts.l[model_month=="Jun" &super_region_name == "Global" & variable == c.var & err_type == c.tp & errwk == 4, c("model_short", "value")]
prnt[order(value)]


#A notable exception was the Imperial model, which had an MPE of +2,164.8% at 6 weeks for models released in April,
mer.wts.l[model_month=="Apr" & super_region_name == "Global" & model_short == "Imperial" & variable == c.var & err_type == c.tp & errwk %in% c(6), value]
#and an MPE of +XX% at 4 weeks for models released in June (see the Supplement for a location-specific visualization of all timeseries and errors). mer.wts.l[model_month=="Apr" & super_region_name == "Global" & model_short == "Imperial" & variable == c.var & err_type == c.tp & errwk %in% c(6), value]
mer.wts.l[model_month=="Jun" & super_region_name == "Global" & model_short == "Imperial" & variable == c.var & err_type == c.tp & errwk %in% c(4), value]

#Looking across models, errors in cumulative mortality predictions were generally highest in Sub-Saharan Africa,
#with a pooled-error MAPE of 42.3% at four weeks for models released in June, and 34.7% at six weeks for models released in May,
#compared to 4.8% and 11.2% respectively  respectively for countries in the High-income region
c.var <- "Median Absolute Percent Error"
mer.wts.l[model_month=="Jun" &super_region_name %in%c("Sub-Saharan Africa","High-income") & model_short == "Pooled" & variable == c.var & err_type == c.tp & errwk %in% c(4), value]
mer.wts.l[model_month=="May" &super_region_name %in%c("Sub-Saharan Africa","High-income") & model_short == "Pooled" & variable == c.var & err_type == c.tp & errwk %in% c(6), value]


#---------------------------------------------------------------------------------------
#Geography Numbers in Table 1
unique(data$model)
length(unique(data[model=="ihme_cf" & nchar(ihme_loc_id)==3,location_name]))
length(unique(data[model=="ihme_hseir" & nchar(ihme_loc_id)==3,location_name]))
length(unique(data[model=="ihme_elast" & nchar(ihme_loc_id)==3,location_name]))
length(unique(data[model=="yyg" & nchar(ihme_loc_id)==3,location_name]))
length(unique(data[model=="delphi" & nchar(ihme_loc_id)==3,location_name]))
length(unique(data[model=="imperial" & nchar(ihme_loc_id)==3,location_name]))
length(unique(data[model=="lanl" & nchar(ihme_loc_id)==3,location_name]))
(max(data[model=="lanl"&current==1,date]))
(max(data[model=="delphi"&current==1,date]))
(max(data[model=="imperial"&current==1,date]))




