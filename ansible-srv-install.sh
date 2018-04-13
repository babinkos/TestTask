#!/bin/bash
DBIP=$1
if [ -z "$2" ]; then
 WEBIP=$1
else
 WEBIP=$2
fi

sudo chown vagrant /home/vagrant/.ssh/id_rsa
sudo chmod 400 /home/vagrant/.ssh/id_rsa
ssh-keyscan -H $DBIP >> /home/vagrant/.ssh/known_hosts

sudo sed -i 's%archive.ubuntu.com%mirror.yandex.ru%' /etc/apt/sources.list
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install software-properties-common -y
sudo apt-get install python-software-properties -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible -y
#ansible-galaxy -c -v install geerlingguy.mysql
echo "[all:vars]" | sudo tee /etc/ansible/hosts
echo "ansible_ssh_common_args='-o StrictHostKeyChecking=yes -o HostKeyAlgorithms=ssh-rsa'" | sudo tee --append /etc/ansible/hosts
echo "[db-servers]" | sudo tee --append /etc/ansible/hosts
echo "$DBIP ansible_user=vagrant" | sudo tee --append /etc/ansible/hosts
echo "[web-servers]" | sudo tee --append /etc/ansible/hosts
echo "$WEBIP ansible_user=vagrant" | sudo tee --append /etc/ansible/hosts
echo "AuthorizedKeysFile %h/.ssh/authorized_keys" | sudo tee --append /etc/ssh/sshd_config
mkdir TestTask
cd TestTask
git init
git remote add -f origin https://github.com/babinkos/TestTask.git
git config core.sparseCheckout true
echo "jboss-guestbook/*" >> .git/info/sparse-checkout
git pull origin dev
sudo chown -R vagrant:vagrant /home/vagrant/TestTask
#ssh -qv -o BatchMode=yes -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa -o ConnectTimeout=10 vagrant@$DBIP "ip addr;exit"
ansible-galaxy install -c -v -r /home/vagrant/TestTask/requirements.yml
ansible all -m ping -v
ansible-playbook /home/vagrant/TestTask/jboss-guestbook/site.yml
