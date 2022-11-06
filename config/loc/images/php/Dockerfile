FROM php:8.1-fpm

ENV COMPOSER_VERSION 2.4.4

RUN apt-get update && apt-get install -y \
  curl \
  software-properties-common \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libpng-dev \
  libonig-dev \
  libxml2-dev \
  libzip-dev \
  libcurl3-dev \
  unzip \
  mariadb-client \
  wget \
  libmagickwand-dev --no-install-recommends \
  default-mysql-client \
  libmagickwand-dev --no-install-recommends \
  && pecl install imagick

RUN docker-php-ext-install mysqli curl gd mbstring xml soap intl zip gd exif \
  && docker-php-ext-enable imagick

RUN

COPY ./src/ /var/www/html

# Install composer
RUN wget https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

WORKDIR /var/www/html
