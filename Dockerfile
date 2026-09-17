FROM php:8.1-fpm
RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pdo pdo_pgsql
WORKDIR /var/www/html
COPY . .
RUN composer install --no-dev --optimize-autoloader || true
RUN php artisan config:clear && php artisan cache:clear
RUN php artisan migrate --force
CMD ["php", "artisan", "serve", "--host=0.0.0.0"]
