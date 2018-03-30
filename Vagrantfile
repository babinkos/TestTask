# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
	config.vm.define "ansiblesrv", primary: true do |ansiblesrv|
		ansiblesrv.vm.hostname = "ansible-server"
		ansiblesrv.vm.box = "hashicorp/precise64"
		ansiblesrv.vm.network :private_network, ip: "192.168.56.101"
		ansiblesrv.vm.provision "shell", inline: <<-SHELL
			apt-get update
			apt-get install -y ansible
			
  		SHELL
	end
	config.vm.define "jbossapp" do |jbossapp|
		jbossapp.vm.hostname = "jboss-app"
		jbossapp.vm.box = "hashicorp/precise64"
		jbossapp.vm.network :private_network, ip: "192.168.56.102"
	end
end
