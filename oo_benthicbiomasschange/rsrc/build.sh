#!/bin/bash

# Author: Bruno Combal
# Date: June 2014

shopt -s nullglob
shopt -s dotglob

path=/data/public_store/oo_benthicbiomasschange
rsrcDir=${path}/rsrc
outdir=${path}/
tmpdir=${path}/tmp
mkdir -p ${tmpdir}
declare -A rcp=(["rcp85"]="biom_rcp85.tif" ["rcp45"]="biom_rcp45.tif")
declare -A rcpxml=(["rcp85"]="oo_benthicbiomasschange_rcp85_xml_iso19139.xml" ["rcp45"]="oo_benthicbiomasschange_rcp45_xml_iso19139.xml")

# some operations should be done manually, including deleting the tmp directory and update information files
chktmp=(${tmpdir}/*)
if [ ${#chktmp[*]} -ne 0 ]; then echo "please clean tmp directory and update information files"; exit 1; fi

# copy snapshots

# copy information files
# rule: all files last change must be from the same day. Else, require the user to update them
memoDay='None'
for ii in readme.txt version.txt productDescription_oo_benthicbiomasschange.txt 
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

for thisRCP in rcp85 rcp45
do
    if [ -n "${version}" ]; then
	archiveName=oo_benthicbiomasschange_${thisRCP}_${version}.zip
    else
	archiveName=oo_benthicbiomaschange_${thisRCP}.zip
    fi
    
# zip all files
    rm -f ${archiveName}
    
    cp ${path}/${rcp[${thisRCP}]} ${tmpdir}
    cp ${rsrcDir}/${rcpxml[${thisRCP}]} ${tmpdir}
    find ${tmpdir} -name "*" | zip -@ ${outdir}/${archiveName}
    rm -f ${tmpdir}/${rcp[${thisRCP}]}
    rm -f ${tmpdir}/${rcpxml[${thisRCP}]}
done
# end of script
