# Give owner and group for the the DB which is normally automatically created in this folder 
chown -R mysql:mysql /var/lib/mysql

#Just checking if the DB has been correctly created in the right path
if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	service mysql start --datadir=/var/lib/mysql
	echo "--Service started"

	# Create a folder for the daemon (mysql server’s socket file)
	mkdir -p /var/run/mysqld
	# Setting up .pid if it's not automatically set 
	# .sock file has been automatically created at this point
	touch /var/run/mysqld/mysqlf.pid

	# Execute the .sql to setup the database
	eval "echo \"$(cat /tmp/config.sql)\"" | mariadb -u root

	# Set MySQL root password (if you don't set it no password at all)
	mysqladmin -u root password $MARIADB_ROOT_PASSWORD;
	echo "--Password set"

	service mysql stop --datadir=/var/lib/mysql
	echo "--Service stopped"
else
	# Create a folder for the daemon (mysql server’s socket file)
	mkdir -p /var/run/mysqld
	#Setting up .pid and .sock since they're not automatically set
	touch /var/run/mysqld/mysqlf.pid
	mkfifo /var/run/mk
fi

#Give owner and group to that too
chown -R mysql:mysql /var/run/mysqld
#Start the database daemon
echo "--start DB daemon"
mysqld_safe --datadir=/var/lib/mysql
