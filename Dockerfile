FROM docker.io/mariadb:latest AS db
COPY ./config/mysql.cnf /etc/mysql/conf.d/mysql.cnf

FROM docker.io/wordpress:6.8.1-php8.4-fpm-alpine AS wp
RUN set -ex; \
    apk --no-cache add sudo curl less bash mysql-client \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && rm -rf /var/cache/apk/*

USER www-data
VOLUME /var/www/html
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html

FROM docker.io/nginx:1.28-alpine3.21 AS server
RUN set -x; \
    addgroup -g 1000 -S www-data ; \
    adduser -u 1000 -D -S -G www-data www-data && exit 0 ; exit 1

RUN set -eux; \
    apk update && apk --no-cache add \
    curl \
    && addgroup www-data nginx \
    && rm -rf /var/cache/apk/*

VOLUME /var/www/html
WORKDIR /var/www/html
RUN mkdir -p /var/run/nginx-cache && \
    chown -R www-data:www-data /var/www/html /var/run/nginx-cache

CMD ["nginx", "-g", "daemon off;"]
