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

sudo chgrp nonroot ${DENDRITE_path}
sudo chmod 710 ${DENDRITE_path}
sudo chgrp nonroot ${DENDRITE_path}/src
sudo chmod 710 ${DENDRITE_path}/src

sudo chgrp nonroot ${DENDRITE_path}/src/DENDRITE_login.py
sudo chmod 710 ${DENDRITE_path}/src/DENDRITE_login.py
sudo chgrp nonroot ${DENDRITE_path}/src/DENDRITE_logout.py
sudo chmod 710 ${DENDRITE_path}/src/DENDRITE_logout.py
sudo chgrp nonroot ${DENDRITE_path}/src/client_data.py
sudo chmod 710 ${DENDRITE_path}/src/client_data.py

sudo chgrp nonroot ${DENDRITE_path}/logs
sudo chmod 710 ${DENDRITE_path}/logs
sudo chgrp nonroot ${DENDRITE_path}/data
sudo chmod 710 ${DENDRITE_path}/data