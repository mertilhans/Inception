FROM debian:bullseye

# Gerekli paketleri kur (PHP-FPM, MySQL istemcisi ve wget)
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y php7.4 php-fpm php-mysql mariadb-client wget curl

# WP-CLI aracını indir ve kurulabilir yap
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# PHP-FPM'in çalışması için gerekli dizini oluştur
RUN mkdir -p /run/php

# Yapılandırma dosyalarını kopyala
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/setup.sh /usr/local/bin/setup.sh

# WordPress dosyaları için yetkilendirme
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Portu aç[cite: 1]
EXPOSE 9000

# Betiği çalıştır
ENTRYPOINT ["bash", "/usr/local/bin/setup.sh"]
