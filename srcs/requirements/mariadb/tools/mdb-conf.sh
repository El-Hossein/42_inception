#!/bin/bash

mysqld_safe &
sleep 3

DB_PASS=$(cat /run/secrets/db_password)
ROOT_PASS=$(cat /run/secrets/db_root_password)

mariadb -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"

mariadb -u root -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${DB_PASS}';"

mariadb -u root -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB}\`.* TO \`${MYSQL_USER}\`@'%';"

mariadb -u root -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${ROOT_PASS}';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"

mariadb -u root -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p"${ROOT_PASS}" shutdown

exec mysqld --user=mysql --bind-address=0.0.0.0