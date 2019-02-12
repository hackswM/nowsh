FROM php:fpm-alpine

COPY docker-entrypoint.sh php.ini default.conf /
RUN apk add --no-cache \
        bash \
        nginx \
        tzdata && \
    mkdir -p /run/nginx && \
    mv /default.conf /etc/nginx/conf.d && \
    mv /php.ini /usr/local/etc/php && \
    chmod +x /docker-entrypoint.sh && \
    git clone https://github.com/hackswM/one2019.git /var/www/html

# Persistent config file and cache
VOLUME [ "/var/www/html/config", "/var/www/html/cache" ]
ENTRYPOINT [ "/docker-entrypoint.sh" ]