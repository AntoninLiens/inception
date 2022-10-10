# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 11:54:04 by aliens            #+#    #+#              #
#    Updated: 2022/10/10 11:54:57 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	service mysql start --datadir=/var/lib/mysql

	eval "echo \"$(cat /tmp/config.sql)\"" | mariadb -u root
	echo "create $MARIADB_DATABASE"

	service mysql stop --datadir=/var/lib/mysql
fi

mysqld_safe --datadir=/var/lib/mysql
