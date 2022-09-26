#!/bin/bash

mysql -e "UPDATE mysql.user SET Password = PASSWORD('$MARIADB_ROOT_PASSWORD') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE test"

mysql -e "create database $MARIADB_DATABASE"
mysql -e "create user '$MARIADB_USER'@'%' identified by '$MARIADB_USER_PASSWORD'"
mysql -e "grant all privileges on $MARIADB_DATABASE.* to $MARIADB_USER@'%'"

# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"