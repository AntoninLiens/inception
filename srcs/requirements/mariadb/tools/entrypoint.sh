# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 11:54:04 by aliens            #+#    #+#              #
#    Updated: 2022/10/10 17:19:38 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	service mysql start --datadir=/var/lib/mysql

	echo "create $MARIADB_DATABASE"
	# eval "echo \"$(cat config.sql)\"" | mariadb -u root
	mariadb -u root "UPDATE mysql.user SET Password = PASSWORD('$MARIADB_ROOT_PASSWORD') WHERE User = 'root'"
	mariadb -u root "CREATE DATABASE $MARIADB_DATABASE"
	mariadb -u root "CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_PASSWORD'"
	mariadb -u root "GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO $MARIADB_USER@'%'"
	mariadb -u root "FLUSH PRIVILEGES"

	service mysql stop --datadir=/var/lib/mysql
fi

echo "start"
mysqld_safe --datadir=/var/lib/mysql
