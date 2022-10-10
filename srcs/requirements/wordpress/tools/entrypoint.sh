# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    entrypoint.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/28 14:34:37 by aliens            #+#    #+#              #
#    Updated: 2022/10/10 10:17:09 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/sh

# echo "create config.php"
# rm -rf /var/www/html/wordpress/wp-config.php
# wp config create \
# 	--dbname=$MARIADB_DATABASE \
# 	--dbuser=$MARIADB_USER \
# 	--dbpass=$MARIADB_USER_PASSWORD \
# 	--dbhost=$MARIADB_HOST \
# 	--path="/var/www/html/wordpress/" \
# 	--allow-root \
# 	--skip-check

# if ! wp core is-installed --path="/var/www/html/wordpress/" --allow-root; then
# 	echo "install wordpress"
# 	wp core install \
# 		--url=$WORDPRESS_URL \
# 		--title=$WORDPRESS_TITLE \
# 		--admin_user=$WORDPRESS_ROOT \
# 		--admin_password=$WORDPRESS_ROOT_PASSWORD \
# 		--path="/var/www/html/wordpress/" \
# 		--allow-root \
# 		--skip-email
# fi

# 	echo "update wordpress"
# 	wp plugin update --all --allow-root

# 	echo "create first user"
# 	wp user create $WORDPRESS_USER \
# 		--user-pass=$WORDPRESS_USER_PASSWORD \
# 		--role-editor \
# 		--allow-root \
# 		--skip-email

# 	echo "create first post"
# 	wp post generate \
# 		--count=1 \
# 		--post-title= \
# 			"Les Aliens sont partout,
# 			ils sont dans les campagnes,
# 			ils sont dans les villes !!!!" \
# 		--post-author="Un Aliens gentils" \
# 		--post-content= \
# 			"J'ai traverse les armees des
# 			Aliens pour vous faire parvenir
# 			ce message; Vous devez ils sont partout,
# 			ils arrivent pour vous manger !!!" \
# 		--allow-root
# fi

# php-fpm7.3 --nodemonize

# The www.conf file is needed for communication with the server
grep -E "listen = 9000" "/etc/php/7.3/fpm/pool.d/www.conf" > /dev/null 2>&1

# If not found it's useless to modify it 
if [ $? -ne 0 ]; then
 	echo "--Modifying configuration file"
	# Replacing the listen part
	 sed -i "s|.*listen = /run/php/php7.3-fpm.sock.*|listen = 9000|g" "/etc/php/7.3/fpm/pool.d/www.conf" 
fi

# Instead of writing a wp-config.php file ourselves we can just generate one using the wordpress cli
rm -rf /var/www/html/wordpress/wp-config.php
wp config create --dbname=$MARIADB_DATABASE \
		--dbuser=$MARIADB_USER \
		--dbpass=$MARIADB_PASSWORD \
		--dbhost=$MARIADB_HOST \
		--path="/var/www/html/wordpress/" \
		--allow-root \
		--skip-check

# Wordpress installing
if ! wp core is-installed --allow-root; then
	echo "--Installing Wordpress"
	wp core install --url="$WORDPRESS_URL" \
					--title="$WORDPRESS_TITLE" \
					--admin_user="$WORDPRESS_ADMIN_USER" \
					--admin_password="$WORDPRESS_ADMIN_PWD" \
					--admin_email="$WORDPRESS_ADMIN_EMAIL" \
					--skip-email \
					--allow-root

fi

# Simple update for wordpress 
echo "--Updating wordpress"
wp plugin update --all --allow-root

# Create user (check how simon does it)
echo "--Creating example user"
wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=editor \
													--user_pass=$WORDPRESS_USER_PWD \
													--allow-root
# Create article example 
echo "--Creating example article"
wp post generate --count=1 --post_title="example-post" --allow-root

# We need this FastCGI Process Manager to run wordpress but also so that the container keeps running
# --nodaemonize == keep foreground
echo "--Starting "
php-fpm7.3 --nodaemonize
