# Menggunakan image PHP resmi sebagai base image
FROM php:8.0-fpm

# Install dependensi sistem
RUN apt-get update && apt-get install -y \
 libpng-dev \
 libjpeg-dev \
 libfreetype6-dev \
 libzip-dev \
 unzip \
 libonig-dev \
 libcurl4-openssl-dev \
 libxml2-dev \
 git

# Install ekstensi PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install gd zip pdo pdo_mysql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy aplikasi Laravel
COPY . .

# Install dependensi PHP dengan Composer
RUN composer install

# Expose port yang digunakan oleh PHP-FPM
EXPOSE 9000

# Jalankan PHP-FPM
CMD ["php-fpm"]
