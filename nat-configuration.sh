#!/bin/bash

#flush the nat table from all chains
iptables -t nat -F



#enable routing process
echo "1" > /proc/sys/net/ipv4/ip_forward


#define rules that match traffic that should be NATed
#we nat all subnetwork
#-o enp0s3 is the external interface
#80.0.0.1 is the public & static ip address
iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o enp0s3 -j SNAT --to-source 80.0.0.1


#if the public IP address is dynamic we use MASQUERADE instead of SNAT
#iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o enp0s3 -j MASQUERADE


#it's not mandatory to nat all subnet, we could for example nat on some protocols
#filtering is done on FORWARD CHAIN
