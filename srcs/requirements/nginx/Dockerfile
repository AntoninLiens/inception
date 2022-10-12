# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 14:13:46 by aliens            #+#    #+#              #
#    Updated: 2022/10/12 17:36:06 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN	apt-get update && \
	apt-get upgrade -y && \
	apt-get install nginx openssl -y

RUN openssl req -x509 -nodes \
	-keyout /etc/ssl/wordpress.key \
	-out /etc/ssl/wordpress.crt \
	-subj "/C=BE/ST=Belgium/L=Brussels/O=42/OU=19/CN=aliens.19.be/UID=aliens"

CMD	[ "nginx", "-g", "daemon off;" ]
