#!/bin/bash

# Disable systemd-resolved
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
echo nameserver 8.8.8.8 | sudo tee /etc/resolv.conf 

sudo apt-get update
sudo apt-get install -y dnsmasq 

# Configure
echo "
log-queries
log-facility=/tmp/dnsmasq.log

# Enable DNS forwarding
port=53
domain-needed
bogus-priv
strict-order

# Forward DNS queries to these DNS servers
server=8.8.8.8
server=8.8.4.4
" | sudo tee -a /etc/dnsmasq.conf

sudo service dnsmasq restart

ssh-keygen
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
ssh -N -L 127.0.0.1:5555:vpn.trinityevents.sg:5555 127.0.0.1 
ssh -N -L 127.0.0.1:1194:vpn.trinityevents.sg:1194 127.0.0.1