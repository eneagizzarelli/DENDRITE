#!/bin/bash
set -e

# Start MySQL service
service mysql start

# Keep the container running
tail -f /dev/null