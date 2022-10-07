# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/26 17:44:18 by aliens            #+#    #+#              #
#    Updated: 2022/10/07 11:28:49 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	service mysql start

	echo "update root password"
	mysql -e "UPDATE mysql.user SET Password = PASSWORD('$MARIADB_ROOT_PASSWORD') WHERE User = 'root'"
	
	echo "delete root access"
	mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"

	echo "create $MARIADB_DATABASE"
	mysql -e "create database $MARIADB_DATABASE"
	mysql -e "create user '$MARIADB_USER'@'%' identified by '$MARIADB_USER_PASSWORD'"
	mysql -e "grant all privileges on $MARIADB_DATABASE.* to $MARIADB_USER@'%'"

	echo "apply changes"
	mysql -e "FLUSH PRIVILEGES"

	service mysql stop
fi

mysqld_safe --datadir=/var/lib/mysql