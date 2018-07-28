#!/bin/bash


iptables -F INPUT


PERMITED_MACS="08:00:27:15:b2:ec 08:00:27:15:b2:df 08:00:27:15:b2:ab"

#this host can communicate only with other hosts inside our LAN that have a MAC address from this list 
#to be able to communicate outside the LAN (ex Internet) the MAC of the router internal interface 
#should be permited
for MAC in $PERMITED_MACS
do
	iptables -A INPUT -m mac --mac-source $MAC -j ACCEPT

done


#set POLICY to DROP
#all other packets are dropped
iptables -P INPUT DROP
