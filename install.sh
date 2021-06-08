#!/bin/bash

#installs ansible and the docker scripts
#added in colored output for ease of following sctipts

#need to implement password I/O for the fabricadmin user

red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
reset=`tput sgr0`
usr_name_elk="fabricadmin"
usr_name=$1


if [ -n "$(uname -a | grep Ubuntu)" ]; then

	echo "${blue}Found Ubuntu. ${reset}"
	  
	apt -y install software-properties-common

	wait

	add-apt-repository --yes --update ppa:ansible/ansible

	wait

	apt -y install ansible

	wait

	apt -y install python-argcomplete

	echo "ansible installed."

	#testing the install correctly

	ansible --version

	systemctl start docker

	wait

	echo "${red}Installing git if not present. ${reset}"

	apt-get -y install git

	wait

	echo "${red}Pulling Docker images from github ${reset}"

	curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

	wait

	git clone https://github.com/fabric-testbed/fabric-docker-images.git

	wait

	sysctl -w vm.max_map_count=262144 

	apt-get install apache2-utils

	chmod +x /usr/local/bin/docker-compose

	echo "${green}Checking docker-compose version ${reset}"

	docker-compose --version

	fabric-docker-images/elk/setfolders.sh

	echo "${red}Set folders. ${reset}"

	usermod -aG docker $usr_name

	#this is a poor implementation

	htpasswd -bcm  ~/fabric-docker-images/elk/nginx/etc .htpasswd.user $usr_name_elk 2deHMj4dXvTf

	docker-compose -f  ~/fabric-docker-images/elk/docker-compose.yml --env-file ~/fabric-docker-images/elk/.env up
	

else

	echo "${blue}Found CentOs.${reset}"

	yum -y install epel-release

	wait

	yum -y install ansible

	wait

	subscription-manager repos --enable ansible-2.9-for-rhel-8-x86_64-rpms

	wait

	yum -y install python3-argcomplete

	wait

	echo "${red}Ansible installed.${reset}"

	#testing the install correctly

	ansible --version

	wait

	echo "${red}Installing docker.${reset}"

	yum -y remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

	wait 

	yum -y install -y yum-utils

	wait

	yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

	wait

	yum -y install docker-ce docker-ce-cli containerd.io

	wait

	systemctl start docker

	wait

	echo "${red}Installing git if not present. ${reset}"

	yum -y install git

	wait

	echo "${red}Pulling Docker images from github ${reset}"

	curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

	wait

	git clone https://github.com/fabric-testbed/fabric-docker-images.git

	wait

	sysctl -w vm.max_map_count=262144 

	yum -y install -y httpd-tools

	chmod +x /usr/local/bin/docker-compose

	echo "${green}Checking docker-compose version ${reset}"

	docker-compose --version

	fabric-docker-images/elk/setfolders.sh

	echo "${red}Set folders. ${reset}"

	usermod -aG docker $usr_name

	#this is a poor implementation

	htpasswd -bcm  ~/fabric-docker-images/elk/nginx/etc .htpasswd.user $usr_name_elk 2deHMj4dXvTf

	#echo "${red}Switch to correct diretory /fabric-docker-images/elk/nginx/etc. And edit the config file to set the login for the server.${reset}"

	docker-compose -f  ~/fabric-docker-images/elk/docker-compose.yml --env-file ~/fabric-docker-images/elk/.env up

	#echo "${green}Command to run: htpasswd -c .htpasswd.user [user_namehere]${reset}"

fi


echo "${red}Installed all needed tools.${reset}"

echo "${red}Make sure if stablity issues occur in GENI use: sudo bash /usr/testbed/bin/mkextrafs /mnt exit.${reset}"  
