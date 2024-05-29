#!/bin/bash
USER=$(whoami)
IP=$(echo $SSH_CONNECTION | awk '{print $1}')

LOG_DIR="/home/$IP"
mkdir -p $LOG_DIR

echo "$(date): $USER logged in from $IP" >> "$LOG_DIR/commands.log"

echo "$(date): $SSH_ORIGINAL_COMMAND" >> "$LOG_DIR/commands.log"

exec "$SSH_ORIGINAL_COMMAND"
