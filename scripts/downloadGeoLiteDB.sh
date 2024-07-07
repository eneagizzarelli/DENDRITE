#!/bin/bash

#
# Script to automate GeoLite2-City.mmdb download. 
# Previous database is removed and the new one is downloaded.
# This script is intended to be run periodically to keep the database updated.
# Use crontab -e to schedule the script execution.
#

DENDRITE_path="/home/enea/DENDRITE"

if [ -f "${DENDRITE_path}/data/GeoLite2-City.mmdb" ]; then
    sudo rm -f ${DENDRITE_path}/data/GeoLite2-City.mmdb
fi

curl -L -o ${DENDRITE_path}/data/GeoLite2-City.mmdb https://git.io/GeoLite2-City.mmdb