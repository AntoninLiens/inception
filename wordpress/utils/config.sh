grep -E "listen = 9000" "/etc/php/7.3/fpm/pool.d/www.conf" > /dev/null 2>&1

if [ $? -ne 0 ]; then
	 sed -i "s|.*listen = /run/php/php7.3-fpm.sock.*|listen = 9000|g" "/etc/php/7.3/fpm/pool.d/www.conf" 
fi

rm -rf /var/www/html/wordpress/wp-config.php
wp config create \
	--dbname=$MARIADB_DATABASE \
	--dbuser=$MARIADB_USER \
	--dbpass=$MARIADB_USER_PASSWORD \
	--dbhost=$MARIADB_HOST \
	--path="/var/www/html/wordpress/" \
	--allow-root \
	--skip-check

if ! wp core is-installed --allow-root; then
	wp core install \
		--url="$WORDPRESS_URL" \
		--title="$WORDPRESS_TITLE" \
		--admin_user="$WORDPRESS_ADMIN_USER" \
		--admin_password="$WORDPRESS_ADMIN_PWD" \
		--admin_email="$WORDPRESS_ADMIN_EMAIL" \
		--skip-email \
		--allow-root
fi

wp plugin update \
	--all \
	--allow-root

wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL \
	--role=editor \
	--user_pass=$WORDPRESS_USER_PWD \
	--allow-root

wp post generate \
	--count=1 \
	--post_title="Aliens Invasion" \
	--allow-root

php-fpm7.3 --nodaemonize