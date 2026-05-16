FROM debian:bullseye

# MariaDB sunucusunu kur
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mariadb-server

# Yapılandırma dosyalarını ve betikleri kopyala
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/setup.sh /usr/local/bin/setup.sh

# MariaDB'nin çalışması için gerekli dizinleri oluştur ve yetki ver
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql

# Veritabanı portu
EXPOSE 3306

# Kurulum betiğini çalıştır
ENTRYPOINT ["bash", "/usr/local/bin/setup.sh"]
