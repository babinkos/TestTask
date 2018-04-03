# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.7.0"
Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
	config.vm.define "ansiblesrv", primary: true do |ansiblesrv|
		ansiblesrv.vm.hostname = "ansible-server"
		ansiblesrv.vm.box = "ubuntu/xenial64"
		ansiblesrv.vm.network :private_network, ip: "192.168.56.101"
		ansiblesrv.vm.provision "shell", path: "ansible-srv-install.sh"
	end
	config.vm.define "jbossapp" do |jbossapp|
		jbossapp.vm.hostname = "jboss-app"
		jbossapp.vm.box = "ubuntu/xenial64"
		jbossapp.vm.network :private_network, ip: "192.168.56.102"
    # if in the future we'll want to refactor to provision at once this is the hint: 
		#jbossapp.vm.provision "ansible" do |ansible|
    #  ansible.verbose = "v"
    #  ansible.playbook = "jboss-guestbook/site.yml"
	end
  config.vm.provision "file", source: "#{Dir.home}/.vagrant.d/insecure_private_key", destination: "/home/vagrant/.ssh/id_rsa"
  config.vm.provision "shell" do |s|
  s.inline = <<-SHELL
    chown vagrant /home/vagrant/.ssh/id_rsa
    chmod 400 /home/vagrant/.ssh/id_rsa
  SHELL
  end

end
