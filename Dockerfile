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
