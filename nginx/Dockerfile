# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/12 17:00:54 by aliens            #+#    #+#              #
#    Updated: 2022/09/21 00:06:04 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN	apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install nginx -y \
	&& apt-get install openssl -y

COPY ./utils/nginx.conf /etc/nginx/sites-enabled/default.conf

RUN	mkdir -p /etc/nginx/ssl

# https://www.openssl.org/docs/manpages.html
RUN	openssl req -x509 -nodes \
	-out /etc/nginx/ssl/nginx-selfsigned.crt \
	-keyout /etc/nginx/ssl/nginx-selfsigned.key \
	-subj "/C=BE/ST=Belgium/L=Brussels/O=42/OU=19/CN=aliens.42.fr/UID=aliens"

CMD nginx -g "daemon off;"
