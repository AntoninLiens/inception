# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/10 14:13:46 by aliens            #+#    #+#              #
#    Updated: 2022/10/12 11:01:59 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debien:buster

RUN	apt-get update && \
	apt-get upgrade -y && \
	apt-get install nginx openssl -y

RUN openssl req -new -newkey rsa:2048 -nodes -keyout server.key -out server.crt
