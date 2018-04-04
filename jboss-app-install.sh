#!/bin/bash
sudo sed -i 's%archive.ubuntu.com%mirror.yandex.ru%' /etc/apt/sources.list
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get -y install python-minimal
#sudo apt-get -y install python-simplejson