#!/bin/bash

iptables -F
iptables -X

iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT



iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT


#create a new chain named ACCEPTED_MAC
iptables -N ACCEPTED_MAC

#add rules to the user defined-chain
iptables -A ACCEPTED_MAC -m mac --mac-source B8:81:98:22:C7:6B -j ACCEPT
iptables -A ACCEPTED_MAC -m mac --mac-source B8:81:98:22:C6:7C -j ACCEPT
iptables -A ACCEPTED_MAC -m mac --mac-source B8:81:98:22:23:AB -j ACCEPT
iptables -A ACCEPTED_MAC -m mac --mac-source B8:81:98:22:67:AA -j ACCEPT


#jump fron the INPUT chain to the user-defined chain
#now packets traverse the iptables rules from the user-defined chains
iptables -A INPUT -j ACCEPTED_MAC

#if not dropped or accepted (tarminating target) continue evaluating other rules
iptables -A INPUT -p icmp -j ACCEPT
iptables -A OUTPUT -p icmp -j ACCEPT


iptables -P OUTPUT DROP
iptables -P INPUT DROP
