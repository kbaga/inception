#!/bin/bash

set -e

until mysql -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1" > /dev/null  2>&1; do
	echo "Waiting..."
	sleep 2
done

	echo "MariaDB is ready!"
if [ ! -f wp-config.php ]; then
	wp core download --allow-root
	wp config create \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost=mariadb:3306 \
		--allow-root

	wp core install \
		--url=https://$DOMAIN_NAME \
		--title=Inception \
		--admin_user=$WP_ADMIN \
		--admin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL \
		--allow-root
fi

exec php-fpm8.4 -F
