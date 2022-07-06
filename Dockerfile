FROM composer AS composer

COPY . /app

RUN composer install

FROM node:12 AS node

COPY --from=composer /app /usr/src/app

WORKDIR /usr/src/app/

RUN npm ci
RUN npm run prod

FROM php:8.1-fpm AS azuriom-php

RUN apt-get update && apt-get install -y libicu-dev libzip-dev \
    libicu-dev zlib1g-dev libpng-dev libjpeg-dev libxml2-dev \
    libfreetype6-dev libmcrypt-dev libpng-dev libcurl3-dev libonig-dev

# Install Postgre PDO
RUN apt-get install -y libpq-dev \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql pgsql zip

RUN apt-get clean

RUN docker-php-ext-install intl opcache bcmath

COPY ./docker/php/custom.ini $PHP_INI_DIR/conf.d/

COPY ./docker/php/docker.conf /usr/local/etc/php-fpm.d/docker.conf

WORKDIR /usr/share/nginx/html

COPY --from=node /usr/src/app /usr/share/nginx/html

RUN php artisan storage:link

RUN chmod -R o+rw storage bootstrap/cache resources/themes plugins
RUN chmod -R o+rw .

RUN mkdir /var/azuriom
RUN chown -R www-data:www-data /var/azuriom

RUN php artisan key:generate

CMD sleep 2 && php artisan migrate --seed --force && php artisan user:create --admin --name=admin --email=example@example.com --password=changeme ; php-fpm


FROM nginx:1.19-alpine as azuriom-nginx

COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf

COPY --from=azuriom-php /usr/share/nginx/html /usr/share/nginx/html
