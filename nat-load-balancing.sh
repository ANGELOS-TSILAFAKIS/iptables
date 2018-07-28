#!/bin/bash

#flush the nat table from all chains
iptables -t nat -F



#enable routing process
echo "1" > /proc/sys/net/ipv4/ip_forward


#OUR ROUTER HAS 2 INTERNET CONNECTIONS FROM 2 PROVIDERS
#THE EXTERNAL INTERFACES ARE ETH0 CONNECTED TO ISP1 AND ETH1 CONNECTED TO ISP2
#WE WANT TO SEND TCP TRAFFIC THROUGH ISP1 AND UDP AND ICMP TRAFFIC THROUGH ISP2 
#IF THERE IS ANY OTHER PROTOCOL IS GOES THROUGH ISP2

#tcp traffic is sent out on etho to isp1
iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -p tcp  -o eth0 -j MASQUERADE

#icmp traffic is sent out on eth1 to isp2
iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -p icmp -o eth1 -j MASQUERADE

#udp traffic is sent out on eth1 to isp2
iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -p udp -o eth1 -j MASQUERADE


#all other protocols are sent out on eth1 to isp1
iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o eth1 -j MASQUERADE


