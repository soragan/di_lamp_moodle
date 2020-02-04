FROM php:7.3-apache
LABEL version="0.1"
LABEL maintainer="Soragan Ong <soragan@alagas.net"

RUN usermod -a -G users www-data && a2enmod rewrite
RUN apt update && apt install -y \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    libxml2-dev libcurl4-gnutls-dev zlib1g-dev libxslt1-dev libzip-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) bcmath gd intl pdo_mysql
RUN docker-php-ext-install -j$(nproc) soap xsl zip
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN mkdir /var/www/data

## Change Document Root
#ENV APACHE_DOCUMENT_ROOT /var/www/html/pub
#RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
#RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
#RUN ln -s /var/www/html/apache.conf /etc/apache2/sites-enabled/00-apache.conf
