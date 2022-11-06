FROM php:7.4.24-fpm

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION

ENV COMPOSER_VERSION 2.4.4

RUN apt-get update && apt-get install -y wget curl unzip default-mysql-client awscli
RUN docker-php-ext-install mysqli

# Install composer
RUN wget https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

WORKDIR /tools

COPY ./config/loc/images/tools/src/composer.* ./

RUN composer install

# Install nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt install -y nodejs

# Install yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn
