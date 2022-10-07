# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/19 16:00:46 by aliens            #+#    #+#              #
#    Updated: 2022/10/07 12:27:09 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
	docker-compose -f ./srcs/docker-compose.yml build
	sudo mkdir -p /home/aliens/data/database
	sudo mkdir -p /home/aliens/data/wordpress
	sudo chmod 777 /etc/hosts
	sudo echo "127.0.0.1 aliens.19.be" >> /etc/hosts
	docker-compose -f ./srcs/docker-compose.yml up # --detach

up:
	docker-compose -f ./srcs/docker-compose.yml up # --detach

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean: down
	docker-compose -f ./srcs/docker-compose.yml -v --rmi all
	docker volume rm inception_mariadb-volume
	docker volume rm inception_wordpress-volume

fclean: down clean
	sudo rm -rf /home/aliens/data
	docker image rm mariadb
	docker image rm wordpress
	docker image rm debian:buster

re: fclean all

.PHONY: all build up down clean fclean re
