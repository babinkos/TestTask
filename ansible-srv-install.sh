#!/bin/bash
sudo sed -i 's%us.archive.ubuntu.com%mirror.yandex.ru%' /etc/apt/sources.list
# workaround with interactive dialog on grub update from : https://devops.stackexchange.com/questions/1139/how-to-avoid-interactive-dialogs-when-running-apt-get-upgrade-y-in-ubuntu-16/1143
sudo ucf --purge /boot/grub/menu.lst
sudo apt-get update
sudo UCF_FORCE_CONFFNEW=YES apt-get upgrade -y
sudo apt-get install software-properties-common
sudo apt-get install python-software-properties -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible -y
sudo ansible-galaxy install geerlingguy.mysql
sudo echo "[db-servers]" > /etc/ansible/hosts
sudo echo "192.168.56.102" >> /etc/ansible/hosts
sudo echo "[web-servers]" >> /etc/ansible/hosts
sudo echo "192.168.56.102" >> /etc/ansible/hosts
