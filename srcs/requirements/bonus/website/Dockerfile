FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nginx
RUN  rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./website /var/www/html

RUN chown -R www-data:www-data /var/www/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]