#!/bin/bash

# Author: Bruno Combal
# Date: September 2014

shopt -s nullglob
shopt -s dotglob

path=/data/public_store/oo_fisheries_futurecatch/
rsrcDir=${path}/rsrc
outdir=${path}/
tmpdir=${path}/tmp
mkdir -p ${tmpdir}

# some operations should be done manually, including deleting the tmp directory and update information files
chktmp=(${tmpdir}/*)
if [ ${#chktmp[*]} -ne 0 ]; then echo "please clean tmp directory and update information files"; exit 1; fi

decades=('2030' '2050')

for idecade in ${decades[@]}
do
    # copy information files
    # rule: all files last change must be from the same day. Else, require the user to update them
    memoDay='None'
    for ii in readme_${idecade}.txt version.txt oo_fisheries_projection_${idecade}_xml_iso19139.xml oo_fisheries_projection_${idecade}_relative_2000_xml_iso19139.xml productDescription_oo_fisheries_projection.txt 
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
    
    cp ${path}/fisheries_pc_${idecade}_relativeto_2000_percent.tif ${tmpdir}
    cp ${path}/HS_CPSRESA1B_${idecade}.tif ${tmpdir}
    
    version=$(cat ${tmpdir}/version.txt | grep -i version | head -n 1 | cut -d ':' -f 2 | tr -d '[:space:]')
    
    if [ -n "${version}" ]; then
	archiveName=oo_fisheries_projection_${idecade}_${version}.zip
    else
	archiveName=oo_fisheries_projection_${idecade}.zip
    fi
    
    # zip all files
    rm -f ${archiveName}
    find ${tmpdir} -name "*" | zip -@ -j ${outdir}/${archiveName}
    
    # rm data in tmp
    rm -f ${tmpdir}/*
    
done

# end of script
