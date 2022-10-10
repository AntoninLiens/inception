# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 11:54:04 by aliens            #+#    #+#              #
#    Updated: 2022/10/10 12:50:56 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

if [ ! -d /var/lib/mysql/$MARIADB_DATABASE ]; then
	service mysql start --datadir=/var/lib/mysql

	eval "echo \"$(cat /tmp/config.sql)\"" | mariadb -u root
	echo "create $MARIADB_DATABASE"

	service mysql stop --datadir=/var/lib/mysql
fi

echo "start"
mysqld_safe --datadir=/var/lib/mysql
