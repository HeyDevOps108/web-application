FROM nginx:1.25-alpine

WORKDIR /var/www/html/

RUN rm -rf /var/www/html/*

RUN rm -rf /usr/share/nginx/html/*

COPY dist/Folio/* /var/www/html/

COPY dist/Folio/* /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]