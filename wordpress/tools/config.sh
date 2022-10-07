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
		--dbpass=$MARIADB_USER_PASSWORD \
		--dbhost=$MARIADB_HOST \
		--path="/var/www/html/wordpress/" \
		--allow-root \
		--skip-check

# Wordpress installing
if ! wp core is-installed --allow-root; then
	echo "--Installing Wordpress"
	wp core install --url="$WORDPRESS_URL" \
					--title="$WORDPRESS_TITLE" \
					--admin_user="$WORDPRESS_USER" \
					--admin_password="$WORDPRESS_USER_PASSWORD" \
					--skip-email \
					--allow-root

fi

# Simple update for wordpress 
echo "--Updating wordpress"
wp plugin update --all --allow-root

# Create user (check how simon does it)
echo "--Creating example user"
wp user create $WORDPRESS_USER --role=editor \
													--user_pass=$WORDPRESS_USER_PASSWORD \
													--allow-root
# Create article example 
echo "--Creating example article"
wp post generate --count=1 --post_title="example-post" --allow-root

# We need this FastCGI Process Manager to run wordpress but also so that the container keeps running
# --nodaemonize == keep foreground
echo "--Starting "
php-fpm7.3 --nodaemonize
