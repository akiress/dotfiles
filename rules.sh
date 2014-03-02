#!/bin/bash

# vars
IPT=/sbin/iptables

# Flush old rules, old custom tables
echo " * flushing old rules"
$IPT --flush
$IPT --delete-chain

# Set default policies for all three default chains
echo " * setting default policies"
$IPT -P INPUT DROP
$IPT -P FORWARD DROP
$IPT -P OUTPUT ACCEPT

# Block a specific ip-address
#BLOCK_THIS_IP="x.x.x.x"
#$IPT -A INPUT -s "$BLOCK_THIS_IP" -j DROP
# Enable free use of loopback interfaces

# Allow ALL incoming SSH
echo " * allowing ssh on port 22"
$IPT -A INPUT -i eth0 -p tcp --dport 43001 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A OUTPUT -o eht0 -p tcp --sport 43001 -m state --state ESTABLISHED -j ACCEPT

# Allow incoming SSH only from a sepcific network
#$IPT -A INPUT -i eth0 -p tcp -s 192.168.200.0/24 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#$IPT -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

# Allow incoming HTTP
echo " * allowing incoming HTTP on port 80"
$IPT -A INPUT -i eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A OUTPUT -o eth0 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

# Allow incoming HTTPS
echo " * allowing incoming HTTPS on port 443"
$IPT -A INPUT -i eth0 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A OUTPUT -o eth0 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT

# Allow outgoing HTTPS
echo " * allowing outgoing HTTPS on port 443"
$IPT -A OUTPUT -o eth0 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A INPUT -i eth0 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT

# MultiPorts (Allow incoming SSH, HTTP, and HTTPS)
#$IPT -A INPUT -i eth0 -p tcp -m multiport --dports 22,80,443 -m state --state NEW,ESTABLISHED -j ACCEPT
#$IPT -A OUTPUT -o eth0 -p tcp -m multiport --sports 22,80,443 -m state --state ESTABLISHED -j ACCEPT

# Allow outgoing SSH
echo " * allowing outgoing SSH on port 22"
$IPT -A OUTPUT -o eth0 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
$IPT -A INPUT -i eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

# Allow outgoing SSH only to a specific network
#$IPT -A OUTPUT -o eth0 -p tcp -d 192.168.101.0/24 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#$IPT -A INPUT -i eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

# Load balance incoming HTTPS traffic
#$IPT -A PREROUTING -i eth0 -p tcp --dport 443 -m state --state NEW -m nth --counter 0 --every 3 --packet 0 -j DNAT --to-destination 192.168.1.101:443
#$IPT -A PREROUTING -i eth0 -p tcp --dport 443 -m state --state NEW -m nth --counter 0 --every 3 --packet 1 -j DNAT --to-destination 192.168.1.102:443
#$IPT -A PREROUTING -i eth0 -p tcp --dport 443 -m state --state NEW -m nth --counter 0 --every 3 --packet 2 -j DNAT --to-destination 192.168.1.103:443

# Ping from inside to outside
echo " * allowing ping in to out"
$IPT -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
$IPT -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT

# Ping from outside to inside
echo " * allowing ping out to in"
$IPT -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
$IPT -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT

# Allow loopback access
echo " * allowing loopback devices"
$IPT -A INPUT -i lo -j ACCEPT
$IPT -A OUTPUT -o lo -j ACCEPT

# Allow packets from internal network to reach external network.
# if eth1 is connected to external network (internet)
# if eth0 is connected to internal network (192.168.1.x)
#$IPT -A FORWARD -i eth0 -o eth1 -j ACCEPT

# Allow outbound DNS
#$IPT -A OUTPUT -p udp -o eth0 --dport 53 -j ACCEPT
#$IPT -A INPUT -p udp -i eth0 --sport 53 -j ACCEPT

# Allow NIS Connections
# rpcinfo -p | grep ypbind ; This port is 853 and 850
#$IPT -A INPUT -p tcp --dport 111 -j ACCEPT
#$IPT -A INPUT -p udp --dport 111 -j ACCEPT
#$IPT -A INPUT -p tcp --dport 853 -j ACCEPT
#$IPT -A INPUT -p udp --dport 853 -j ACCEPT
#$IPT -A INPUT -p tcp --dport 850 -j ACCEPT
#$IPT -A INPUT -p udp --dport 850 -j ACCEPT

