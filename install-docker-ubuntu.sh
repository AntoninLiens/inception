# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install-docker-ubuntu.sh                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aliens <aliens@student.s19.be>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/26 16:13:55 by aliens            #+#    #+#              #
#    Updated: 2022/09/26 16:37:42 by aliens           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install  curl apt-transport-https ca-certificates software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update

sudo apt-get install docker-ce docker-compose -y
sudo systemctl status docker
