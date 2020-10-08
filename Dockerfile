FROM php:7.4-fpm

LABEL maintainer="Mateusz Gostanski <mg@grixu.dev>"

ARG user_uid=1001
ARG group_gid=1001
ARG port=8999

USER root
RUN apt-get update

ENV FPM_PORT=$port

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    libcurl3-dev \
    zip \
    libgmp-dev \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    procps \
    iputils-ping \
    nano

RUN apt-get update && apt-get install -y \
    libmcrypt-dev \
    zlib1g-dev \
    libxml2-dev \
    libzip-dev \
    libonig-dev \
    graphviz

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install opcache
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl curl bcmath gmp
RUN docker-php-ext-install gd

RUN apt-get update && \
    pecl channel-update pecl.php.net && \
    pecl install redis && \
    docker-php-ext-enable redis && \
    docker-php-source delete

RUN apt-get install -y libmagickwand-dev
# RUN pecl install imagick && docker-php-ext-enable imagick

RUN apt-get update && \
    pecl channel-update pecl.php.net && \
    pecl install imagick && \
    docker-php-ext-enable imagick && \
    docker-php-source delete

# Human Language and Character Encoding Support
RUN apt-get install -y zlib1g-dev libicu-dev g++
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN addgroup --system --gid $group_gid nginx
RUN mkdir /home/nginx
RUN useradd --uid $user_uid -g $group_gid --home-dir /home/nginx nginx
RUN chown nginx:nginx /home/nginx

# Clean up
RUN apt-get clean
RUN apt-get -y autoremove
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY fpm /usr/local/etc/php-fpm.d
COPY local.ini /usr/local/etc/php/conf.d/local.ini

# Change current user to www
USER nginx

# Expose port 9000 and start php-fpm server
EXPOSE 8999
CMD ["php-fpm"]
