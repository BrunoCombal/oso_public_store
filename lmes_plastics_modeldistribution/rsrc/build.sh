#!/bin/bash

# Author: Bruno Combal
# Date: June 2014

shopt -s nullglob
shopt -s dotglob

path=/data/public_store/lmes_plastics_modeldistribution
rsrcDir=${path}/rsrc
shpDir=${path}
dataOrg=${path}/TWAP_LME_Plastics_ModelDistribution.csv
outdir=${path}/
tmpdir=${path}/tmp
mkdir -p ${tmpdir}

# some operations should be done manually, including deleting the tmp directory and update information files
chktmp=(${tmpdir}/*)
if [ ${#chktmp[*]} -ne 0 ]; then echo "please clean tmp directory and update information files"; exit 1; fi

# copy original data
cp ${dataOrg} ${tmpdir}

# copy shapefiles
for ii in shp shx prj qpj dbf
do
    cp ${shpDir}/lmes_plastics_modeldistribution.${ii} ${tmpdir}
done

# copy snapshots

# copy information files
# rule: all files last change must be from the same day. Else, require the user to update them
memoDay='None'
for ii in readme.txt version.txt lmes_plastics_models_xml_iso19139.xml productDescription_lmes_plastics_modeldistribution.txt
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

if [ -n "${version}" ]; then
    archiveName=lmes_plastics_modeldistribution_${version}.zip
else
    archiveName=lmes_plastics_modeldistribution.zip
fi

# zip all files
rm -f ${outdir}/${archiveName}
find ${tmpdir} -name "*" | zip -@ -j ${outdir}/${archiveName}

# end of script
