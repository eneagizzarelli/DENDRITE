#!/bin/bash

#
# Convenience script to configure DENDRITE.
# Mainly used to update the local configuration after the code has been modified.
#   1. Previous DENDRITE folder is removed and the new one is cloned in the same location.
#   2. "logs" and "data" folders are created.
#   3. GeoLite2-City.mmdb is downloaded leveraging downloadGeoLiteDB.sh script.
#   4. Ownership and permissions are changed to the enea user.
# This script must be executed as root.
#

DENDRITE_path="/home/enea/DENDRITE"

if [ -d "${DENDRITE_path}" ]; then
    sudo rm -rf ${DENDRITE_path}
fi

git clone https://github.com/eneagizzarelli/DENDRITE.git ${DENDRITE_path}

mkdir -p ${DENDRITE_path}/logs
mkdir -p ${DENDRITE_path}/data

sudo chmod +x ${DENDRITE_path}/scripts/downloadGeoLiteDB.sh

${DENDRITE_path}/scripts/downloadGeoLiteDB.sh

sudo chown -R enea:enea ${DENDRITE_path}
sudo chmod -R 700 ${DENDRITE_path}