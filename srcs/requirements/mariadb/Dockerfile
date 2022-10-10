# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/12 19:31:07 by aliens            #+#    #+#              #
#    Updated: 2022/10/10 10:06:48 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# FROM debian:buster

# RUN	apt-get update \
# 	&& apt-get upgrade -y
	
# RUN	apt-get install mariadb-server -y
	
# RUN	chown -R mysql:mysql /var/lib/mysql; \
# 	mkdir -p /var/run/mysqld; \
# 	chown -R mysql:mysql /var/run/mysqld; \
# 	touch /var/run/mysqld/mysqlf.pid \
# 	mkfifo /var/run/mysqld/mysqld.sock

# # COPY /tools/mariadb.cnf /etc/mysql/mariadb.conf.d/

# COPY ./tools/entrypoint.sh ./

# ENTRYPOINT [ "bash", "entrypoint.sh" ]



#Installing and updating Debian Buster
FROM debian:buster
RUN apt-get update
RUN apt-get upgrade -y

#MariaDB will be our database
RUN apt-get install mariadb-server -y

#Copy database creation and configutation
COPY ./tools/config.sql /tmp/config.sql

#Copy more configuration details given in the .cnf
COPY tools/mariadb.cnf /etc/mysql/

#Copy .sh script to execute everything
COPY ./tools/entrypoint.sh ./

# This execution of the  script is now the starting point
ENTRYPOINT [ "sh", "entrypoint.sh" ]
