# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/12 19:31:07 by aliens            #+#    #+#              #
#    Updated: 2022/10/06 14:29:33 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN	apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install mariadb-server -y
	
RUN	chown -R mysql:mysql /var/lib/mysql; \
	mkdir -p /var/run/mysqld; \
	chown -R mysql:mysql /var/run/mysqld; \
	mkfifo /var/run/mysqld/mysqld.sock
	
COPY ./utils/entrypoint.sh ./

ENTRYPOINT [ "bash", "entrypoint.sh" ]
