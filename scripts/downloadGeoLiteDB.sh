#!/bin/bash

DENDRITE_path="/home/enea/DENDRITE"

if [ -f "${DENDRITE_path}/data/GeoLite2-City.mmdb" ]; then
    sudo rm -f ${DENDRITE_path}/data/GeoLite2-City.mmdb
fi

curl -L -o ${DENDRITE_path}/data/GeoLite2-City.mmdb https://git.io/GeoLite2-City.mmdb