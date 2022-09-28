# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/26 17:44:18 by aliens            #+#    #+#              #
#    Updated: 2022/09/28 02:00:47 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	service mysql start

	echo "update root password"
	mysql -e "UPDATE mysql.user SET Password = PASSWORD('$MARIADB_ROOT_PASSWORD') WHERE User = 'root'"

	echo "create $MARIADB_DATABASE"
	mysql -e "create database $MARIADB_DATABASE"
	mysql -e "create user '$MARIADB_USER'@'%' identified by '$MARIADB_USER_PASSWORD'"
	mysql -e "grant all privileges on $MARIADB_DATABASE.* to $MARIADB_USER@'%'"

	echo "make our changes take effect"
	mysql -e "FLUSH PRIVILEGES"

	service mysql stop
fi

mysqld_safe --datadir=/var/lib/mysql
