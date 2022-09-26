# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/19 16:00:46 by aliens            #+#    #+#              #
#    Updated: 2022/09/26 16:36:37 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
	docker-compose -f docker-compose.yml build
	mkdir -p /home/aliens/data
	mkdir -p /home/aliens/data/wordpress
	mkdir -p /home/aliens/data/database
	chmod 777 /etc/hosts
	if [ $(grep -E "127.0.0.1 aliens.42.fr" "127.0.0.1 www.aliens.42.fr") -ne 0 ]; then
		echo "127.0.0.1 aliens.42.fr" >> /etc/hosts
		echo "127.0.0.1 www.aliens.42.fr" >> /etc/hosts
	fi
	docker-compose -f docker-compose.yml up # --detach

build:
	docker-compose -f docker-compose.yml build

up:
	docker-compose -f docker-compose.yml up # --detach

down:
	docker-compose -f docker-compose.yml down

clean: 
	docker-compose -f docker-compose.yml down -v --rmi all

fclean: down clean
	docker system prune -af --volumes
	rm -rf /home/aliens/data
	docker network prune -f
	echo docker volume rm $(docker volume ls -q)
	docker image prune -f

re: fclean all

.PHONY: all build up down clean fclean re