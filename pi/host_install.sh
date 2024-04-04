#!/bin/bash

# use bullseye
#needed if not using pi
#sudo nano /etc/default/grub
#GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"

# Install
apt-get install -y iptables-persistent hostapd bridge-utils 

# Enable IP forwarding
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p

# Set up NAT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables-save > /etc/iptables/rules.v4

# Configure hostapd
echo "interface=wlan0
driver=nl80211
ssid=testnetwork
hw_mode=g
channel=10
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=passpassword
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP" | tee /etc/hostapd/hostapd.conf

echo "DAEMON_CONF='/etc/hostapd/hostapd.conf'" > /etc/default/hostapd

# pi network interface
echo "
interface eth0
    dhcp

interface wlan0
    # static ip_address=128.199.102.1/24
    nohook wpa_supplicant
    promisc

# interface br0
#     static ip_address=128.199.102.1/24
#     bridge_ports wlan0
" |  tee /etc/dhcpcd.conf
service dhcpcd restart 

# install docker
curl -sSL https://get.docker.com | sh

# Configure the network interfaces
#echo "
#allow-hotplug eth0
#iface eth0 inet dhcp
#
#auto wlan0
#iface wlan0 inet manual
#up brctl addif br0 wlan0
#
#auto br0
#iface br0 inet manual
#addres 128.199.102.1
#netmask 255.255.255.0 
#" | sudo tee /etc/network/interfaces
#service networking restart

echo  "
#log all dns queries
log-queries

# Enable DNS forwarding
port=53
domain-needed
bogus-priv
strict-order
listen-address=128.199.102.1

# Forward DNS queries to these DNS servers
server=1.1.1.1

# DHCP range-leases
dhcp-range=128.199.102.10,128.199.102.100,255.255.255.0,1h

# DHCP Option
dhcp-option=option:router,128.199.102.1
dhcp-option=option:dns-server,128.199.102.1
dhcp-authoritative

# explicitly define host-ip mappings
# address=/vpn.trinityevents.sg/8.8.8.8
" |  tee /etc/dnsmasq.conf