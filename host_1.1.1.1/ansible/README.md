#host Address = 1.1.1.1  -  это главный сервер с которого будет происходить управление 
#всеми серверами физическими.

sudo apt update

sudo apt upgrade -y

===========================================================================================
#debian 12
sudo apt install -y ansible

ansible --version
ansible [core 2.14.18]
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.11.2 (main, Nov 30 2024, 21:22:50) [GCC 12.2.0] (/usr/bin/python3)
  jinja version = 3.1.2
  libyaml = True
===========================================================================================

===========================================================================================
#ubuntu 24.04.2 LTS
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible

sudo apt install -y ansible

ansible --version
ansible [core 2.18.6]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.12.3 (main, Feb  4 2025, 14:48:35) [GCC 13.3.0] (/usr/bin/python3)
  jinja version = 3.1.2
  libyaml = True
=======================================================================


sudo apt install sshpass

mkdir -p /etc/ansible/inventory

touch /etc/ansible/ansible.cfg

touch /etc/ansible/inventory/hosts
