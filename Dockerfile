FROM php:fpm-alpine3.7

ARG BUILD_DATE
ARG VCS_REF
ARG IMAGE_NAME
ARG DOCKER_REPO
ENV COMPOSER_ALLOW_SUPERUSER 1

LABEL Maintainer="Mhd Zaher Ghaibeh <z@zah.me>" \
      org.label-schema.name="zaherg/php-and-nginx:latest" \
      org.label-schema.description="Lightweight container with Nginx 1.12 & PHP-FPM 7.2 based on Alpine Linux." \
      org.label-schema.url="https://www.zah.me" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/linuxjuggler/php-and-nginx.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0"


COPY root/. /

RUN echo "@community http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add ca-certificates rsyslog logrotate runit && \
    apk add curl && \
    cd /tmp && \
    curl -Ls https://github.com/nimmis/docker-utils/archive/master.tar.gz | tar xfz - && \
    ./docker-utils-master/install.sh && \
    rm -Rf ./docker-utils-master && \
    apk del curl && \
    sed  -i "s|\*.emerg|\#\*.emerg|" /etc/rsyslog.conf && \
    sed -i 's/$ModLoad imklog/#$ModLoad imklog/' /etc/rsyslog.conf && \
    sed -i 's/$KLogPermitNonKernelFacility on/#$KLogPermitNonKernelFacility on/' /etc/rsyslog.conf && \
    sed -i 's/user = www-data/user = nginx/' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i 's/group = www-data/group = nginx/' /usr/local/etc/php-fpm.d/www.conf && \
    apk add nginx && \
    mkdir /web && mkdir /run/nginx && \
    rm -rf /var/cache/apk/*

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

COPY rootfs /

VOLUME /web

COPY web /web/html

EXPOSE 80 443

# Define default command.
CMD ["/boot.sh"]
