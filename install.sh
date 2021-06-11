#!/bin/bash
# tested on Ubunutu 20.04: working 6/09/2021
# tested on CentOs 7: working 6/09/2021
# tested on CentOs 8: working 6/10/2021

# installs ansible and the docker scripts
# then brings up the full stack
# added in colored output for ease of following sctipts

#need to implement password I/O for the fabricadmin user
	#todo: https://www.elastic.co/blog/configuring-ssl-tls-and-https-to-secure-elasticsearch-kibana-beats-and-logstash

#added https://github.com/elastic/ansible-beats 

red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
reset=`tput sgr0`

#usr_name is for the user on the system themselves for the docker containers
usr_name=$1

#This is to login into the elk stack 
usr_name_elk=$2
passwd_elk=$3

#checking for Ubuntu
if [ -n "$(uname -a | grep Ubuntu)" ]; then

	echo "${blue}Found Ubuntu.${reset}"

	#https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
	  
	apt -y install software-properties-common

	wait

	add-apt-repository --yes --update ppa:ansible/ansible

	wait

	apt -y install ansible

	wait

	echo "${red}Ansible installed.${reset}"

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
   	
   	apt -y install docker-ce docker-ce-cli containerd.io 

   	apt -y install docker.io

   	echo "${red}Testing docker.${reset}"

   	docker run hello-world

	echo "${red}Pulling Elk-Docker scripts from github.${reset}"

	curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

	chmod +x /usr/local/bin/docker-compose

	wait

	git clone https://github.com/fabric-testbed/fabric-docker-images.git /usr/local/bin/fabric_base/

	wait

	sysctl -w vm.max_map_count=262144 

	apt-get -y install apache2-utils

	echo "${green}Checking docker-compose version / working.${reset}"

	/usr/local/bin/docker-compose --version

	/usr/local/bin/fabric_base/elk/setfolders.sh

	echo "${red}Set folders.${reset}"

	# echo "${red}Creating Prometheus directories and files.${reset}"

	# mkdir /usr/local/bin/etc

	# adding user to docker group to manage

	usermod -aG docker $usr_name

	#this is a poor implementation

	#still issues here with the correct settings

	htpasswd -b -c  /usr/local/bin/fabric_base/elk/nginx/etc/.htpasswd.user $usr_name_elk $passwd_elk

	wait

	#bringing up the elk stack fully

	echo "${red}Installing ansible-galaxy to build beats.${reset}"

	# this will bring in the most recent version

	# this is used to make the elk the ansible hub and can run scripts beyond this

	ansible-galaxy install elastic.beats

	ansible-galaxy init elastic.beats

	wait

	echo "${red}Installed all needed tools. Brining up elk.${reset}"

	/usr/local/bin/docker-compose -f /usr/local/bin/fabric_base/elk/docker-compose.yml --env-file /usr/local/bin/fabric_base/elk/.env up

	#fin
	

else

	#working

	#script designd for CentOs

	echo "${blue}Found CentOs.${reset}"

	yum -y install epel-release gcc openssl-devel bzip2-devel libffi-devel centos-release-scl

	wait

	echo "${red}Python installed.${reset}"

	yum -y install rh-python36

	yum -y groupinstall 'Development Tools'

	wait

	yum -y install ansible

	wait

	#issue
	#https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

	#only needed for ansible engine
	#subscription-manager repos --enable ansible-2.9-for-rhel-8-x86_64-rpms

	wait

	echo "${red}Ansible installed.${reset}"

	#testing the install correctly

	ansible --version

	wait

	echo "${red}Installing docker.${reset}"

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

	echo "${red}Installing git if not present.${reset}"

	yum -y install git

	wait

	echo "${red}Pulling Elk-Docker scripts from github.${reset}"

	curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

	chmod +x /usr/local/bin/docker-compose

	wait

	git clone https://github.com/fabric-testbed/fabric-docker-images.git /usr/local/bin/fabric_base/

	wait

	sysctl -w vm.max_map_count=262144 

	yum -y install -y httpd-tools

	echo "${green}Checking docker-compose version / working.${reset}"

	/usr/local/bin/docker-compose --version

	/usr/local/bin/fabric_base/elk/setfolders.sh

	echo "${red}Set folders.${reset}"

	usermod -aG docker $usr_name

	#setting up user and password from command line

	#still issues here with the correct settings

	htpasswd -b -c  /usr/local/bin/fabric_base/elk/nginx/etc/.htpasswd.user $usr_name_elk $passwd_elk

	wait

	echo "${red}Installing ansible-galaxy to build beats.${reset}"

	# this will bring in the most recent version

	ansible-galaxy install elastic.beats

	ansible-galaxy init elastic.beats

	wait

	echo "${red}Installed all needed tools. Brining up elk.${reset}"

	/usr/local/bin/docker-compose -f  /usr/local/bin/fabric_base/elk/docker-compose.yml --env-file /usr/local/bin/fabric_base/elk/.env up

	#fin

fi