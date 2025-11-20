ARG THEME_NAME
LABEL theme=$THEME_NAME

FROM docker.io/wordpress:6.8.3-php8.3-fpm-alpine

# Install dependencies
RUN apk update && \
    apk add --no-cache \
        gcc \
        g++ \
        make \
        autoconf \
        php83-dev \
        php83-pear && \
    pecl install redis && \
    echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html/wp-content/cache

RUN chown -R www-data:www-data /var/www/html/wp-content/cache
