#!/bin/bash
set -ex

source ./common.env

echo "Deploying Kubernetes manifests to ${K8S_NAMESPACE}"

kubectl apply -f artifacts/obcs-service.dep.yml
kubectl apply -f artifacts/obcs-service.svc.yml

sleep 5

echo "Deployment completed"
