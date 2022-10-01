# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/19 16:00:46 by aliens            #+#    #+#              #
#    Updated: 2022/10/01 16:26:04 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
	docker-compose -f docker-compose.yml build
	mkdir -p /home/aliens/data
	mkdir -p /home/aliens/data/wordpress
	mkdir -p /home/aliens/data/database
	chmod 777 /etc/hosts
	echo "127.0.0.1 aliens.19.be" >> /etc/hosts
	docker-compose -f docker-compose.yml up # --detach

up:
	docker-compose -f docker-compose.yml up # --detach

down:
	docker-compose -f docker-compose.yml down

clean: down
	docker-compose -f docker-compose.yml -v --rmi all
	docker volume rm $(docker volume ls -q)

fclean: down clean
	docker system prune -af --volumes
	rm -rf /home/aliens/data
	docker network prune -f
	docker image prune -f

re: fclean all

.PHONY: all build up down clean fclean re
