#!/bin/bash

# author: Bruno Combal
# date: September 2014

shopt -s nullglob
shopt -s dotglob

indir=/data/public_store/lmes_sst
rsrc=${indir}/rsrc/
tmpdir=${indir}/tmp
outdir=${indir}
mkdir -p ${tmpdir}

# some operations are better done manually, forbid automated calling from a script
# force user checking
chktmp=(${tmpdir}/*)
if [ ${#chktmp[*]} -ne 0 ]; then echo "Please clean tmp directory and update information files"; exit 1; fi

# copy data to tmpdir
for ext in dbf qpj shx prj shp
do
    cp ${indir}/lmes_sst_net_change.${ext} ${tmpdir}
done

# copy information files
for ii in readme.txt lmes_sst_xml_iso19139.xml productDescription_lmes_sst.txt version.txt
do
    cp ${rsrc}/${ii} ${tmpdir}
done

version=$(cat ${tmpdir}/version.txt | grep -i version | head -n 1 | cut -d ':' -f 2 | tr -d '[:space:]')

if [ -n "${version}" ]; then
    archiveName=lmes_sst_${version}.zip
else
    archiveName=lmes_sst.zip
fi

# zip all files
find ${tmpdir} -name "*" | zip -@ ${outdir}/${archiveName}

# end of script