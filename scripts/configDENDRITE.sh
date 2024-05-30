#!/bin/bash

DENDRITE_path="/home/DENDRITE"

if [ -d "${DENDRITE_path}" ]; then
    sudo rm -rf ${DENDRITE_path}
fi

git clone https://github.com/eneagizzarelli/DENDRITE.git ${DENDRITE_path}

mkdir -p ${DENDRITE_path}/logs
mkdir -p ${DENDRITE_path}/data

${DENDRITE_path}/scripts/downloadGeoLiteDB.sh

sudo chown -R root:root ${DENDRITE_path}
sudo chmod -R 700 ${DENDRITE_path}