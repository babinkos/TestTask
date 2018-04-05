# -*- mode: ruby -*-
# vi: set ft=ruby :

# old box name was "ubuntu/xenial64"
boxname = "bento/ubuntu-16.04"
Vagrant.require_version ">= 2.0.0"
Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  id_rsa_pub = File.read("#{Dir.home}/.ssh/id_rsa.pub")

  config.vm.define "jbossapp" do |jbossapp|
    jbossapp.vm.hostname = "jboss-app"
    jbossapp.vm.box = boxname
    jbossapp.vm.network :private_network, ip: "192.168.56.102"
    jbossapp.vm.provision "file", source: "#{Dir.home}/.vagrant.d/insecure_private_key", destination: "/home/vagrant/.ssh/id_rsa"
    jbossapp.vm.provision "copy ssh public key", type: "shell",
        inline: "echo \"#{id_rsa_pub}\" >> /home/vagrant/.ssh/authorized_keys"
    jbossapp.vm.provision "shell" do |s|
      s.inline = <<-SHELL
      chown vagrant /home/vagrant/.ssh/id_rsa
      chmod 400 /home/vagrant/.ssh/id_rsa
      SHELL
    end
    jbossapp.vm.provision "shell", path: "jboss-app-install.sh"
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
    # remove this line below after testing and uncomment /roles/jboss/main.yml unzip module original source
    #ansiblesrv.vm.provision "file", source: "jboss-as-7.1.1.Final.zip", destination: "/tmp/jboss-as-7.1.1.Final.zip"
    #ansiblesrv.vm.provision "file", source: "jboss-modules-1.1.5.GA.jar", destination: "/tmp/jboss-modules-1.1.5.GA.jar"
    ansiblesrv.vm.provision "copy ssh public key", type: "shell",
        inline: "echo \"#{id_rsa_pub}\" >> /home/vagrant/.ssh/authorized_keys"

    ansiblesrv.vm.provision "shell" do |s|
      s.inline = <<-SHELL
      chown vagrant /home/vagrant/.ssh/id_rsa
      chmod 400 /home/vagrant/.ssh/id_rsa
      SHELL
    end
    ansiblesrv.vm.provision "shell", path: "ansible-srv-install.sh"
  end  
end