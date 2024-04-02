#!/bin/bash

# Update packages
sudo apt-get update

# Disable systemd-resolved
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
echo nameserver 8.8.8.8 | sudo tee /etc/resolv.conf 

# Install 
sudo apt-get install -y ifupdown net-tools hostapd net-tools dnsmasq 

# Configure the network interfaces
echo "
auto ens33
iface ens33 inet dhcp

auto ens37
iface ens37 inet manual

auto wlan0
iface wlan0 inet manual
" | sudo tee /etc/network/interfaces

# Restart networking service
sudo systemctl unmask networking
sudo systemctl enable networking
sudo service networking restart

# Configure hostapd
echo "interface=wlan0
driver=nl80211
ssid=testnetwork
hw_mode=g
channel=6
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=password
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP" | sudo tee /etc/hostapd/hostapd.conf

# Enable IP forwarding
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Set up IP tables
sudo iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE

sudo systemctl unmask hostapd
sudo systemctl enable hostapd

sudo service networking restart
