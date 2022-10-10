FROM debian:buster

RUN	apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y curl php7.3 php7.3-fpm php7.3-mysql

RUN	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp \
	&& mkdir -p /var/www/html/wordpress

RUN wp core download --path="/var/www/html/wordpress/" --allow-root

COPY ./tools/entrypoint.sh ./

ENTRYPOINT [ "bash", "entrypoint.sh" ]
