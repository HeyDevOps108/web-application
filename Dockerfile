ARG BASE_IMAGE_ABSOLUTE_PATH
ARG ARTIFACT_URL

FROM ${BASE_IMAGE_ABSOLUTE_PATH}

RUN wget --no-check-certificate ${ARTIFACT_URL} -P /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]