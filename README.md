# TestTask

1. Install Vagrant (https://www.vagrantup.com/downloads.html) and virtualization solution that fit your OS (Virtualbox in most cases, see another options below)
2. Download Vagrantfile from this repository ( https://raw.githubusercontent.com/babinkos/TestTask/dev/Vagrantfile )
3. Place downloaded file in some directory
4. Run the command "vagrant up" from that directory
5. Links to check installed apps:
- http://localhost:8080/node-info/
- http://localhost:8080/guestbookapp/

6. For management purposes you can use:
- http://localhost:9990/console

all variables are store in jboss-guestbook/group_vars/all/params.json

*For advanced users:
You can also use Hyper-V on Windows or KVM/QUEMU on Linux - but you need then change vagrant box name (set boxname variable in Vagrantfile to image that support virtualization plugin of you choice) to debian-based linux box for your virtualization provider and install neccessary virtualization plugin for vagrant*