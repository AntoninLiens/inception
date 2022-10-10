# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/19 16:00:46 by aliens            #+#    #+#              #
#    Updated: 2022/10/10 10:23:07 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
	#Building all images
	docker-compose -f srcs/docker-compose.yml build
	#Creating folders for the external volumes (see docker-compose)
	mkdir -p /home/ldelmas/data
	mkdir -p /home/ldelmas/data/wordpress
	mkdir -p /home/ldelmas/data/database
	#Adding adresses refering to localhost
	chmod 777 /etc/hosts
	echo "127.0.0.1 ldelmas.42.fr" >> /etc/hosts
	echo "127.0.0.1 www.ldelmas.42.fr" >> /etc/hosts
	#Running every coontainers (will use detach to make them as background tasks)
	docker-compose -f srcs/docker-compose.yml up --detach

build:
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up --detach

down:
	docker-compose -f srcs/docker-compose.yml down

clean: 
	docker-compose -f srcs/docker-compose.yml down -v --rmi all

fclean: down clean
	docker system prune -af --volumes
	rm -rf /home/ldelmas/data
	docker network prune -f
	echo docker volume rm $(docker volume ls -q)
	docker image prune -f

re: fclean all

.PHONY: all build up down clean fclean re

# all:
# 	docker-compose -f ./srcs/docker-compose.yml build
# 	sudo mkdir -p /home/aliens/data/database
# 	sudo mkdir -p /home/aliens/data/wordpress
# 	sudo chmod 777 /etc/hosts
# 	sudo echo "127.0.0.1 aliens.19.be" >> /etc/hosts
# 	docker-compose -f ./srcs/docker-compose.yml up # --detach

# up:
# 	docker-compose -f ./srcs/docker-compose.yml up # --detach

# down:
# 	docker-compose -f ./srcs/docker-compose.yml down

# clean: down
# 	docker-compose -f ./srcs/docker-compose.yml -v --rmi all
# 	docker volume rm srcs_mariadb-volume
# 	docker volume rm srcs_wordpress-volume

# fclean: down clean
# 	sudo rm -rf /home/aliens/data
# 	docker image rm mariadb
# 	docker image rm wordpress
# 	docker image rm debian:buster

# re: fclean all

# .PHONY: all build up down clean fclean re
