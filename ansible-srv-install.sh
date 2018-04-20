#!/bin/bash
DBIP=$1
if [ -z "$2" ]; then
 WEBIP=$1
else
 WEBIP=$2
fi

echo "temporary stop scheduled apt daily jobs to avoid conflicts on locks"
#pgrep -f 'apt|adept|dpkg'
pgrep -a apt-get
sudo lsof /var/lib/dpkg/lock
sudo systemctl stop apt-daily.timer
pgrep -a apt-get
#pgrep -f 'apt|adept|dpkg'
sudo lsof /var/lib/dpkg/lock

sudo chown vagrant /home/vagrant/.ssh/id_rsa
sudo chmod 400 /home/vagrant/.ssh/id_rsa
echo "ssh-keyscan -H $DBIP >> /home/vagrant/.ssh/known_hosts"
ssh-keyscan -H $DBIP >> /home/vagrant/.ssh/known_hosts
echo "/etc/apt/sources.list updated to use mirror.yandex.ru"
sudo sed -i 's%us.archive.ubuntu.com%mirror.yandex.ru%' /etc/apt/sources.list
sudo sed -i 's%archive.ubuntu.com%mirror.yandex.ru%' /etc/apt/sources.list
echo "update package list"
#pgrep -f 'apt|adept|dpkg'
sudo lsof /var/lib/dpkg/lock
pgrep -a apt-get
sudo apt-get update
sudo lsof /var/lib/dpkg/lock
echo "upgrade packages"
sudo apt-get upgrade -y
sudo lsof /var/lib/dpkg/lock
echo "upgrade core system packages (dist-upgrade)"
sudo apt-get dist-upgrade -y
sudo lsof /var/lib/dpkg/lock
echo "installing tools to configure ppa"
sudo apt-get install software-properties-common -y
sudo apt-get install python-software-properties -y
echo "adding ppa:ansible to sources"
sudo apt-add-repository ppa:ansible/ansible -y
echo "refreshing packages list to get new ones from added ppa"
sudo apt-get update
echo "installing fresh ansible from ppa"
sudo apt-get install ansible -y
echo "restoring scheduled apt daily jobs after upgrading"
sudo systemctl start apt-daily.timer

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
# eralier was installed: ansible-galaxy -c -v install geerlingguy.mysql
ansible-galaxy install -c -v -r /home/vagrant/TestTask/jboss-guestbook/requirements.yml
ansible all -m ping -v
ansible-playbook /home/vagrant/TestTask/jboss-guestbook/site.yml -v 2>&1 | tee playlog.txt
