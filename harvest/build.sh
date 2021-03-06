#!/bin/bash

# author: Bruno Combal, IOC-UNESCO
# date: July 2014

harvestDir='/data/public_store/harvest/'
declare -A repoList=(['oo']='oo_chi oo_ohi oo_sea_ice oo_warmpool cumulative_impact debris mesozooplankton oo_benthicbiomasschange oo_biodiversity oo_dhm oo_fisheries oo_fisheries_futurecatch oo_plastics oo_pteropods oo_reefs_threat oo_warmpool slr_impact socio_eco oo_pml' ['lmes']='lmes_chla lmes_chla_hdf lmes_chla_mean lmes_corals lmes_fisheries lmes_icep lmes_mangroves lmes_ohi lmes_chi lmes_nutrients lmes_plastics_modeldistribution lmes_mangrove lmes_mpa lmes_pp lmes_ppd_longterm lmes_sst lmes_governance lmes_pops lmes_shelf_area lmes_socioeco')

function getXML(){
    dataDir='/data/public_store'

    for irepo in ${!repoList[@]}
    do
        mkdir -p ${harvestDir}/${irepo}
        dirList=(${repoList[$irepo]})

        for ((ii=0; ii<${#dirList[@]}; ii++))
        do
            explore=${dataDir}/${dirList[${ii}]}
            echo "____"
            echo "Exploring " $explore
            listXML=(`find ${explore} -type f -iname "*iso*19139*xml" ! -path "${explore}/notHarvested/*" | grep -v -i 'new_' | grep -v -i 'old_' `)
            for jj in ${listXML[@]}
            do
                echo "Getting "$jj
                cp $jj ${harvestDir}/$irepo
                if [ $? -ne 0 ]; then
                    echo "!!! Error while getting $jj from $explore"
                fi
            done
        done
    done
}
# _________________
function doClean(){
    for iDir in ${!repoList[@]}
    do
        for ii in ${harvestDir}/${iDir}/*.xml
        do
            echo 'removing ' $ii
            rm -f $ii
        done
    done
}
# _________________
function doState(){
    find ${harvestDir} -type f -iname "*.xml" -printf '%f\t'
    echo '______________'
    count=`find ${harvestDir} -type f -iname "*.xml" -printf '%f\n'| wc -l`
    echo "Total ${count} files"
}
# _________________
action=`echo $1 | tr [:upper:] [:lower:]`


case $action in
    '') getXML ;;
    'clean') doClean ;;
    'state') doState;;
    esac


# end of file
