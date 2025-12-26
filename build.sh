#!/bin/bash

docker build -t 944101542155.dkr.ecr.us-east-1.amazonaws.com/vedant7669/prod_infra:base-image-10.1.0 .

sleep 2

docker push 944101542155.dkr.ecr.us-east-1.amazonaws.com/vedant7669/prod_infra:base-image-10.1.0