#!/bin/bash
source ./common.env

set -ex

CONTAINER_NAME="${ARTIFACT_NAME}"
PORT=8080

echo "Deploying image: ${IMAGE_ABSOLUTE_PATH}"

# Pull exact versioned image
docker pull ${IMAGE_ABSOLUTE_PATH}

# Remove old container if exists
if docker ps -a --format '{{.Names}}' | grep -w ${CONTAINER_NAME}; then
  echo "Stopping existing container"
  docker rm -f ${CONTAINER_NAME}
fi

# Run new container
docker run -d \
  --name ${CONTAINER_NAME} \
  --restart unless-stopped \
  --memory="512m" \
  --cpus="1.0" \
  -p ${PORT}:80 \
  ${IMAGE_ABSOLUTE_PATH}

echo "Deployment completed on $(hostname)"