# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/12 19:31:07 by aliens            #+#    #+#              #
#    Updated: 2022/09/21 15:20:07 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

# https://mariadb.org/documentation/
RUN	apt-get update \
	&& apt-get upgrade -y

RUN	apt-get install mariadb-server -y

COPY ./utils/config.sql /tmp/config.sql

COPY ./utils/mariadb.cnf /etc/mysql

COPY ./utils/config.sh ./

ENTRYPOINT [ "sh", "config.sh" ]
