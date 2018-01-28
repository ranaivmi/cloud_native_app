#!/bin/bash

# sudo apt install python
# sudo apt install pip
# sudo pip install python-openstackclient
echo "[*] Step 0 : Prerequisites"
sudo systemctl disable firewalld
sudo systemctl stop firewalld
sudo systemctl disable NetworkManager
sudo systemctl stop NetworkManager
sudo systemctl enable network
sudo systemctl start network
echo "[+] Step 0 : done"

echo "[*] Step 1 : Software repositories"
sudo yum install -y centos-release-openstack-pike
sudo yum update -y
echo "[+] Step 1 : done"

echo "[*] Step 2 : Install Packstack Installer"
sudo yum install -y openstack-packstack
echo "[+] Step 2 : done"

echo "[*] Generate answer-file"
sudo packstack --gen-answer-file=ensimag-packstack.txt
echo "[*] Generate answer-file: done"

echo "[*] Open the script and execute comments at the end"

#Generate and update an answer file: packstack --gen-answer-file=ensimag-packstack.txt
#Then in the file change IP of the computer machine and the lines below:
#CONFIG_NTP_SERVERS=10.3.252.26
#CONFIG_NEUTRON_ML2_TYPE_DRIVERS=vxlan,flat,vlan
#CONFIG_NEUTRON_ML2_FLAT_NETWORKS=extnet
#CONFIG_NEUTRON_ML2_VLAN_RANGES=extnet:2232:2232
#CONFIG_NEUTRON_OVS_BRIDGE_IFACES=br-ex:eno1
#CONFIG_NEUTRON_OVS_BRIDGES_COMPUTE=br-ex
#CONFIG_PROVISION_DEMO=n

#packstack --answer-file=ensimag-packstack.txt


#In /etc/sysconfig/network-scripts
#IPADDR=10.11.51.161
#NETMASK=255.255.255.192
#GATEWAY=10.11.51.129

