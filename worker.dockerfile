FROM php:8.3-cli

WORKDIR /app

COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y zip libzip-dev

RUN docker-php-ext-install zip pcntl

RUN docker-php-ext-enable zip pcntl

COPY --chown=www-data:www-data . /app

RUN composer install

RUN composer require laravel/octane

RUN php artisan octane:install --server=frankenphp

EXPOSE 8000

CMD ["php", "artisan", "octane:start", "--server=frankenphp", "--host=0.0.0.0", "--port=8000"]
