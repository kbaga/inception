#!/bin/sh
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

#init datadir
if [ ! -d "/var/lib/mysql/mysql" ]; then
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
	
	echo "starting temporary MariaDB server"
	mysql --user=mysql --skip-networking --socket=/run/mysqld/mysqld.sock & temp_pid=$!

	echo "Waiting for MariaDB to be ready..."
	for i in {30..0}; do
	       if [ -S /run/mysqld/mysqld.sock ]; then
	       		break
	       fi
	       sleep 1
	done
	if [ ! -S /run/mysqld/mysqld.sock ]; then
		echo "MariaDB didn't start properly - abroting setup"
		kill "$temp_pid" || true
		exit 1
	fi
			       
	echo "MariaDB is ready, configurin initial users..."
mysql -u root <<-EOSQL
CREATE DATABABSE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOSQL
	echo "Shutting down temporary MariaDB"

mysqladmin -uroot -p"$MYSQL_ROOT_PASSWORD" shutdown
	echo "MariaDB initial setup complete"
else
	echo "existing Data found - skipping init"
fi

echo "Starting MariaDB in foreground..."
exec mysqld --user=mysql --console

