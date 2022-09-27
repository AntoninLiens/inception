# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/26 17:44:18 by aliens            #+#    #+#              #
#    Updated: 2022/09/27 17:20:52 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# Give owner and group for the the DB which is normally automatically created in this folder 
chown -R mysql:mysql /var/lib/mysql
# Create a folder for the daemon (mysql server’s socket file)
mkdir -p /var/run/mysqld
#Give owner and group to that too
chown -R mysql:mysql /var/run/mysqld
#touch /var/run/mysqld/mysqlf.pid
mkfifo /var/run/mysqld/mysqld.sock

service mysql start

echo "update root password"
mysql -e "UPDATE mysql.user SET Password = PASSWORD('$MARIADB_ROOT_PASSWORD') WHERE User = 'root'"

echo "kill the anonymous users"
mysql -e "DROP USER ''@'localhost'"
mysql -e "DROP USER ''@'$(hostname)'"

echo "kill off the demo database"
mysql -e "DROP DATABASE test"

echo "create $MARIADB_DATABASE"
mysql -e "create database $MARIADB_DATABASE"
mysql -e "create user '$MARIADB_USER'@'%' identified by '$MARIADB_USER_PASSWORD'"
mysql -e "grant all privileges on $MARIADB_DATABASE.* to $MARIADB_USER@'%'"

echo "make our changes take effect"
mysql -e "FLUSH PRIVILEGES"

service mysql stop

mysqld_safe
