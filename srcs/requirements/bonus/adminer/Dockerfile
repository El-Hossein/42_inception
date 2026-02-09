FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
    php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    wget

RUN  rm -rf /var/lib/apt/lists/*
RUN mkdir -p /var/www/adminer
RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /var/www/adminer/index.php
    
RUN sed -i 's|^listen = .*|listen = 9001|' /etc/php/8.2/fpm/pool.d/www.conf

RUN chown -R www-data:www-data /var/www

ENTRYPOINT ["php-fpm8.2", "-F"]