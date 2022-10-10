if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	service mysql start

	echo "create $MARIADB_DATABASE"
	eval "echo \"$(cat /tmp/config.sql)\"" | mariadb -u root

	service mysql stop
fi

mysqld_safe --datadir=/var/lib/mysql
