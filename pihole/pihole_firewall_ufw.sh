#!/bin/bash

# Needs to run as root!
if [ $UID != 0 ] ; then
    echo "Need to run as root, use sudo"
    exit 1
fi

# Install packages if not found
if ! command -v iptables 2>&1 >/dev/null; then
    echo "iptables could not be found; installing..."
    apt install -y iptables
fi

if ! command -v ip6tables 2>&1 >/dev/null; then
    echo "ip6tables could not be found; installing..."
    apt install -y ip6tables
fi

if ! command -v ufw 2>&1 >/dev/null; then
    echo "ufw could not be found; installing..."
    apt install -y ufw
fi

# IPTables, IPv4
echo "Setting up iptables ipv4..."
iptables -I INPUT 1 -s 192.168.0.0/16 -p tcp -m tcp --dport 80 -j ACCEPT
iptables -I INPUT 1 -s 127.0.0.0/8 -p tcp -m tcp --dport 53 -j ACCEPT
iptables -I INPUT 1 -s 127.0.0.0/8 -p udp -m udp --dport 53 -j ACCEPT
iptables -I INPUT 1 -s 192.168.0.0/16 -p tcp -m tcp --dport 53 -j ACCEPT
iptables -I INPUT 1 -s 192.168.0.0/16 -p udp -m udp --dport 53 -j ACCEPT
iptables -I INPUT 1 -p udp --dport 67:68 --sport 67:68 -j ACCEPT
iptables -I INPUT 1 -p tcp -m tcp --dport 4711 -i lo -j ACCEPT
iptables -I INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# IPTables, IPv6
echo "Setting up iptables ipv6..."
ip6tables -I INPUT -p udp -m udp --sport 546:547 --dport 546:547 -j ACCEPT
ip6tables -I INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# ufw, IPv4
echo "Setting up ufw ipv4..."
ufw allow 80/tcp
ufw allow 53/tcp
ufw allow 53/udp
ufw allow 67/tcp
ufw allow 67/udp

# ufw, IPv6
echo "Setting up ufw ipv6..."
ufw allow 546:547/udp

