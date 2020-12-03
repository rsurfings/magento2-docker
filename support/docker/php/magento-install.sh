#!/bin/sh

# supervisor
#exec supervisord -c /etc/supervisord.conf

# maybe it has errors because of dependencies and versions so it is accurate the --ignore-platform-reqs flag 
composer install && composer update

find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
chmod u+x bin/magento

# maybe it presents errors because of the admin user if it is already in the base remove all options --admin-

bin/magento setup:install \
--base-url=http://127.0.0.1 \
--db-host=magento2-database \
--db-name=magento2 \
--db-user=root \
--db-password=magento2 \
--admin-firstname=admin \
--admin-lastname=admin \
--admin-email=admin@admin.com \
--admin-user=admin \
--admin-password=admin123 \
--language=pt_BR \
--currency=BRL \
--backend-frontname="admin" \
--timezone=America/Chicago \
--use-rewrites=1 \
--elasticsearch-host=magento2-elasticsearch \
--elasticsearch-port=9200 \
--elasticsearch-username=elastic \
--elasticsearch-password=magento2

# cleaning and correcting errors
php bin/magento setup:upgrade

php bin/magento cache:flush
php bin/magento deploy:mode:set developer
php bin/magento indexer:reindex
php bin/magento setup:di:compile
php bin/magento setup:static-content:deploy -f 

composer dump-autoload -o

clear && echo "
===================== 🚀 Done 🚀 ===================
      Magento 2 Installed successfully!
      🌎 Admin: http://127.0.0.1/admin/
      👤 User: admin
      🔑 Password: admin123
===================== 🚀 Done 🚀 ==================="

# end ... ufa ;)