#!/bin/bash
sudo sed -i 's%archive.ubuntu.com%mirror.yandex.ru%' /etc/apt/sources.list
sudo apt update
sudo apt upgrade -y
sudo apt -y install python-minimal
#sudo apt-get -y install python-simplejson