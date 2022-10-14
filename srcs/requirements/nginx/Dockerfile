# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 14:13:46 by aliens            #+#    #+#              #
#    Updated: 2022/10/14 10:12:43 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN	apt-get update && \
	apt-get upgrade -y && \
	apt-get install nginx openssl -y

COPY ./tools/nginx.conf /etc/nginx/sites-enabled/default.conf

RUN openssl req -x509 -nodes \
	-keyout /etc/ssl/aliens.42.fr.key \
	-out /etc/ssl/aliens.42.fr.crt \
	-subj "/C=BE/ST=Belgium/L=Brussels/O=42/OU=19/CN=aliens.42.fr/UID=aliens"

CMD	[ "nginx", "-g", "daemon off;" ]
