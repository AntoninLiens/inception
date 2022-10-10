# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 14:08:22 by aliens            #+#    #+#              #
#    Updated: 2022/10/10 14:41:43 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

if ! wp core is-installed --allow-root; then
	
	echo "create config.php"
	rm -rf /var/www/html/wordpress/wp-config.php
	wp config create \
			--dbname=$MARIADB_DATABASE \
			--dbuser=$MARIADB_USER \
			--dbpass=$MARIADB_PASSWORD \
			--dbhost=$MARIADB_HOST \
			--path="/var/www/html/wordpress/" \
			--allow-root \
			--skip-check
	
	echo "install wordpress"
	wp core install \
		--url="$WORDPRESS_URL" \
		--title="$WORDPRESS_TITLE" \
		--admin_user="$WORDPRESS_ADMIN_USER" \
		--admin_password="$WORDPRESS_ADMIN_PWD" \
		--admin_email="$WORDPRESS_ADMIN_EMAIL" \
		--allow-root

	echo "update wordpress"
	wp plugin update --all --allow-root

	echo "create first user"
	wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL \
		--role=editor \
		--user_pass=$WORDPRESS_USER_PWD \
		--allow-root

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

echo "start"
php-fpm7.3 --nodaemonize
