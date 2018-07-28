#!/bin/bash

#flushes the filter table
iptables -F


#!!!!! TIME is UTC and not system time

#acceps tcp port 22 packets ONLY daily between 8:00-18:00
iptables -A INPUT -p tcp --dport 22 -m time --timestart 8:00 --timestop 18:00 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP


#forward traffic (this is the Router) to www.ubuntu.com daily between 18:00-08:00
iptables -A FORWARD -p tcp --dport 80 -d www.ubuntu.com -m time --timestart 18:00 --timestop 8:00 -j ACCEPT
#packets to www.ubuntu.com are dropped between 8:00 - 18:00 (working hours)
iptables -A FORWARD -p tcp --dport 80 -d www.ubuntu.com -j DROP
