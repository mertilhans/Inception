FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl
COPY conf/nginx.crt /etc/nginx/ssl/nginx.crt
COPY conf/nginx.key /etc/nginx/ssl/nginx.key

COPY conf/nginx.conf /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]
