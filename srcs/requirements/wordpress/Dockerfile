# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 12:14:30 by aliens            #+#    #+#              #
#    Updated: 2022/10/13 16:30:07 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y php7.3 php7.3-fpm php7.3-mysql curl && \
	mkdir -p /run/php

COPY ./tools/entrypoint.sh ./

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/wordpress

RUN wp core download --allow-root
RUN chown -R www-data:www-data /var/www

ENTRYPOINT ["sh", "/entrypoint.sh"]
