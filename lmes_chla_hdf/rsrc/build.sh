#!/bin/bash

# Author: Bruno Combal
# Date: July 2014

shopt -s nullglob
shopt -s dotglob

path=/data/public_store/lmes_chla_hdf
hdfDir=${path}/hdf
rsrcDir=${path}/rsrc
outdir=${path}/
tmpdir=${path}/tmp
mkdir -p ${tmpdir}

# some operations should be done manually, including deleting the tmp directory and update information files
chktmp=(${tmpdir}/*)
if [ ${#chktmp[*]} -ne 0 ]; then echo "please clean tmp directory and update information files"; exit 1; fi

# copy snapshots


# make list of regions
lmesNames=($(find ${hdfDir} -type f -name "MONTH*HDF" -printf '%f\n' | sed 's/MONTH_..-//g' |  sed 's/-CHLOR_A-MEAN.HDF//g' | sort | uniq))

if [[ ${#lmesNames[@]} -eq 0 ]] ;then
    echo "Could not find LMEs HDF files to process. Exit(100)"
    exit 100
fi

# copy information files
# rule: all files last change must be from the same day. Else, require the user to update them
for ((ilmes=0; ilmes<${#lmesNames[@]}; ilmes++))
do
    echo "Processing LME:" $ilmes
    cp ${rsrcDir}/readme.txt ${tmpdir}
    cp ${rsrcDir}/version.txt ${tmpdir}
    cp ${rsrcDir}/productDescription.txt ${tmpdir}/description_lme_${lmesNames[${ilmes}]}-chla_mean.txt
    cp ${rsrcDir}/xml_iso19139.xml ${tmpdir}
    cp ${hdfDir}/MONTH_*${lmesNames[${ilmes}]}-CHLOR_A-MEAN.HDF ${tmpdir}

    version=$(cat ${tmpdir}/version.txt | grep -i version | head -n 1 | cut -d ':' -f 2 | tr -d '[:space:]')
    if [ -n "${version}" ]; then
	archiveName=lme_${lmesNames[${ilmes}]}_chla_mean_${version}.zip
    else
	archiveName=lme_${lmesNames[${ilmes}]}_chla_mean.zip
    fi
	
    # zip all files
    rm -f ${archiveName}
      
    find ${tmpdir} -name "*" | zip -@ ${outdir}/${archiveName}
    # delete everything for next iteration
    for thisfile in ${tmpdir}/*
    do
	rm -f ${thisfile}
    done
    
done
# end of script
