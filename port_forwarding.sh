#!/bin/bash

#flush nat filter / PREROUTING CHAIN
iptables -t nat -F  PREROUTING


#all packets coming to port 80 will be port forwarded to 192.168.0.20 and port 80
iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.0.20


#VARIANTS


#1.redirect port 8080 to port 80 
#internet clients connect to the public ip address of the router and port 8080 and the packets are 
#redirected to the private server and port 80
iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 192.168.0.20:80



#2. load-balancing
#on all 5 private servers (192.168.0.20-192.168.0.24)run the same service
#the router will pick-up a random private ip from the range when port-forward the packet
iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 192.168.0.20-192.168.0.24

