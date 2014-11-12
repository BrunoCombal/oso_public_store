Transboundary Water Assessment Program (GEF funded project)
Marine component: http://onesharedocean.org
TWAP: www.geftwap.org

Product: LMEs Monthly Chlorophyll-A and long term trends

Package content:
readme.txt: this file
version.txt: current version and history of changes
productDescription.txt: scientific description of the creation of the dataset
metainformation.xml: ISO 19139 formatted file, with among others, the contact points
See http://onesharedocean.org/?q=data in LMEs section, product Chlorophyll-A for a human readable version

datasets:
CSV datasets are stored in directory "csv".

dataset 1: LONG-TERM-MEAN-CHL.CSV (a shapefile with the mean value is available, see datasets 2 and 3)
Comma separated text file (csv) for the Long term averages of each 66 Large Marine Ecosystems and the Pacific Warm Pool, one line per LME.

For each line:
  LME_NAME, LME_CODE,PROD,PERIOD,N,MEAN
  LME: LME name
  LME_NUM: LME code number (1 to 66), 99 is for the Western Pacific Warm Pool
  PROD: product code name, CHL is for Chlorophyll A
  PERIOD: the period of time used for computing the average.
  N: number of samples used for computing the average
  MEAN: mean of the series (see below the description of the series). The value correspond to a chlorophyll-a concentration. Units: mg/cubic meter (mg/m3).

dataset 2: lmes_chla_ppd_and_trends.csv, a comma separated file (CSV).
For each line:
   LME: LMe name
   PPY: Primary Productivity per Year (g C m-2 y-1) (MEAN of 16 years, 1998-2013);
   G: Primary Productivity Classification Group (1 to 5);
   CHL: 16-year mean CHL (mg m-3), 1998-2013
   PPY_%: Percent relative change in yearly mean Primary Productivity from 1998 to 2013
   CHL_%: Percent relative change in yearly mean CHL from 1998 to 2013
   SF_% : Sampling Frequency by Ocean Color Sensors in percent of 192 months sampled FROM 1998-2013
Trends are based on the change from 1998 to 2003. Percent relative change was computed from the predicted values (P) from the linear regression of annual mean PPY versus year according to: Relative Percent Change = 100 x [last(P)-first(P)]/first(P).
Percent Relative change values that are statistically significant at the 0.95% Probability level have two asterisks (‘**’) by the value in the table. For example the trend (PPY_% =percent relative change in yearly mean Primary Productivity) for the Baltic Sea is thirty-five point four percent and is statistically significant “35.4**”.


dataset 3: time series of chlorophyll-A, for each LME and the Pacific warm pool, from late 1996 to early 2014. The file name convention is:
  LME_NAME-LMECODE-CHL-Y.CSV for yearly average of chlorophyll A
  LME_NAME_LMECODE_CHL_M.CSV for monthly average of chlorophyll A

The files are comma separated values (csv) text files, with the following fields:
  for yearly average of Chlorophyll-A (LME_NAME-LMECODE-CHL-Y.CSV):
    LME: LME name
    CODE: LME code (1-66 and 99)
    PROD: product name, CHL for chlorophyll-A
    YEAR: the year
    MEAN: yearly average chlorophyll content

  for monthly average of chlorophyll-A (LME_NAME_LMECODE_CHL_M.CSV):
    LME: LME name
    CODE: LME code (1-66 and 99)
    PROD: product name, CHL for chlorophyll-A
    YEAR: the year
    MONTH: the month
    MEAN: yearly average chlorophyll content

LME: LME name
LME_NUM: LME code number
YEAR: year for the current data value
MONTH: month for the current data value
MEAN: value, the Chlorophyll-A, averaged at the scale of the LME, and for the month MONTH of year YEAR. Units: mg/cubic meter (mg/m3)

dataset 3: in lmes_longterm_mean, shapefile lmes_chla_longterm.shp
Shapefile of 66 LMEs, with the data of the mean Chlorophyll-A concentration (from file 67_regions_chl_long_term_mean.csv). The warmpool is not represented. Units: mg/m3
Projection: ESPG:4326 (plate carree, WGS84)


--- end of file ---
