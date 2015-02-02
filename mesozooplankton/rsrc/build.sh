#!/bin/bash

# author: Bruno Combal
# date: February 2015

indir=/data/public_store/mesozooplankton/
outdir=/data/public_store/mesozooplankton/
rsrcdir=${indir}/rsrc

version=$(cat ${rsrcdir}/version.txt | grep -i version | head -n 1 | cut -d ':' -f 2 | tr -d '[:space:]')

for iroi in australia ne_atlantic ne_pacific northern_benguela nw_pacific southern_benguela southern_ocean
do

    if [ -n "${version}" ]; then
	archiveName=oo_mesozooplankton_${iroi}_${version}.zip
    else
	archiveName=oo_mesozooplankton_${iroi}.zip
    fi

    rm -f ${outdir}/${archiveName}
    zip -j ${outdir}/${archiveName} *${iroi}* mesozooplankton_timeseries.csv
done


# end of script 