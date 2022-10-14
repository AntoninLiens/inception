# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 11:54:04 by aliens            #+#    #+#              #
#    Updated: 2022/10/14 13:13:41 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	service mysql start --datadir=/var/lib/mysql

	echo "create $MARIADB_DATABASE"
	eval "echo \"$(cat config.sql)\"" | mariadb -u root

	mysqladmin -u root password $MARIADB_ROOT_PASSWORD

	service mysql stop --datadir=/var/lib/mysql
fi

mysqld_safe --datadir=/var/lib/mysql
echo "start"
