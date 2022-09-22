chown -R mysql:mysql /var/lib/mysql

if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	service mysql start --datadir=/var/lib/mysql

	mkdir -p /var/run/mysqld
	touch /var/run/mysqld/mysqlf.pid

	eval "echo \"$(cat /tmp/config.sql)\"" | mariadb -u root

	mysqladmin -u root password $MARIADB_ROOT_PASSWORD;

	service mysql stop --datadir=/var/lib/mysql
else
	mkdir -p /var/run/mysqld
	touch /var/run/mysqld/mysqlf.pid
	mkfifo /var/run/mk
fi

chown -R mysql:mysql /var/run/mysqld
mysqld_safe --datadir=/var/lib/mysql