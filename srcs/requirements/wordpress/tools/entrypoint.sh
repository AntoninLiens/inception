# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 14:08:22 by aliens            #+#    #+#              #
#    Updated: 2022/10/13 16:23:37 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

grep -E "listen = 9000" "/etc/php/7.3/fpm/pool.d/www.conf" > /dev/null 2>&1
if [ $? -ne 0 ]; then
 	echo "listen port configuration"
	sed -i "s|.*listen = /run/php/php7.3-fpm.sock.*|listen = 9000|g" "/etc/php/7.3/fpm/pool.d/www.conf" 
fi

cat /.setup 2> /dev/null
if [ $? -ne 0 ]; then
	echo "create config.php"
	wp config create \
			--dbname=$MARIADB_DATABASE \
			--dbuser=$MARIADB_USER \
			--dbpass=$MARIADB_PASSWORD \
			--dbhost=$MARIADB_HOST \
			--path="/var/www/wordpress/" \
			--allow-root \
			--skip-check
	touch /.setup
fi

if ! wp core is-installed --allow-root; then
	echo "install wordpress"
	wp core install \
		--url="$WORDPRESS_URL" \
		--title="$WORDPRESS_TITLE" \
		--admin_user="$WORDPRESS_ADMIN_USER" \
		--admin_password="$WORDPRESS_ADMIN_PWD" \
		--admin_email="$WORDPRESS_ADMIN_EMAIL" \
		--skip-email \
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
		--post_title=$WORDPRESS_TITLE\
		--allow-root
fi

echo "start"
php-fpm7.3 --nodaemonize
