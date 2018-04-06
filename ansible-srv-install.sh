#!/bin/bash
DBIP="192.168.56.102"
WEBIP=$DBIP
chown vagrant /home/vagrant/.ssh/id_rsa
chmod 400 /home/vagrant/.ssh/id_rsa
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
echo "$DBIP ansible_user=vagrant" | sudo tee --append /etc/ansible/hosts
echo "[web-servers]" | sudo tee --append /etc/ansible/hosts
echo "$WEBIP ansible_user=vagrant" | sudo tee --append /etc/ansible/hosts

mkdir TestTask
cd TestTask
git init
git remote add -f origin https://github.com/babinkos/TestTask.git
git config core.sparseCheckout true
echo "jboss-guestbook/*" >> .git/info/sparse-checkout
git pull origin dev
sudo chown -R vagrant:vagrant /home/vagrant/TestTask 
ansible-playbook /home/vagrant/TestTask/jboss-guestbook/site.yml
