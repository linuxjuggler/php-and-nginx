[![Docker Pulls](https://img.shields.io/docker/pulls/zaherg/php-and-nginx.svg)](https://hub.docker.com/r/zaherg/php-and-nginx/) [![](https://images.microbadger.com/badges/image/zaherg/php-and-nginx.svg)](https://microbadger.com/images/zaherg/php-and-nginx "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/zaherg/php-and-nginx.svg)](https://microbadger.com/images/zaherg/php-and-nginx "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/zaherg/php-and-nginx.svg)](https://microbadger.com/images/zaherg/php-and-nginx "Get your own commit badge on microbadger.com")  [![](https://img.shields.io/badge/sponsor-using%20BTC%20lightning%20network-blue.svg)](https://tippin.me/@zaherg)

# PHP And Nginx Docker image

This image was built based on the scripts that I have found at [docker-alpine-micro](https://github.com/nimmis/docker-alpine-micro) , and with the help of his [docker-utils](https://github.com/nimmis/docker-utils) script I was able to build my own image.

This is still new/simple docker image which will have:

1. PHP7.x
2. Nginx (with h5bp)

## Versions available

1. zaherg/php-and-nginx:7.2
1. zaherg/php-and-nginx:7.3
1. zaherg/php-and-nginx:7.4

*Latest* will always be used with the latest PHP version

### NOTE:

1. Starting from 2020, We have removed `crond` and `rsyslogd`  and they wont be installed nor activated any more.
1. Also we removed xdebug as it is pointless to have it.

## Using php-and-nginx as your base image

This is a sample docker file which is used to build Laravel Application

```dockerfile
FROM zaherg/php-and-nginx:7.4

ENV APP_ENV production

COPY . /web/html

WORKDIR /web/html

RUN composer install  --prefer-dist --no-ansi --no-interaction --no-scripts --no-progress --no-suggest --optimize-autoloader --no-dev \
	&& sed -i 's/root \/web\/html;/root \/web\/html\/public;/' /etc/nginx/nginx.conf \
	&& chgrp -R nobody /web/html/storage /web/html/bootstrap/cache \
    && chmod -R ug+rwx /web/html/storage /web/html/bootstrap/cache \
    && chown -R nginx /web/html/storage /web/html/bootstrap/cache
```

We copy the code to the `/web/html`, since the root location for my web pages defined inside nginx configuration as 
`web/html` we run a small sed command to replace it with the root location for our Laravel application

```shell
sed -i 's/root \/web\/html;/root \/web\/html\/public;/' /etc/nginx/nginx.conf
```

**Small note**: The user we use here is `root` feel free to change it.

### OpCache

You can manage opcache using the environment variables

```
PHP_OPCACHE_VALIDATE_TIMESTAMPS=0
PHP_OPCACHE_MAX_ACCELERATED_FILES=10000
PHP_OPCACHE_MEMORY_CONSUMPTION=192
PHP_OPCACHE_MAX_WASTED_PERCENTAGE=10
```

## PHP Modules

1. Core
1. ctype
1. curl
1. date
1. dom
1. fileinfo
1. filter
1. ftp
1. hash
1. iconv
1. json
1. libxml
1. mbstring
1. mysqlnd
1. openssl
1. pcre
1. PDO
1. pdo_sqlite
1. Phar
1. posix
1. readline
1. Reflection
1. session
1. SimpleXML
1. SPL
1. sqlite3
1. standard
1. tokenizer
1. xml
1. xmlreader
1. xmlwriter
1. zlib

## GD information
```
GD Support => enabled
GD Version => bundled (2.1.0 compatible)
FreeType Support => enabled
FreeType Linkage => with freetype
FreeType Version => 2.8.1
GIF Read Support => enabled
GIF Create Support => enabled
JPEG Support => enabled
libJPEG Version => 8
PNG Support => enabled
libPNG Version => 1.6.34
WBMP Support => enabled
XBM Support => enabled

Directive => Local Value => Master Value
gd.jpeg_ignore_warning => 1 => 1
```
