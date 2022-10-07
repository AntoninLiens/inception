# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/26 17:44:18 by aliens            #+#    #+#              #
#    Updated: 2022/10/07 15:45:51 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

chown -R mysql:mysql /var/lib/mysql

if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	service mysql start

	echo "trying something"
	mkdir -p /var/run/mysqld
	touch /var/run/mysqld/mysqlf.pid

	echo "create $MARIADB_DATABASE"
	mysql -e "create database $MARIADB_DATABASE"
	mysql -e "create user '$MARIADB_USER'@'%' identified by '$MARIADB_USER_PASSWORD'"
	mysql -e "grant all privileges on $MARIADB_DATABASE.* to $MARIADB_USER@'%'"

	echo "apply changes"
	mysql -e "FLUSH PRIVILEGES"

	service mysql stop
else
	mkdir -p /var/run/mysqld
	touch /var/run/mysqld/mysqlf.pid
	mkfifo /var/run/mk
fi

chown -R mysql:mysql /var/run/mysqld

mysqld_safe --datadir=/var/lib/mysql
