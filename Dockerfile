FROM php:fpm-alpine
COPY docker-entrypoint.sh php.ini default.conf /
RUN apk add --no-cache \
        bash \
        nginx \
        git \
        tzdata && \
    mkdir -p /run/nginx && \
    mkdir -p /public && \
    mv /default.conf /etc/nginx/conf.d && \
    mv /php.ini /usr/local/etc/php && \
    chmod +x /docker-entrypoint.sh && \
    git clone https://github.com/hackswM/one2019.git /public

# Persistent config file and cache
VOLUME [ "/public/config", "/public/cache" ]
ENTRYPOINT [ "/docker-entrypoint.sh" ]
