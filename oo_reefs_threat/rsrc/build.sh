#!/bin/bash

# Author: Bruno Combal
# Date: December 2014

shopt -s nullglob
shopt -s dotglob

path=/data/public_store/oo_reefs_threat/
rsrcDir=${path}/rsrc
outdir=${path}/
tmpdir=${path}/tmp
mkdir -p ${tmpdir}

# some operations should be done manually, including deleting the tmp directory and update information files
chktmp=(${tmpdir}/*)
if [ ${#chktmp[*]} -ne 0 ]; then echo "please clean tmp directory and update information files"; exit 1; fi

# species
rcps=('rcp45' 'rcp85')
decades=('2010' '2030' '2050')

for ircp in ${rcps[@]}
do
    for idecade in ${decades[@]}
    do
    # copy information files
    # rule: all files last change must be from the same day. Else, require the user to update them
        memoDay='None'
        for ii in readme.txt version.txt productDescription_oo_coralthreat.txt
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
            archiveName=oo_reefsthreat_${idecade}_${ircp}_${version}.zip
        else
            archiveName=oo_reefsthreat_${idecade}_${ircp}.zip
        fi

	for ext in dbf prj qpj shp shx
	do
	    cp ${path}/oo_reefs_threat_${idecade}_${ircp}.${ext} ${tmpdir}
	done

            # zip all files
        rm -f ${archiveName}
        find ${tmpdir} -name "*" | zip -@ -j ${outdir}/${archiveName}

            # rm data in tmp
        rm -f ${tmpdir}/*

    done
done

# post processing: remove 2010 RCP 4.5
rm ${outdir}/oo_reefsthreat_2010_rcp45_${version}.zip

# end of script
