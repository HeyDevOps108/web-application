#!/bin/bash
set -e

source ./common.env

docker build -t ${IMAGE_ABSOLUTE_PATH} .
