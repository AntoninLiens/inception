# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/12 19:30:32 by aliens            #+#    #+#              #
#    Updated: 2022/09/21 14:00:42 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y php7.3 php7.3-fpm php7.3-mysql curl

WORKDIR /tmp/wordpress/

COPY ./utils/config.sh /tmp/wordpress/

# https://kinsta.com/fr/blog/wp-cli/
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html/wordpress

RUN wp core download --allow-root
RUN	chown -R www-data:www-data /var/www/html

ENTRYPOINT [ "bash", "/tmp/wordpress/config.sh" ]