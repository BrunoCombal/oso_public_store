Transboundary Water Assessment Program (GEF funded project)
Marine component (Open Ocean and Large Marine Ecosystems): http://onesharedocean.org
TWAP: www.gettwap.org

Product: LMEs, fish and fisheries indicators

Package content:
+ readme.txt: this file
+ version.txt: current version and history of changes
+ dataset: see below

datasets:
CSV (Comma Separeted Values) formatted files:
+ LME_BtmCatch.csv= bottom catch: Year, LME code number (1-66), Catch in tonnes per year
+ LME_ecological_Footprint.csv= ecological footprint: Year, LME code number (1-66), ecological footprint
+ LME_catch_LV.csv= catch landed value (in 2005 real US dollars): year, LME code number (1-66), Catch in tonnes per year, landed value in USD per year
+ LME_MTI_FiB_50_10.csv=Marine Trophic Index and Fishing-in-Balance index: Identifier (internal processing), LME code number, year, MTI, FiB
+ lmes_fishing_effort.csv = fishing effort in kilowatt: year, LME code number, LME name, effective effort in kilowatt
+ lmes_fishing_effort_pwp.csv = same, for Pacific Warm Poom (PWP)
+ Stock_status_LME: a directory with CSV formatted files for Stock status and Catch by Stock Status 
files with names ending with _StockStatus.csv:
Year, Collapsed, Overexploited, Exploited, Developing and rebuilding
files with names ending with CatchByStockStatus.csv:
Year,Collapsed,Overexploited,Exploited,Developing,Rebuilding

Geotiff formatted data, ESPG 4326 (WGS 84)
+ LME_CPSRESA1B_2030.tif: catch projection for 2030, following climate change scenario SRES A1B
+ lmes_catch_relative_2030.tif: catch projection for 2030, following climate change scenario SRES A1B, with respect to year 2000
+ LME_CPSRESA1B_2050.tif: catch projection for 2050, following climate change scenario SRES A1B
+ lmes_catch_relative_2050.tif: catch projection for 2030, following climate change scenario SRES A1B, with respect to year 2000

--- end of file ---
