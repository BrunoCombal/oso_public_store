#!/bin/bash

# Author: Bruno Combal
# Date: July 2014

shopt -s nullglob
shopt -s dotglob

path=/data/public_store/lmes_socioeco/
rsrcDir=${path}/rsrc
outdir=${path}/
tmpdir=${path}/tmp
mkdir -p ${tmpdir}

# some operations should be done manually, including deleting the tmp directory and update information files
chktmp=(${tmpdir}/*)
if [ ${#chktmp[*]} -ne 0 ]; then echo "please clean tmp directory and update information files"; exit 1; fi

# copy information files
memoDay='None'
for ii in readme.txt version.txt productDescription_lmes_socioeco.txt 
do
    if [ ! -e "${ii}" ]; then
	echo "information file ${ii} does not exist. Exit."
	exit 3
    fi
    
    thisDay=$(stat ${rsrcDir}/${ii} |grep Change | cut -d ' ' -f 2)
    if [ "${memoDay}" != 'None' ]; then
	if [ "${thisDay}" != "${memoDay}" ]; then
	    echo "Found information files with different last update day."
	    echo "Please review information files and run again this building script."
	    exit 2
	fi
    fi
    cp ${rsrcDir}/${ii} ${tmpdir}
done

version=$(cat ${tmpdir}/version.txt | grep -i version | head -n 1 | cut -d ':' -f 2 | tr -d '[:space:]')

#let's do pop_nldi_hdi first
cp ${path}/lme_area_pop_nldi_hdi.csv ${tmpdir}
for ii in dbf prj qpj shp shx 
do
    cp ${path}/lmes_area_pop_nldi_hdi.${ii} ${tmpdir}
done

if [ -n "${version}" ]; then
    archiveName=lmes_socioeco_pop_nldi_hdi_${version}.zip
else
    archiveName=lmes_socioeco_pop_nldi_hdi.zip
fi
	    
# zip all files
rm -f ${archiveName}
find ${tmpdir} -name "*" | zip -@ -j ${outdir}/${archiveName}

# remove pop_nldi_hdi and go to fishing revenues
rm -f ${tmpdir}/*.csv
for ii in dbf prj qpj shp shx
do
    rm -f ${tmpdir}/${ii}
done
cp ${path}/lme_fishing_revenues_indicators.csv ${tmpdir}
for ii in dbf prj qpj shp shx
do
    cp ${path}/lmes_fishing_revenues_indicators.${ii} ${tmpdir}
done

# create the archive
if [ -n "${version}" ]; then
    archiveName=lmes_socioeco_fishing_revenues_${version}.zip
else
    archiveName=lmes_socioeco_fishing_revenues.zip
fi
	    
# zip all files
rm -f ${archiveName}
find ${tmpdir} -name "*" | zip -@ -j ${outdir}/${archiveName}

# rm data in tmp
rm -f ${tmpdir}/*

# end of script
