#!/bin/bash

if [ -z "$1" ]
then
	echo "Usage: <interface> [docker id]"
	echo "Specify the interface on which to bind"
	exit 1
fi

IFNAME="$1"
if [ -z "$2" ]
then
	DOCKERID="$(docker ps -a | awk 'NR==2 { print $1 }')"
else
	DOCKERID="$2"
fi

./pipework $IFNAME $DOCKERID 192.168.242.1/24
