#!/bin/bash

# author: Bruno Combal
# date: July 2014


zipDir='/data/public_store/lmes_chla_hdf'
outfile='/data/public_stor/lmes/chla_hdf/download.html'

echo "<html><head><title>Choose a file to download</title></head><body>"
echo '<div style="font-family:verdana, sans-serif; font-size:14px">Choose an mean Chlorophyl-A from satellite observation (1998-2013), per LME:</div><br/>'
for izip in ${zipDir}/*.zip
do
    echo '<div style="float:left; min-width:40%; font-family:verdana,sans-serif; font-size:11px">'
    echo '<a href="http://onesharedocean.org/public_store/lmes_chla_hdf/'${izip##*/}'">'${izip##*/}'</a>'
    size=$(du -hs ${izip} | sed 's/\t.*//')
    echo '</div><div style="float:left; margin:auto; font-family:verdana, sans-serif; font-size:11px">'${size}
    echo '</div><br/>'
done
echo "</body></html>"

# end of script