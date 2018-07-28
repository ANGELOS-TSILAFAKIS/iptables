#!/bin/bash

iptables -F


#when the packet is checked against this rule, if its source ip belongs to the hacker list, 
#the packet will be dropped
#last seen time is updated with other 60 seconds (the source ip address stays in the list for another 60 seconds)
iptables -A INPUT -m recent --name hackers --update --seconds 60 -j DROP


#when the 1st matched packet arrives (tcp/25 between 8:00-10:00), a list named hacker is created,
#the source ip address of the packet is added to that list and the packet is dropped
iptables -A INPUT -p tcp --dport 25 -m time --timestart 8:00 --timestop 10:00 -m recent --name hackers --set -j DROP
