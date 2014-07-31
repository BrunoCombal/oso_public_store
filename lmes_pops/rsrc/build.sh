#!/bin/bash

# Author: Bruno Combal
# Date: August 2014

shopt -s nullglob
shopt -s dotglob

path=/data/public_store/lmes_pops
rsrcDir=${path}/rsrc
outdir=${path}/
tmpdir=${path}/tmp
mkdir -p ${tmpdir}

# some operations should be done manually, including deleting the tmp directory and update information files
chktmp=(${tmpdir}/*)
if [ ${#chktmp[*]} -ne 0 ]; then echo "please clean tmp directory and update information files"; exit 1; fi

# copy shapefile
for iext in cpg csv dbf prj qpj shp shx
do
    cp ${path}/lmes_pops.${iext} ${tmpdir}
done

# copy information files
# rule: all files last change must be from the same day. Else, require the user to update them
memoDay='None'
for ii in readme.txt version.txt productDescription_pops.txt lmes_pops_xml_iso_19139.xml
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
    archiveName=lmes_pops_${version}.zip
else
    archiveName=lmes_pops.zip
fi

# zip all files
rm -f ${archiveName}

find ${tmpdir} -name "*" | zip -@ -j ${outdir}/${archiveName}

# end of script
