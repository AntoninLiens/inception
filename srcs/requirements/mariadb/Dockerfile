# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 11:55:25 by aliens            #+#    #+#              #
#    Updated: 2022/10/12 11:36:29 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install mariadb-server -y

RUN chown -R mysql:mysql /var/lib/mysql; \
	mkdir -p /var/run/mysqld; \
	mkfifo /var/run/mysqld/mysqld.sock; \
	chown -R mysql:mysql /var/run/mysqld

COPY tools/mariadb.cnf /etc/mysql/
COPY ./tools/config.sql ./
COPY ./tools/entrypoint.sh ./

ENTRYPOINT [ "bash", "entrypoint.sh" ]
