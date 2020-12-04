#!/usr/bin/env bash

while test $# -gt 0; do
    case "$1" in
        -h|--help)
            echo "options:"
            echo "-h, --help                                Show brief help"
            echo "-r, --run-instalation=DIR                 Run Instalation"
            echo "-rs, --run-instalation-sampledata=DIR     Run instalation with sampledata"
            exit 0
            ;;
        -rs|--run-instalation-sampledata)
            shift
                echo Start composer instalation project;
                composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition .;
                echo Start SampleData deploy;
                php -d memory_limit=-1 magento/bin/magento sampledata:deploy;
                echo Start Magento install;
                php -d memory_limit=-1 bin/magento setup:install \
                                            --base-url=${HOST} \
                                            --db-host=${DATABASE_HOST} \
                                            --db-name=${DATABASE_NAME} \
                                            --db-user=${DATABASE_USER} \
                                            --db-password=${DATABASE_PASSWORD} \
                                            --admin-firstname=${ADMIN_FIRSTNAME} \
                                            --admin-lastname=${ADMIN_LASTNAME} \
                                            --admin-email=${ADMIN_EMAIL} \
                                            --admin-user=${ADMIN_USER} \
                                            --admin-password=${ADMIN_PASSWORD} \
                                            --language=${LANGUAGE} \
                                            --currency=${CURRENCY} \
                                            --backend-frontname=${BACKEND_FRONTNAME} \
                                            --timezone=${TIMEZONE} \
                                            --use-rewrites=${USE_REWRITES} \
                                            --elasticsearch-host=${ELASTICSEARCH_HOST} \
                                            --elasticsearch-port=${ELASTICSEARCH_POST} \
                                            --elasticsearch-username=${ELASTICSEARCH_USERNAME} \
                                            --elasticsearch-password=${ELASTICSEARCH_PASSWORD}
                echo Start compilation;
                php -d memory_limit=-1 magento/bin/magento setup:static-content:deploy;
            shift
            ;;
        -r|--run-instalation)
            shift
                echo Start composer instalation project;
                composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition magento;
                echo Start Magento install;
                php -d memory_limit=-1 bin/magento setup:install \
                                            --base-url=${HOST} \
                                            --db-host=${DATABASE_HOST} \
                                            --db-name=${DATABASE_NAME} \
                                            --db-user=${DATABASE_USER} \
                                            --db-password=${DATABASE_PASSWORD} \
                                            --admin-firstname=${ADMIN_FIRSTNAME} \
                                            --admin-lastname=${ADMIN_LASTNAME} \
                                            --admin-email=${ADMIN_EMAIL} \
                                            --admin-user=${ADMIN_USER} \
                                            --admin-password=${ADMIN_PASSWORD} \
                                            --language=${LANGUAGE} \
                                            --currency=${CURRENCY} \
                                            --backend-frontname=${BACKEND_FRONTNAME} \
                                            --timezone=${TIMEZONE} \
                                            --use-rewrites=${USE_REWRITES} \
                                            --elasticsearch-host=${ELASTICSEARCH_HOST} \
                                            --elasticsearch-port=${ELASTICSEARCH_POST} \
                                            --elasticsearch-username=${ELASTICSEARCH_USERNAME} \
                                            --elasticsearch-password=${ELASTICSEARCH_PASSWORD}
                echo Start compilation;
                php -d memory_limit=-1 magento/bin/magento setup:static-content:deploy;
            shift
            ;;

        *)
            echo "The initialization process was not performed!"
            break
            ;;
    esac
done

clear && echo "
===================== 🚀 Done 🚀 ===================
      Magento 2 Installed successfully!
      🌎 Admin: ${HOST}/admin/
      👤 User: ${ADMIN_USER}
      🔑 Password: ${ADMIN_PASSWORD}
===================== 🚀 Done 🚀 ==================="