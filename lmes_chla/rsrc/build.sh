#!/bin/bash

# author: Bruno Combal
# date: June 2014

shopt -s nullglob
shopt -s dotglob

indir=/data/public_store/lmes_chla
shpdir=${indir}
rsrc=/data/public_store/lmes_chla/rsrc/
tmpdir=${indir}/tmp
outdir=${indir}
mkdir -p ${tmpdir}

# some operations should be done manually, including deleting the tmp directory and update information files
chktmp=(${tmpdir}/*)
if [ ${#chktmp[*]} -ne 0 ]; then echo "please clean tmp directory and update information files"; exit 1; fi
mkdir -p ${tmpdir}/csv

# get a copy of original files, and rename them using the lme code
for ii in ${indir}/*-CHL-M.CSV
do
	cp "${ii}" ${tmpdir}/csv/
done
for ii in ${indir}/*-CHL-Y.CSV
do
        cp "${ii}" ${tmpdir}/csv/
done

cp ${indir}/LONG-TERM-MEAN-CHL.CSV ${tmpdir}/csv/
cp ${indir}/lmes_chla_ppy_trends.csv ${tmpdir}/csv

# post processing: remove all NaN in the CSV files
for ii in ${tmpdir}/csv/*.CSV
do
    sed -i 's/NaN/ /' ${ii}
done

# copy the shapefile
for ext in dbf qpj shx prj shp
do
    cp ${shpdir}/lmes_chl_pp_and_trends.${ext} ${tmpdir}
done
# generate product description
# to be done manually

# copy information files
for ii in readme.txt metainformation_lmes_chla_monthly.xml productDescription_lmes_chla.txt version.txt
do
    cp ${rsrc}/${ii} ${tmpdir}
done

version=$(cat ${tmpdir}/version.txt | grep -i version | head -n 1 | cut -d ':' -f 2 | tr -d '[:space:]')

if [ -n "${version}" ]; then
    archiveName=lmes_chla_${version}.zip
else
    archiveName=lmes_chla.zip
fi

# zip all files
rm -f ${outdir}/${archiveName}
find ${tmpdir} -name "*" | zip -@ ${outdir}/${archiveName}

# end of script