#!/bin/bash

IFNAME="enp0s20"
DOCKERID="$(docker ps -a | awk 'NR==2 { print $1 })"

./pipework $IFNAME $DOCKERID 192.168.242.1/24
