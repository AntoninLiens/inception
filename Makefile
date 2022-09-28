# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/19 16:00:46 by aliens            #+#    #+#              #
#    Updated: 2022/09/28 02:16:34 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

VOLUMES_DOCKER=	$(docker ls -q)

all:
	docker-compose -f docker-compose.yml build
	mkdir -p /home/aliens/data
	mkdir -p /home/aliens/data/wordpress
	mkdir -p /home/aliens/data/database
	chmod 777 /etc/hosts
	echo "127.0.0.1 aliens.42.fr" >> /etc/hosts
	echo "127.0.0.1 www.aliens.42.fr" >> /etc/hosts
	docker-compose -f docker-compose.yml up # --detach

up:
	docker-compose -f docker-compose.yml up # --detach

down:
	docker-compose -f docker-compose.yml down

clean: down
	docker-compose -f docker-compose.yml -v --rmi all

fclean: down clean
	docker system prune -af --volumes
	rm -rf /home/aliens/data
	docker network prune -f
	docker image prune -f

re: fclean all

.PHONY: all build up down clean fclean re