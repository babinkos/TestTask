# -*- mode: ruby -*-
# vi: set ft=ruby :

# old box name was "ubuntu/xenial64" and new bento/ubuntu-16.04 but very slow from vagrantcloud, reverted
#boxname = "ubuntu/xenial64"
# pybox is a tuned ubuntu/xenial64 local vbox - see git@github.com:babinkos/vagrant-pybox.git
boxname = "pybox"
Vagrant.require_version ">= 2.0.0"

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  config.vm.define "jbossapp" do |jbossapp|
    jbossapp.vm.hostname = "jboss-app"
    jbossapp.vm.box = boxname
    jbossapp.vm.network :private_network, ip: "192.168.56.102"
    jbossapp.vm.network "forwarded_port", guest: 8080, host: 8080, autocorrect: true
    jbossapp.vm.network "forwarded_port", guest: 8443, host: 8443, autocorrect: true
    jbossapp.vm.network "forwarded_port", guest: 9990, host: 9990, autocorrect: true
    jbossapp.vm.provision "file", source: "#{Dir.home}/.vagrant.d/insecure_private_key", destination: "/home/vagrant/.ssh/id_rsa"
    jbossapp.vm.provision "shell", path: "jboss-app-install.sh", privileged: false
    # remove line below after tests finished
    jbossapp.vm.provision "file", source: "jboss-modules-1.1.5.GA.jar", destination: "/tmp/jboss-modules-1.1.5.GA.jar"
    # if in the future we'll want to refactor to provision at once this is the hint: 
    #jbossapp.vm.provision "ansible" do |ansible|
    #  ansible.verbose = "v"
    #  ansible.playbook = "jboss-guestbook/site.yml"
  end

  config.vm.define "ansiblesrv", primary: true do |ansiblesrv|
		ansiblesrv.vm.hostname = "ansible-server"
		ansiblesrv.vm.box = boxname
		ansiblesrv.vm.network :private_network, ip: "192.168.56.101"
    ansiblesrv.vm.provision "file", source: "#{Dir.home}/.vagrant.d/insecure_private_key", destination: "/home/vagrant/.ssh/id_rsa"
    
    # remove this line below after testing and uncomment /roles/jboss/main.yml unarchieve module original source
    ansiblesrv.vm.provision "file", source: "jboss-as-7.1.1.Final.zip", destination: "/tmp/jboss-as-7.1.1.Final.zip"
    ansiblesrv.vm.provision "file", source: "wildfly-12.0.0.Final.zip", destination: "/tmp/wildfly-12.0.0.Final.zip"
    ansiblesrv.vm.provision "file", source: "guestbookapp.zip", destination: "/tmp/guestbookapp.zip"
    
    ansiblesrv.vm.provision "shell", path: "ansible-srv-install.sh", privileged: false
  end  
end