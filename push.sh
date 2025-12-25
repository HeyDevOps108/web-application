#!/bin/bash

source ./common.env

set -ex

echo "Pushing image: ${IMAGE_ABSOLUTE_PATH}"

docker push ${IMAGE_ABSOLUTE_PATH}

echo "Pushed Image : ${IMAGE_ABSOLUTE_PATH}"