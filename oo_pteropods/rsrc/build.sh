#!/bin/bash

# Author: Bruno Combal
# Date: July 2014

shopt -s nullglob
shopt -s dotglob

path=/data/public_store/oo_pteropods/
rsrcDir=${path}/rsrc
outdir=${path}/
tmpdir=${path}/tmp
mkdir -p ${tmpdir}

# some operations should be done manually, including deleting the tmp directory and update information files
chktmp=(${tmpdir}/*)
if [ ${#chktmp[*]} -ne 0 ]; then echo "please clean tmp directory and update information files"; exit 1; fi

# species
species=('creseis' 'l_helicina' 'l_retroversa')
rcps=('rcp45' 'rcp85')
decades=('2010' '2030' '2050')


for ispecies in ${species[@]}
do
    for ircp in ${rcps[@]}
    do
	for idecade in ${decades[@]}
	do
    # copy information files
    # rule: all files last change must be from the same day. Else, require the user to update them
	    memoDay='None'
	    for ii in readme.txt version.txt oo_${ispecies}_${idecade}_${ircp}_xml_iso19139.xml productDescription_oo_pteropods.txt 
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
	    
	    cp ${path}/${ispecies}_arag_temp_${idecade}_${ircp}.tif ${tmpdir}

	    version=$(cat ${tmpdir}/version.txt | grep -i version | head -n 1 | cut -d ':' -f 2 | tr -d '[:space:]')
	    
	    if [ -n "${version}" ]; then
		archiveName=oo_${ispecies}_${idecade}_${ircp}_${version}.zip
	    else
		archiveName=oo_${ispecies}_${idecade}_${ircp}.zip
	    fi
	    
            # zip all files
	    rm -f ${archiveName}
	    find ${tmpdir} -name "*" | zip -@ -j ${outdir}/${archiveName}

	    # rm data in tmp
	    rm -f ${tmpdir}/*
	    
	done
    done
done

# end of script
