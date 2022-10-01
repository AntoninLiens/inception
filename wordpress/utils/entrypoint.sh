# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/28 14:34:37 by aliens            #+#    #+#              #
#    Updated: 2022/09/30 14:53:17 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

rm -rf /var/www/worpress/wp-config.php

wp config create \
	--dbname=$MARIADB_DATABASE \
	--dbuser=$MARIADB_USER \
	--dbpass=$MARIADB_USER_PASSWORD \
	--dbhost=$MARIADB_HOST \
	--path="/var/www/wordpress/" \
	--allow-root \
	--skip-check