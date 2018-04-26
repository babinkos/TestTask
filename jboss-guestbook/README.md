This playbook is tested on Ubuntu 16.04 and ansible v2.5, VM provisioning made with vagrant (2.0.2)  tested with VirtualBox 2.5 and kvm/quemu (libvirt provider in vagrant) on Ubuntu 16.04 host,
see more details in project repo: https://github.com/babinkos/TestTask

prerequisites: geerlingguy.mysql from ansible-galaxy, installed on VM by provisioning script

what playbook do:
- installs WildFly 12 from jboss.org, adds management user, configures mgmt interface binding to private network,
- installs MySQL and restores database from dump, creates user with permissions for that DB,
- downloads guestbook sample java app, changes xml config (removed balancer section), deploys app to wildfly 
- downloads simple node-info java app, deploys app to wildfly