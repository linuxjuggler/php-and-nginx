[![Docker Pulls](https://img.shields.io/docker/pulls/zaherg/php-and-nginx.svg)](https://hub.docker.com/r/zaherg/php-and-nginx/) [![](https://images.microbadger.com/badges/image/zaherg/php-and-nginx.svg)](https://microbadger.com/images/zaherg/php-and-nginx "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/zaherg/php-and-nginx.svg)](https://microbadger.com/images/zaherg/php-and-nginx "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/zaherg/php-and-nginx.svg)](https://microbadger.com/images/zaherg/php-and-nginx "Get your own commit badge on microbadger.com")

# PHP And Nginx Docker image

This image was built based on the scripts that I have found at [docker-alpine-micro](https://github.com/nimmis/docker-alpine-micro) , and with the help of his [docker-utils](https://github.com/nimmis/docker-utils) script I was able to build my own image.

This is still new/simple docker image which will have:

1. PHP7.x
2. Nginx
3. Crond
4. rsyslogd

## Versions available

1. zaherg/php-xdebug-alpine:7.2
1. zaherg/php-xdebug-alpine:7.3
1. zaherg/php-xdebug-alpine:xdebug

*Latest* will always be used with the latest PHP version

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

## Xdebug Image

You can pull xdebug image which has xdebug enabled by default, to disable it you need to create a .env file which should contain the following variables, but remember to change the value based one what you want to achieve:

```
PHP_XDEBUG_DEFAULT_ENABLE=0
PHP_XDEBUG_REMOTE_ENABLE=0
PHP_XDEBUG_REMOTE_HOST=127.0.0.1
PHP_XDEBUG_REMOTE_PORT=9001
PHP_XDEBUG_REMOTE_AUTO_START=0
PHP_XDEBUG_REMOTE_CONNECT_BACK=0
PHP_XDEBUG_IDEKEY=docker
PHP_XDEBUG_PROFILER_ENABLE=0
PHP_XDEBUG_PROFILER_OUTPUT_DIR=/tmp
```

Then run the docker and specify the env file that you have created like this

```
docker run --env-file .env -p 80:80 zaherg/php-and-nginx:xdebug
```
