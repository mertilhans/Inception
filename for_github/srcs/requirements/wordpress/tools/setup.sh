#!/bin/bash
set -e

# MariaDB'nin tamamen hazır olması için bekle
sleep 10

cd /var/www/html

# Eğer wp-config.php yoksa kurulumu yap
if [ ! -f "wp-config.php" ]; then
    # Dosyalar varsa bile üstüne yazması için --force ekliyoruz
    wp core download --allow-root --force

    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb:3306

    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="Inception" \
        --admin_user=$WORDPRESS_ADMIN_USER \
        --admin_password=$WORDPRESS_ADMIN_PASSWORD \
        --admin_email=$WORDPRESS_ADMIN_EMAIL

    wp user create --allow-root \
        $WORDPRESS_USER $WORDPRESS_EMAIL \
        --role=author --user_pass=$WORDPRESS_PASSWORD
fi

# PHP-FPM'in çalıştığından emin olmak için dizini tekrar kontrol et
mkdir -p /run/php

# Önemli: Debian Bullseye'da tam yol genellikle budur
exec /usr/sbin/php-fpm7.4 -F
