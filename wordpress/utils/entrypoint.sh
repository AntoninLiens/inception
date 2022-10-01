# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/28 14:34:37 by aliens            #+#    #+#              #
#    Updated: 2022/10/01 17:48:46 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# chown -R www-data:www-data /var/www/wordpress
rm -rf /var/www/wordpress/wp-config.php

echo "create config.php"
wp config create \
	--dbname=$MARIADB_DATABASE \
	--dbuser=$MARIADB_USER \
	--dbpass=$MARIADB_USER_PASSWORD \
	--dbhost=$MARIADB_HOST \
	--path="/var/www/wordpress/" \
	--allow-root \
	--skip-check

if ! wp core is-installed --allow-root; then
	echo "install wordpress"
	wp core install \
		--url=$WORPRESS_URL \
		--title=$WORPRESS_TITLE \
		--admin-user=$WORPRESS_ROOT \
		--admin-password=$WORPRESS_ROOT_PASSWORD \
		--path="/var/www/wordpress" \
		--allow-root \
		--skip-email

	echo "update wordpress"
	wp plugin update --all --allow-root

	echo "create first user"
	wp user create $WORPRESS_USER \
		--user-pass=$WORPRESS_USER_PASSWORD \
		--role-editor \
		--allow-root \
		--skip-email

	echo "create first post"
	wp post generate \
		--count=1 \
		--post-title= \
			"Les Aliens sont partout,
			ils sont dans les campagnes,
			ils sont dans les villes !!!!" \
		--post-author="Un Aliens gentils" \
		--post-content= \
			"J'ai traverse les armees des
			Aliens pour vous faire parvenir
			ce message; Vous devez ils sont partout,
			ils arrivent pour vous manger !!!" \
		--allow-root
fi

php-fpm7.3 --nodemonize
