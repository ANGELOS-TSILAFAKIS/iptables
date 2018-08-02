#!/bin/bash

#block incoming NEW packets originated from Bulgaria & Belgium
iptables -A INPUT -m geoip --src-cc BG,BE -m state --state NEW -j DROP

#allow any outgoing traffic including traffic to Bulgaria & Belgium
iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
