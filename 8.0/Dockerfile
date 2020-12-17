FROM php:8.0-fpm-alpine

ARG BUILD_DATE
ARG VCS_REF
ARG IMAGE_NAME
ARG DOCKER_REPO

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS ${PHP_OPCACHE_VALIDATE_TIMESTAMPS:-0}
ENV PHP_OPCACHE_MAX_ACCELERATED_FILES ${PHP_OPCACHE_MAX_ACCELERATED_FILES:-10000}
ENV PHP_OPCACHE_MEMORY_CONSUMPTION ${PHP_OPCACHE_MEMORY_CONSUMPTION:-192}
ENV PHP_OPCACHE_MAX_WASTED_PERCENTAGE ${PHP_OPCACHE_MAX_WASTED_PERCENTAGE:-10}

LABEL Maintainer="Mhd Zaher Ghaibeh" \
      org.label-schema.name="zaherg/php-and-nginx:latest" \
      org.label-schema.description="Lightweight container with Nginx & PHP-FPM 7.4 based on Alpine Linux." \
      org.label-schema.url="https://www.zaher.dev" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/zaherg/php-and-nginx.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0"

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

COPY root/. /

RUN set -ex \
    && echo "@main http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "@community http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update && apk upgrade \
    && apk add --no-cache nginx git curl openssh-client ca-certificates icu logrotate runit curl \
            icu libpng freetype libjpeg-turbo postgresql-dev libffi-dev libzip-dev \
    && apk add --no-cache --virtual build-dependencies icu-dev g++ make autoconf \
            libxml2-dev freetype-dev libpng-dev libjpeg-turbo-dev

RUN cd /tmp && curl -Ls https://github.com/nimmis/docker-utils/archive/master.tar.gz | tar xfz - \
    && ./docker-utils-master/install.sh && rm -Rf ./docker-utils-master \
    && rm -fr /etc/sv && rm -f /etc/service/crond /etc/service/rsyslogd

RUN sed -i 's/echo "Run scripts is \/etc\/run_always"/#echo "Run scripts is \/etc\/run_always"/' /etc/runit/1 \
    && sed -i 's/find \/etc\/run_always/#find \/etc\/run_always/' /etc/runit/1

RUN docker-php-source extract \
    && pecl install redis opcache \
    && docker-php-ext-enable redis opcache \
    && docker-php-source delete \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j"$(nproc)" intl sockets pgsql pdo_mysql pdo_pgsql zip gd bcmath

RUN sed -i 's/user = www-data/user = nginx/' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's/group = www-data/group = nginx/' /usr/local/etc/php-fpm.d/www.conf \
    && mkdir /run/nginx

RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/master/contrib/install.sh | sh -s -- -b /usr/local/bin \
    && trivy filesystem --exit-code 1 --no-progress /

RUN rm -rf /var/cache/apk/* /var/www/localhost /var/www/html \
    && apk del build-dependencies && rm -rf /tmp/*

COPY conf.d/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

COPY rootfs /

EXPOSE 80 443

# Define default command.
CMD ["/boot.sh"]
