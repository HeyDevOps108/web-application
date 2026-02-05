#!/bin/bash
set -e

source ./common.env

docker push ${IMAGE_ABSOLUTE_PATH}
