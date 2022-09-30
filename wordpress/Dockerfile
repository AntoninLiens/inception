# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/28 14:08:45 by aliens            #+#    #+#              #
#    Updated: 2022/09/30 14:36:30 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN	apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y curl mariadb-client

RUN	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php \
	&& mkdir -p /var/www/wordpress \
	&& wp core download --path="/var/www/wordpress" --allow-root



