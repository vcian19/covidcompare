# covidcompare

#### Authors:   
- Joseph Friedman (Email: joseph.robert.friedman@gmail.com, Twitter: [@JosephRFriedman](https://twitter.com/JosephRFriedman/))
- Patty Liu (Email: pyliu47@gmail.com, Twitter: [@pyliu47](https://twitter.com/pyliu47/))

## How to Use this Repo

Here we provide the codebase and analytical/graphing framework to collate and compare all historical model-verions of the below global COVID-19 forecasting models. We encourage use of data to assess the historical and ongoing performance of models, develop new analyses for assessing performance, and hope that they will spur the requisite conversation for improving the community of forecasting models: 

- [DELPHI-MIT (Delphi)](https://github.com/COVIDAnalytics/website/tree/master/)
- [Imperial College London (Imperial)](https://github.com/mrc-ide/global-lmic-reports/tree/master/)
- [The Institute for Health Metrics and Evaluation (IHME)](http://www.healthdata.org/covid/data-downloads)
- [The Los Alamos National Laboratory (LANL)](https://covid-19.bsvgateway.org/)
- [Youyang Gu (YYG)](https://github.com/youyanggu/covid19_projections/tree/master/)

Details on the systematic review completed to compile the list of models are detailed in the corresponding publication. If your model is not currently included, we encourage you to message us at pyliu47@gmail.com and link to a publically accessible repo or website where they may be accessed. 

## Visuals

Graphs comparing model performance can be accessed in `visuals`. They will be updated regularly going forward. 

## Data Structure

Forecasting estimates pulled from the above models are archived and named by date of publication in `data/raw`. All historic model-verions are collated and saved in `data/processed/data.rds`. These data will be regularly updated going forward. 

## Code Structure

Before running code, the codebase must be initialized via `covidcompare.Rproj`. 

`code/0_sysreview.r` : Pull and compile an updated list of COVID-19 forecasting publications from Medrxiv and Pubmed.  

`code/1_pull_data.r` : Compile all historical COVID-19 mortality projections from each of the sources included in the manuscript, as well as mortality data from the New York Times and Johns Hopkins University data repositories.

`code/2_magnitude.R`: Generate statistics and plots comparing forecasted magnitudes of mortality from each model to observed mortality. All cumulative deaths forecasts are intercept-shifted to the true level of cumulative deaths on the date of publication. The predictive validity statistics calculated for cumulative deaths and weekly deaths are error, absolute error, percent error, and absolute percent error. The median is taken across dates of estimate publication for a given model, location, and number of weeks out from the date of model publication.  


`code/2_peak.r`: Calculate a true date of peak daily deaths for each location and compare to the estimated peak in each model. The peak is calculated by smoothing the true daily deaths and then identifying the first maximum value in a two-week window that it is not exceeded by more than 20% in the following three weeks and does not occur within the first or last week of data. The error and absolute are error calculated and then summarized with the median across various domains.

## Updates

2020-07-17
- At the request of YYG, now using estimated cumulative daily deaths. Was previously using cumulative daily deaths created by summing estimates of daily deaths. 



