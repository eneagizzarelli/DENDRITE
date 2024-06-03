#!/bin/bash

IMAGE_NAME="enea-image"
CONTAINER_NAME="enea-container"
HOSTNAME="datalab"

# Run the Docker container
echo "Running Docker container $CONTAINER_NAME with hostname $HOSTNAME..."
docker run -d --name $CONTAINER_NAME --hostname $HOSTNAME $IMAGE_NAME tail -f /dev/null

echo "Container $CONTAINER_NAME is now running."