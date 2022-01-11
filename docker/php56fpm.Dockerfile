FROM php:5.6-fpm

WORKDIR /var/www/html

ADD ./ini/php56.ini /usr/local/etc/php/php.ini

ARG USER_ID
ARG GROUP_ID

RUN apt-get update && apt-get install -y \
        curl \
        wget \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev libzip4 libzip-dev libonig-dev zlib1g-dev libicu-dev g++ libmagickwand-dev --no-install-recommends libxml2-dev libxslt-dev

RUN docker-php-ext-configure intl \
    && docker-php-ext-install intl
RUN docker-php-ext-install zip xml gd mysqli pdo pdo_mysql xsl calendar opcache \
    && pecl install imagick \
    && docker-php-ext-enable imagick
RUN pecl install xdebug-2.5.5 \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini



RUN wget https://getcomposer.org/installer -O - -q \
    | php -- --install-dir=/bin --filename=composer --quiet


RUN usermod -u ${USER_ID} www-data && groupmod -g ${GROUP_ID} www-data

USER "${USER_ID}:${GROUP_ID}"

CMD ["php-fpm"]
