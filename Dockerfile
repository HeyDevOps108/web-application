ARG BASE_IMAGE_ABSOLUTE_PATH
FROM ${BASE_IMAGE_ABSOLUTE_PATH}
ARG ARTIFACT_URL

WORKDIR /usr/share/nginx/html

RUN rm -rf /usr/share/nginx/html/*

RUN wget --no-check-certificate ${ARTIFACT_URL} -O /tmp/app.zip \
&& unzip /tmp/app.zip -d /tmp/app \
&& cp -r /tmp/app/dist/Folio/* /usr/share/nginx/html/ \
&& rm -rf /tmp/app.zip

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]