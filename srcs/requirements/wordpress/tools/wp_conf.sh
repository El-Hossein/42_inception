#!/bin/bash
set -e


MYSQL_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_P=$(cat /run/secrets/wp_admin_password)
WP_U_PASS=$(cat /run/secrets/wp_user_password)

echo "Waiting for MariaDB..."

if ! mysqladmin ping -h mariadb --silent -u "$MYSQL_USER" -p"$MYSQL_PASSWORD"; then
    echo "MariaDB did not start"
    exit 1
fi


if ! command -v wp >/dev/null 2>&1; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi


mkdir -p /var/www/html
chmod -R 755 /var/www/html

cd /var/www/html

if [ ! -f wp-config.php ]; then

    wp core download --allow-root

    wp core config \
        --dbhost="mariadb:3306" \
        --dbname="$MYSQL_DB" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --allow-root

    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_N" \
        --admin_password="$WP_ADMIN_P" \
        --admin_email="$WP_ADMIN_E" \
        --skip-email \
        --allow-root
    if ! wp plugin is-installed redis-cache --allow-root; then
        wp plugin install redis-cache --activate --allow-root
        wp config set WP_REDIS_HOST redis --allow-root
        wp config set WP_REDIS_PORT 6379 --raw --allow-root
        wp redis enable --allow-root
    fi
    wp user create "$WP_U_NAME" "$WP_U_EMAIL" \
        --user_pass="$WP_U_PASS" \
        --allow-root
fi


chown -R www-data:www-data /var/www/html/
mkdir -p /run/php
chown -R www-data:www-data /run/php
echo "WordPress setup complete. Starting PHP-FPM..."

exec php-fpm8.2 -F