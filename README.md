# covidcompare

#### Authors:   
- Joseph Friedman (Email: joseph.robert.friedman at gmail dot com, Twitter: [@JosephRFriedman](https://twitter.com/JosephRFriedman/))
- Patty Liu (Email: pyliu47 at gmail dot com, Twitter: [@pyliu47](https://twitter.com/pyliu47/))
  
#### Manuscript:  
Predictive performance of international COVID-19 mortality forecasting models
Joseph Friedman, Patrick Liu, Christopher E. Troeger, Austin Carter, Robert C. Reiner JR, Ryan M. Barber, James Collins, Stephen S. Lim, David M. Pigott, Theo Vos, Simon I. Hay, Christopher J.L. Murray, Emmanuela Gakidou
medRxiv 2020.07.13.20151233
doi: https://doi.org/10.1101/2020.07.13.20151233


## How to Use this Repo

Here we provide the codebase and analytical/graphing framework to collate and compare all historical model-verions of the below global COVID-19 forecasting models. We encourage use of data to assess the historical and ongoing performance of models, develop new analyses for assessing performance, and hope that they will spur the requisite conversation for improving the community of forecasting models: 

- [DELPHI-MIT (Delphi)](https://github.com/COVIDAnalytics/website/tree/master/)
- [Imperial College London (Imperial)](https://github.com/mrc-ide/global-lmic-reports/tree/master/)
- [The Institute for Health Metrics and Evaluation (IHME)](http://www.healthdata.org/covid/data-downloads)
- [The Los Alamos National Laboratory (LANL)](https://covid-19.bsvgateway.org/)
- [SIKJalpha](https://github.com/scc-usc/ReCOVER-COVID-19)
- [Youyang Gu (YYG)](https://github.com/youyanggu/covid19_projections/tree/master/)

Details on the systematic review completed to compile the list of models are detailed in the corresponding publication. If your model is not currently included, we encourage you to submit an Github issue with the link to a publically accessible repo or website where they may be accessed. 

## Viz Tool

![screenshot](https://i.ibb.co/RvXG63k/screenshot.png)

Please check out our new online Viz Tool at [covidcompare.io](https://covidcompare.io), which will be updated regularly going forward. This was produced by Samir Akre ([Github](https://github.com/akre96), [Twitter](https://twitter.com/samirakre)). 

Historical comparing model performance corresponding to manuscript updates can be accessed in `visuals/`.

## Data Structure

Forecasting estimates pulled from the above models are archived and named by date of publication in `data/raw`. To collate and clean the data, please use the function `collate.data()` which can be sourced from `_collate.r`. These data will be regularly updated daily going forward. 

## Code Structure

Before running code, the codebase must be initialized via `covidcompare.Rproj`. 

`code/0_sysreview.r` : Pull and compile an updated list of COVID-19 forecasting publications from Medrxiv and Pubmed.  

`code/1_pull_data.r` : Update all historical COVID-19 mortality projections from each of the sources included in the manuscript, as well as mortality data from the New York Times and Johns Hopkins University data repositories.

`code/2_magnitude.R`: Generate statistics and plots comparing forecasted magnitudes of mortality from each model to observed mortality. All cumulative deaths forecasts are intercept-shifted to the true level of cumulative deaths on the date of publication. The predictive validity statistics calculated for cumulative deaths and weekly deaths are error, absolute error, percent error, and absolute percent error. The median is taken across dates of estimate publication for a given model, location, and number of weeks out from the date of model publication.  

`code/2_peak.r`: Calculate a true date of peak daily deaths for each location and compare to the estimated peak in each model. The peak is calculated by smoothing the true daily deaths and then identifying the first maximum value in a two-week window that it is not exceeded by more than 20% in the following three weeks and does not occur within the first or last week of data. The error and absolute are error calculated and then summarized with the median across various domains.

## Framework Updates

2020-11-19
- Updated preprint manuscript, with new addition to the analytical framework. We now look at model performance statistics for the "most current" 4 week snapshot by forecasting period. 

2020-08-13
- Added SIKJalpha (https://github.com/scc-usc/ReCOVER-COVID-19) and its historical models to the comparison framework

2020-07-17
- At the request of YYG, now using estimated cumulative daily deaths. Was previously using cumulative daily deaths created by summing estimates of daily deaths. 




