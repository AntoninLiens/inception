# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/12 19:31:07 by aliens            #+#    #+#              #
#    Updated: 2022/10/07 15:46:34 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN	apt-get update \
	&& apt-get upgrade -y
	
RUN	apt-get install mariadb-server -y

COPY ./tools/entrypoint.sh ./

COPY /tools/mariadb.cnf /etc/mysql/

ENTRYPOINT [ "bash", "entrypoint.sh" ]
