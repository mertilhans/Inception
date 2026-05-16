#!/bin/bash
set -e

# MariaDB servisinin başladığından emin olalım
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Geçici bir SQL dosyası oluşturup komutları içine yazıyoruz
cat << EOF > /tmp/db_setup.sql
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# SQL komutlarını çalıştır ve geçici dosyayı sil
mysqld --user=mysql --bootstrap < /tmp/db_setup.sql
rm -f /tmp/db_setup.sql

# MariaDB'yi ön planda (foreground) çalıştır
exec mysqld --user=mysql
