apt install python3-pip -y
pip3 install -U pip
add-apt-repository --yes --update ppa:ansible/ansible:2.10
apt update
apt install ansible -y

mkdir -p /etc/kolla
 
sed '/\[defaults\]/a host_key_checking=False' -i/etc/ansible/ansible.cfg
sed '/\[defaults\]/a pipelining=True' -i/etc/ansible/ansible.cfg
sed '/\[defaults\]/a forks=100' -i/etc/ansible/ansible.cfg

kolla-ansible -i ./multinode bootstrap-servers
kolla-ansible -i ./multinode pull
kolla-ansible -i ./multinode prechecks
kolla-ansible -i ./multinode deploy

add-apt-repository cloud-archive:xena
apt install python3-openstackclient python3-heatclient python3-swift -y
kolla-ansible post-deploy . /etc/kolla/admin-openrc.sh