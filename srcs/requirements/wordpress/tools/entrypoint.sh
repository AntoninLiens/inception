# # The www.conf file is needed for communication with the server
# grep -E "listen = 9000" "/etc/php/7.3/fpm/pool.d/www.conf" > /dev/null 2>&1

# # If not found it's useless to modify it 
# if [ $? -ne 0 ]; then
#  	echo "--Modifying configuration file"
# 	# Replacing the listen part
# 	 sed -i "s|.*listen = /run/php/php7.3-fpm.sock.*|listen = 9000|g" "/etc/php/7.3/fpm/pool.d/www.conf" 
# fi

rm -rf /var/www/html/wordpress/wp-config.php
wp config create \
		--dbname=$MARIADB_DATABASE \
		--dbuser=$MARIADB_USER \
		--dbpass=$MARIADB_PASSWORD \
		--dbhost=$MARIADB_HOST \
		--path="/var/www/html/wordpress/" \
		--allow-root \
		--skip-check

if ! wp core is-installed --allow-root; then
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
