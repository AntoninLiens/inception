# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/19 16:00:46 by aliens            #+#    #+#              #
#    Updated: 2022/10/05 11:54:00 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
	docker-compose -f docker-compose.yml build
	mkdir -p /home/aliens/data/database
	mkdir -p /home/aliens/data/wordpress
	chmod 777 /etc/hosts
	echo "127.0.0.1 aliens.19.be" >> /etc/hosts
	docker-compose -f docker-compose.yml up # --detach

up:
	docker-compose -f docker-compose.yml up # --detach

down:
	docker-compose -f docker-compose.yml down

clean: down
	# docker-compose -f docker-compose.yml -v --rmi all
	docker volume rm inception_mariadb-volume
	docker volume rm inception_wordpress-volume

fclean: down clean
	rm -rf /home/aliens/data

re: fclean all

.PHONY: all build up down clean fclean re
