FROM php:7.3-fpm

LABEL maintainer="rsurfings@gmail.com"

# Arguments defined in docker-compose.yml
ARG user
ARG uid
ARG composer_version
ARG xdebug=false
ARG php_memory_limit=false
ARG xdebug_remote_host=false

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

# add ssh key
ADD ./root/.ssh /root/.ssh
RUN chmod 400 -R /root/.ssh

COPY ./php-fpm.d /usr/local/etc/php-fpm.d
# Set working directory
WORKDIR /var/www/html

USER ${user}

# Copy hooks
COPY ./hooks /hooks/

#COPY entrypoint.sh /usr/local/bin/entrypoint.sh

#ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]