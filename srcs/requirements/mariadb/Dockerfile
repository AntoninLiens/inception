FROM debian:buster

RUN	apt-get update \
	&& apt-get upgrade -y && \
	apt-get install mariadb-server -y
	
# RUN	chown -R mysql:mysql /var/lib/mysql; \
# 	mkdir -p /var/run/mysqld; \
# 	chown -R mysql:mysql /var/run/mysqld; \
# 	touch /var/run/mysqld/mysqlf.pid \
# 	mkfifo /var/run/mysqld/mysqld.sock

COPY ./tools/config.sql /tmp/config.sql

COPY ./tools/mariadb.cnf /etc/mysql/mariadb.cnf

COPY ./tools/entrypoint.sh ./

ENTRYPOINT [ "bash", "entrypoint.sh" ]
