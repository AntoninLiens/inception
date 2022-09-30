# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/28 14:08:45 by aliens            #+#    #+#              #
#    Updated: 2022/09/30 13:50:28 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN	apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y curl mariadb-client

RUN	mkdir -p /var/www/wordpress; \
	curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /user/bin/local/wp \
	&& chmod +x /usr/local/bin/wp

WORKDIR /var/www/wordpress

RUN wp core download --allow-root



