#!/bin/bash
source ./common.env

set -ex

THIS_DIR=$(cd $(dirname ${BASH_SOURCE}) ; pwd)

echo ${ARTIFACT_NAME}
echo ${ARTIFACT_VERSION}

docker pull ${BASE_IMAGE_ABSOLUTE_PATH}

ARTIFACT_URL="${ARTIFACT_BASE_URL}/${ARTIFACT_NAME}:${ARTIFACT_VERSION}"
echo "ARTIFACT_URL = ${ARTIFACT_URL}"

docker build --pull --build-arg BASE_IMAGE_ABSOLUTE_PATH=${BASE_IMAGE_ABSOLUTE_PATH} \
                    --build-arg ARTIFACT_URL=${ARTIFACT_URL} \
                    -t ${IMAGE_ABSOLUTE_PATH} \
                    -f Dockerfile ${THIS_DIR}

