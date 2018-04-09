#!/bin/bash
sudo chown vagrant /home/vagrant/.ssh/id_rsa
sudo chmod 400 /home/vagrant/.ssh/id_rsa
#ssh-keygen -y -e -f /home/vagrant/.ssh/id_rsa >> /home/vagrant/.ssh/authorized_keys
ssh-keyscan -H 192.168.56.101 >> /home/vagrant/.ssh/known_hosts
sudo sed -i 's%archive.ubuntu.com%mirror.yandex.ru%' /etc/apt/sources.list
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get -y install python-minimal
echo "AuthorizedKeysFile %h/.ssh/authorized_keys" | sudo tee --append /etc/ssh/sshd_config
#sudo apt-get -y install python-simplejson