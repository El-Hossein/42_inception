FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
    curl \
    php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-redis \
    php8.2-curl \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip \
    mariadb-client \
    wget \
    git \
    netcat-openbsd \
    mycli

RUN  rm -rf /var/lib/apt/lists/*

RUN sed -i 's|^listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf
COPY ./tools/wp_conf.sh /wp_conf.sh

RUN chmod +x /wp_conf.sh

ENTRYPOINT ["/wp_conf.sh"]