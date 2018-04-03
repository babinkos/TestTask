#!/bin/bash
sudo sed -i 's%archive.ubuntu.com%mirror.yandex.ru%' /etc/apt/sources.list
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install software-properties-common -y
sudo apt-get install python-software-properties -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible -y
ansible-galaxy install geerlingguy.mysql
echo "[db-servers]" | sudo tee /etc/ansible/hosts
echo "192.168.56.102" | sudo tee --append /etc/ansible/hosts
echo "[web-servers]" | sudo tee --append /etc/ansible/hosts
echo "192.168.56.102" | sudo tee --append /etc/ansible/hosts
