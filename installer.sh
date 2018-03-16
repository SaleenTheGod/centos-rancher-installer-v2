#! /bin/bash

sudo yum remove docker docker-common docker-selinux docker-engine
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

clear

yum list docker-ce --showduplicates | sort -r

echo "please copy and paste the FULL NAME of the docker version you'd like to install. ex: 17.09.1.ce-1.el7.centos"

read dkr_v

sudo yum install docker-ce-$dkr_v -y
#sudo yum install docker-ce-17.12.1.ce-1.el7.centos -y

sudo systemctl start docker && sudo systemctl enable docker

sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:stable

echo " "
echo "Rancher now live at: http://$(ifconfig ens192 | grep 'inet' |  cut -d: -f2 | awk '{ print $2}'):8080"





