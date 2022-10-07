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
COPY ./tools/config.sh ./

# This execution of the  script is now the starting point
ENTRYPOINT [ "sh", "config.sh" ]
