FROM nginx:1.25-alpine

WORKDIR /var/www/html/

RUN rm -rf /var/www/html/*

COPY dist/Folio/* /var/www/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]