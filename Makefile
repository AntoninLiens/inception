# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/19 16:00:46 by aliens            #+#    #+#              #
#    Updated: 2022/10/14 13:17:36 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
	docker-compose -f ./srcs/docker-compose.yml build
	sudo mkdir -p /home/aliens/data/database
	sudo mkdir -p /home/aliens/data/wordpress
	sudo echo "127.0.0.1 aliens.42.fr" >> /etc/hosts
	docker-compose -f ./srcs/docker-compose.yml up --detach

up:
	docker-compose -f ./srcs/docker-compose.yml up --detach

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean: down
	docker-compose -f ./srcs/docker-compose.yml -v --rmi all
	docker volume rm srcs_mariadb-volume
	docker volume rm srcs_wordpress-volume

fclean: down clean
	sudo rm -rf /home/aliens/data
	docker image rm nginx
	docker image rm mariadb
	docker image rm wordpress
	docker image rm debian:buster

re: fclean all

.PHONY: all build up down clean fclean re