# Allow rsync from a specific network
#$IPT -A INPUT -i eth0 -p tcp -s 192.168.101.0/24 --dport 873 -m state --state NEW,ESTABLISHED -j ACCEPT
#$IPT -A OUTPUT -o eth0 -p tcp --sport 873 -m state --state ESTABLISHED -j ACCEPT

# Allow MySQL connection only from a specific network
#$IPT -A INPUT -i eth0 -p tcp -s 192.168.200.0/24 --dport 3306 -m state --state NEW,ESTABLISHED -j ACCEPT
#$IPT -A OUTPUT -o eth0 -p tcp --sport 3306 -m state --state ESTABLISHED -j ACCEPT

# Allow Sendmail or Postfix
#$IPT -A INPUT -i eth0 -p tcp --dport 25 -m state --state NEW,ESTABLISHED -j ACCEPT
#$IPT -A OUTPUT -o eth0 -p tcp --sport 25 -m state --state ESTABLISHED -j ACCEPT

# Allow IMAP and IMAPS
#$IPT -A INPUT -i eth0 -p tcp --dport 143 -m state --state NEW,ESTABLISHED -j ACCEPT
#$IPT -A OUTPUT -o eth0 -p tcp --sport 143 -m state --state ESTABLISHED -j ACCEPT

#$IPT -A INPUT -i eth0 -p tcp --dport 993 -m state --state NEW,ESTABLISHED -j ACCEPT
#$IPT -A OUTPUT -o eth0 -p tcp --sport 993 -m state --state ESTABLISHED -j ACCEPT

# Allow POP3 and POP3S
#$IPT -A INPUT -i eth0 -p tcp --dport 110 -m state --state NEW,ESTABLISHED -j ACCEPT
#$IPT -A OUTPUT -o eth0 -p tcp --sport 110 -m state --state ESTABLISHED -j ACCEPT

#$IPT -A INPUT -i eth0 -p tcp --dport 995 -m state --state NEW,ESTABLISHED -j ACCEPT
#$IPT -A OUTPUT -o eth0 -p tcp --sport 995 -m state --state ESTABLISHED -j ACCEPT

# Prevent DoS attack
#$IPT -A INPUT -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT

# Port forwarding 422 to 22
#$IPT -t nat -A PREROUTING -p tcp -d 192.168.102.37 --dport 422 -j DNAT --to 192.168.102.37:22
#$IPT -A INPUT -i eth0 -p tcp --dport 422 -m state --state NEW,ESTABLISHED -j ACCEPT
#$IPT -A OUTPUT -o eth0 -p tcp --sport 422 -m state --state ESTABLISHED -j ACCEPT

# All TCP sessions should begin with SYN
echo " * ensuring TCP sessions begin with SYN"
$IPT -A INPUT -p tcp ! --syn -m state --state NEW -j DROP

# Allow established and related packets
echo " * allowing established and related packets"
$IPT -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#echo " * allowing dns on port 53"
#$IPT -A INPUT -p udp -m udp --dport 53 -j ACCEPT

# Open ports for NTP
echo " * allowing NTP"
$IPT -A OUTPUT -p udp --dport 123 -j ACCEPT
$IPT -A INPUT -p udp --sport 123 -j ACCEPT

# Open ports for VNC
echo " * allowing VNC"
$IPT -A INPUT -m state --state NEW -m tcp -p tcp --dport 5900 -j ACCEPT

# DROP everything else and Log it
echo " * set up logging for dropped packets"
$IPT -N LOGGING
$IPT -A INPUT -j LOGGING
$IPT -A LOGGING --match limit --limit 2/min -j LOG --log-prefix "IPTables Packet Dropped: " --log-level 7
$IPT -A LOGGING -j DROP

#
# Save settings
#
echo " * saving settings"
/etc/init.d/iptables save
