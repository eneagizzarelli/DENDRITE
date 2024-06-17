#!/bin/bash
set -e

# Start MySQL service
service mysql start

# Keep the container running
su enea -c "tail -f /dev/null"