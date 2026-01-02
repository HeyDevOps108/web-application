#!/bin/bash
  
source ./common.env

set -ex

# replace the actual values in the dep yml
sed \
  -i -e "s|__DEPLOYMENT_NAME__|${DEPLOYMENT_NAME}|g" \
   artifacts/obcs-service.dep.yml


# replace the actual values in the svc yml
sed \
  -i -e "s|__DEPLOYMENT_NAME__|${DEPLOYMENT_NAME}|g" \
   artifacts/obcs-service.svc.yml

sed \
  -i -e "s|__SUBNAMESPACE__|${SUBNAMESPACE}|g" \
   artifacts/obcs-service.svc.yml

sed \
  -i -e "s|__DEPLOYMENT_NAME__|${DEPLOYMENT_NAME}|g" \
  -i -e "s|__SUBNAMESPACE__|${SUBNAMESPACE}|g" \
  -i -e "s|__IMAGE_ABSOLUTE_PATH__|${IMAGE_ABSOLUTE_PATH}|g" \
  -i -e "s|__REPLICAS__|${REPLICAS}|g" \
  -i -e "s|__CPU_LIMIT__|${CPU_LIMIT}|g" \
  -i -e "s|__MEM_LIMIT__|${MEM_LIMIT}|g" \
  -i -e "s|__CPU_REQ__|${CPU_REQ}|g" \
  -i -e "s|__MEM_REQ__|${MEM_REQ}|g" \
   artifacts/obcs-service.dep.yml

#list the final image
echo "Pushing image: ${IMAGE_ABSOLUTE_PATH}"

#push to docker registry
docker push ${IMAGE_ABSOLUTE_PATH}

#show pushed image
echo "Pushed Image : ${IMAGE_ABSOLUTE_PATH}"