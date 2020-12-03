# Docker image for Magento 2

## Quick start
~~~
$ docker-compose up -d --build
~~~

For admin username and password, please refer to the file `env`. You can also change the file `env` to update those configurations. Below are the default configurations.

~~~

APP_NAME=Magento
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://127.0.0.1
APP_TIMEZONE=UTC

DOCKER_USER=magento2
DOCKER_USER_UID=1000
COMPOSER_VERSION=1.10.16

PHP_MEMORY_LIMIT=2G

DB_CONNECTION=mysql
DB_HOST=database
DB_PORT=3306
DB_DATABASE=magento2
DB_USER=magento2
DB_PASSWORD=magento2

~~~