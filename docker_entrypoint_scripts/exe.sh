#!/bin/bash
set -e

rm -rf /docker-entrypoint-initdb.d/

chmod 700 /entrypoint.sh

rm -f /exe.sh