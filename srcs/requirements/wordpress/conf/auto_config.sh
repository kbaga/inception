#!/bin/bash

set -e

echo "Waiting for MariaDB"
while ! mariadb -h"${MYSQL_HOST}" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SELECT 1;" >/dev/null 2>&1; do
	sleep 2
done
echo "Database is ready"

cd /var/www/html

#if wo files missing download them
if [ ! -f "wp-load.php" ]; then
	echo "Downloading wordpress..."
	wp core download --allow-root
fi

#download wp core if not already there

if [ ! -f "wp-config.php" ]; then
	echo "setting up wp-config.php..."
	wp config create \
		--allow-root \
		--dbname="${MYSQL_DATABASE}" \
		--dbuser="${MYSQL_USER}" \
		--dbpass="${MYSQL_PASSWORD}" \
		--dbhost="${MYSQL_HOST}" 
	
	echo " Installing Wordpress..."
	wp core install \
		--allow-root \
		--url="${WP_PATH}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASS}" \
		--admin_email="${WP_ADMIN_EMAIL}" 

	echo "Creatimg second user"
	wp user create "${WP_USER}" "${WP_USER_EMAIL}" --role=author --user_pass="${WP_USER_PWD}" --allow-root
else
	echo "Wordpress already configured - skipping installation."
fi

#fix permissions
chown -R www-data:www-data /var/www/html

echo "Starting PHP-FPM..."

exec php-fpm8.4 -F

