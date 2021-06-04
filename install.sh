#!/bin/bash

#installs ansible and the docker scripts on a centos machine
#added in colored output for ease of following sctipts

red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
reset=`tput sgr0`

if [ -n "$(uname -a | grep Ubuntu)" ]; then

	echo "${blue}Found Ubuntu. ${reset}"
	  
	sudo apt -y install software-properties-common

	wait

	sudo add-apt-repository --yes --update ppa:ansible/ansible

	wait

	sudo apt -y install ansible

	wait

	sudo apt -y install python-argcomplete

	echo "ansible installed."

	#testing the install correctly

	ansible --version

	echo "${red}Installing git if not present. ${reset}"

	sudo apt-get install git

	wait

	echo "${red}Pulling Docker images from github ${reset}"

	sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

	wait

	git clone https://github.com/fabric-testbed/fabric-docker-images.git

	wait

	./set_folder.sh 

	sudo sysctl -w vm.max_map_count=262144 

	sudo apt-get install apache2-utils

	sudo chmod +x /usr/local/bin/docker-compose

	echp "${green}Checking docker-compose version ${reset}"

	docker-compose --version

	fabric-docker-images/elk/setfolders.sh

	echo "${red}Set folders. ${reset}"

	echo "${red}Switch to correct diretory /fabric-docker-images/elk/nginx/etc. And edit the config file to set the login for the server.${reset}"

	echo "${green}Command to run: htpasswd -c .htpasswd.user f [user_namehere]${reset}"

	echo "${green} Make sure to use the command sudo usermod -aG docker \$user_namehere to be able to assign the user to veiw the docker container.${reset}"

else

	echo "${blue}Found CentOs. ${reset}"

	sudo yum -y install epel-release

	wait

	sudo yum -y install ansible

	wait

	sudo subscription-manager repos --enable ansible-2.9-for-rhel-8-x86_64-rpms

	wait

	sudo yum -y install python3-argcomplete

	wait

	echo "${red}Ansible installed.${reset}"

	#testing the install correctly

	ansible --version

	wait

	echo "${red}Installing docker.${reset}"

	sudo yum -y remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

	wait 

	sudo yum -y install -y yum-utils

	wait

	sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

	wait

	sudo yum -y install docker-ce docker-ce-cli containerd.io

	wait

	sudo systemctl start docker

	wait

	echo "${red}Installing git if not present. ${reset}"

	sudo yum -y install git

	wait

	echo "${red}Pulling Docker images from github ${reset}"

	sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

	wait

	git clone https://github.com/fabric-testbed/fabric-docker-images.git

	wait

	./set_folder.sh 

	sudo sysctl -w vm.max_map_count=262144 

	sudo yum -y install -y httpd-tools

	sudo chmod +x /usr/local/bin/docker-compose

	echp "${green}Checking docker-compose version ${reset}"

	docker-compose --version

	fabric-docker-images/elk/setfolders.sh

	echo "${red}Set folders. ${reset}"

	echo "${red}Switch to correct diretory /fabric-docker-images/elk/nginx/etc. And edit the config file to set the login for the server.${reset}"

	echo "${green}Command to run: htpasswd -c .htpasswd.user f [user_namehere]${reset}"

	echo "${green} Make sure to use the command sudo usermod -aG docker \$user_namehere to be able to assign the user to veiw the docker container.${reset}"

fi


echo "${red} Installed all needed tools.${reset}"
