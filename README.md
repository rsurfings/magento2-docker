# Docker image for Magento 2

## Quick start
~~~
$ docker-compose up --build
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

## FAQ

### How to keep installed Magento?

You can add a volume to folder `/var/www`, see the `docker-compose.yml` file.

```
volumes:
      - ./src:/var/www
```

## Materiais úteis
- http://br.phptherightway.com/
- https://www.php-fig.org/psr/psr-12/
- https://www.atlassian.com/continuous-delivery/software-testing/types-of-software-testing
- https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
- https://devdocs.magento.com/
- https://devdocs.magento.com/guides/v2.4/install-gde/system-requirements.html