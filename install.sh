#!/bin/bash

#installs ansible and the docker scripts
#added in colored output for ease of following sctipts

#need to implement password I/O for the fabricadmin user

red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
reset=`tput sgr0`

#This is to login into the elk stack 
usr_name_elk="fabricadmin"
passwd_elk=$2

#usr_name is for the user on the system themselves for the docker containers
usr_name=$1


#checking for Ubuntu
if [ -n "$(uname -a | grep Ubuntu)" ]; then

	echo "${blue}Found Ubuntu.${reset}"
	  
	apt -y install software-properties-common

	wait

	add-apt-repository --yes --update ppa:ansible/ansible

	wait

	apt -y install ansible

	wait

	apt-get -y install python-argcomplete

	echo "${red}ansible installed.${reset}"

	#testing the install correctly

	ansible --version

	wait

	echo "${red}Installing git if not present.${reset}"

	apt-get -y install git

	wait

	echo "${red}Installing docker if not present.${reset}"

	#installing over https for docker download

 	apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release

 	#adding key

 	#https://docs.docker.com/engine/install/ubuntu/

 	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

 	#setting repo

	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
   	
   	apt-get -y install docker-ce docker-ce-cli containerd.io docker.io

   	echo "${red}Testing docker.${reset}"

   	systemctl start docker

   	docker run hello-world

	echo "${red}Pulling Docker images from github.${reset}"

	curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

	chmod +x /usr/local/bin/docker-compose

	wait

	git clone https://github.com/fabric-testbed/fabric-docker-images.git /usr/local/bin/

	wait

	sysctl -w vm.max_map_count=262144 

	apt-get -y install apache2-utils

	chmod +x /usr/local/bin/docker-compose

	echo "${green}Checking docker-compose version ${reset}"

	docker-compose --version

	fabric-docker-images/elk/setfolders.sh

	echo "${red}Set folders.${reset}"

	#adding user to docker group to manage

	usermod -aG docker $usr_name

	#this is a poor implementation

	htpasswd -bcm  /usr/local/bin/fabric-docker-images/elk/nginx/etc/.htpasswd.user $usr_name_elk $passwd_elk

	wait

	#bringing up the elk stack fully

	echo "${red}Installed all needed tools. Brining up elk.${reset}"

	docker-compose -f  /usr/local/bin/fabric-docker-images/elk/docker-compose.yml --env-file /usr/local/bin/fabric-docker-images/elk/.env up

	#fin
	

else

	#script designd for CentOs or Ubuntu

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

	echo "${red}Testing docker.${reset}"

   	systemctl start docker

   	docker run hello-world

	wait

	echo "${red}Installing git if not present. ${reset}"

	yum -y install git

	wait

	echo "${red}Pulling Docker images from github ${reset}"

	curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

	chmod +x /usr/local/bin/docker-compose

	wait

	git clone https://github.com/fabric-testbed/fabric-docker-images.git /usr/local/bin/

	wait

	sysctl -w vm.max_map_count=262144 

	yum -y install -y httpd-tools

	chmod +x /usr/local/bin/docker-compose

	echo "${green}Checking docker-compose version.${reset}"

	docker-compose --version

	fabric-docker-images/elk/setfolders.sh

	echo "${red}Set folders.${reset}"

	usermod -aG docker $usr_name

	#setting up user and password from command line

	htpasswd -bcm  /usr/local/bin/fabric-docker-images/elk/nginx/etc/.htpasswd.user $usr_name_elk $passwd_elk

	wait

	echo "${red}Installed all needed tools. Brining up elk.${reset}"

	docker-compose -f  /usr/local/bin/fabric-docker-images/elk/docker-compose.yml --env-file /usr/local/bin/fabric-docker-images/elk/.env up

	#fin

fi

