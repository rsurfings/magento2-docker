FROM php:7.3-fpm

LABEL maintainer="rsurfings@gmail.com"

# Arguments defined in docker-compose.yml
ARG user
ARG uid
ARG composer_version

# Install dependencies
RUN apt-get update \
    && apt-get install -y \
    libfreetype6-dev \ 
    libicu-dev \ 
    libjpeg62-turbo-dev \ 
    libmcrypt-dev \ 
    libpng-dev \ 
    libxslt1-dev \ 
    sendmail-bin \ 
    sendmail \ 
    sudo \ 
    libzip-dev \
    git

# Install required PHP extensions
RUN docker-php-ext-install \
    dom \ 
    gd \ 
    intl \ 
    mbstring \ 
    pdo_mysql \ 
    xsl \ 
    zip \ 
    soap \ 
    bcmath \ 
    pcntl \ 
    sockets

# Configure the gd library
RUN docker-php-ext-configure \
    gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

# Install Composer
# Get composer installed to /usr/local/bin/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --version=${composer_version} --filename=composer
RUN composer --version

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# install xdebug
RUN yes | pecl install xdebug
RUN docker-php-ext-enable xdebug

# Instalação e configuração do XDebug
RUN echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_handler=dbgp" >>  /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.idekey=docker" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_log=/tmp/xdebug.log" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.default_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "memory_limit=2G" > /usr/local/etc/php/conf.d/memory-limit.ini

# Create system user to run Composer and magento Commands
RUN useradd -G www-data,root -u ${uid} -d /home/${user} ${user}
RUN mkdir -p /home/${user}/.composer

# add ssh key bitbucket
ADD ./root/.ssh /home/${user}/.ssh
RUN chmod 400 -R /home/${user}/.ssh
RUN chown -R ${user}:${user} /home/${user}

# Set working directory
WORKDIR /var/www/

USER ${user}
