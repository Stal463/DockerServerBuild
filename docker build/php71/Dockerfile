FROM php:7.1-fpm

WORKDIR /var/www/html

ADD ./php.ini /usr/local/etc/php/php.ini

ENV USER_ID=1000
ENV GROUP_ID=1000

RUN apt-get update && apt-get install -y \
        curl \
        wget \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev libzip4 \
        libzip-dev libonig-dev \
        zlib1g-dev libicu-dev g++ libmagickwand-dev --no-install-recommends  \
        libxml2-dev libxslt-dev \
        libpq-dev mariadb-client \
        libwebp-dev

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-webp-dir=/usr/include/
RUN docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    zip xml gd \
    mysqli pdo pdo_mysql \
    xsl calendar opcache \
    pgsql pdo_pgsql \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && pecl install redis  \
    && docker-php-ext-enable redis

RUN pecl install xdebug-2.8.1 \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini



RUN wget https://getcomposer.org/installer -O - -q \
    | php -- --install-dir=/bin --filename=composer --quiet


RUN usermod -u ${USER_ID} www-data && groupmod -g ${GROUP_ID} www-data

USER "${USER_ID}:${GROUP_ID}"

CMD ["php-fpm"]
