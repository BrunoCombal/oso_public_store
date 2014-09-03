Transboundary Water Assessment Program (GEF funded project)
Marine component (Open Ocean and Large Marine Ecosystems): http://onesharedocean.org
TWAP: www.gettwap.org

Product: LMEs nutrients and ICEP

Package content:
+ readme.txt: this file
+ version.txt: current version and history of changes
+ productDescription.txt: scientific description of the dataset
+ metainformation.xml: ISO 19139 formatted file, with among others, the contact points
see http://onesharedocean.org/?q=data in LMEs section, product nutrients, for a human readable version.
+ snapshots: some datasets visualisation
+ datasets, described in the next section.

datasets:
+ lme_nutrient_loading_and_eutrophication_2000.csv 

Column name	Time-varying?	Units	Scaled to 2000 Realistic Hydrology, for 2030 & 2050?	Description
lme_nbr		No			N/A    LME number
lme_name	No			       N/A LME name
stnbasin_area	No			       km2 N/A Total STN30/NEWS2 basin area draining into LME
qact		Yes			       km3/yr  Yes   Actual ("disturbed") basin discharge
ld_din		Yes			       Tg N/yr Yes   DIN load (Dissolved Inorganic Nitrogen)
ld_don		Yes			       Tg N/yr Yes   DON load (Dissolved Organic Nitrogen)
ld_pn		Yes			       Tg N/yr Yes   PN load (Particulate Nitrogen)
ld_dip		Yes			       Tg P/yr Yes   DIP load (Dissolved Inorganic Phosphorus)
ld_dop		Yes			       Tg P/yr Yes   DOP load (Dissolved Organic Phosphorus)
ld_pp		Yes			       Tg P/yr Yes   PP load (Particulate Phosphorus)
ld_dsi		Yes			       Tg Si/yr	     Yes     Dsi load (Dissolved Silica)
ld_tn		Yes			       Tg N/yr	     Yes     TN load (Total Nitrogen)
ld_tp		Yes			       Tg P/yr	     Yes     TP load (Total Phosphorus)
icep_n		Yes			       kg C-eq/km2/day	     Yes     N-ICEP (Nitrogen ICEP)
icep_p		Yes			       kg C-eq/km2/day	     Yes     P-ICEP (Phosphorus ICEP)
icep		Yes			       kg C-eq/km2/day	     Yes     Optimal ICEP
ld_din_cat	Yes			       Category (1-5)	     Yes (via ld_din)	ld_din categorized into fixed bins (same bins across years)
icep_cat	Yes			       Category (1-5)	     Yes (via ICEP)	ICEP Category
mergedind_cat	Yes			       Category (1-5)	     Yes (via ld_din & ICEP) Merged Indicator from ld_din_cat and icep_cat



+ lmes_nutrients_eutrophication.shp
A shapefile of the LMEs (66 LMEs), with same data set as above



--- end of file ---
