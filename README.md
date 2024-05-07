# MSSD51.502

A repository for the course MSSD51.502 final report.

This is an implementation of the TunnelCrack attack (LocalNet and ServerIP) that is referenced in the paper https://papers.mathyvanhoef.com/usenix2023-tunnelcrack.pdf.

The list of scripts included are:

[] - vm/install_mitm_local_net.sh

[] - vm/install_mitm_server_ip.sh

[] - vm/install_vpnserver.sh

[] - vm/install_webserver.sh

[] - vm/install_fake_webserver.sh

[] - vm/install_fake_dns_server.sh

There is also all in one setup for a raspberry pi 4 running raspberry pi OS 64 bit bookworm. This runs localnet attack by default.

[] - pi/host_install.sh
[] - pi/docker-localnet

IP addresses:
- Web server: 128.199.102.112 check.trinityevents.sg
- VPN server: 152.42.186.94 vpn.trinityevents.sg
- Fake DNS server: 9.9.9.9 (virtualised)
- Fake Web server: 128.199.102.112 check.trinityevents.sg (virtualised)
