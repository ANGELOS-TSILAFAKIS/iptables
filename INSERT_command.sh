#!/bin/bash
iptables -F

#I used -I instead of -A and line no. 8 is the first rule from INPUT CHAIN => ALL SSH TRAFFIC IS DROPPED
iptables -t filter -I INPUT -s 192.168.0.20 -p tcp --dport 22 -j ACCEPT #last line
iptables -t filter -I INPUT -s 192.168.0.5 -p tcp --dport 22 -j ACCEPT  #second line

iptables -I INPUT -p tcp --dport 22 -j DROP	#first line 
