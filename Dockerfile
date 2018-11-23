FROM stackbrew/debian:jessie
RUN apt-get -q update
RUN apt-get -qy install dnsmasq wget iptables
COPY pipework /root
RUN chmod +x /root/pipework
RUN mkdir /tftp
WORKDIR /tftp
ENV NETBOOT https://boot.netboot.xyz
RUN wget $NETBOOT/ipxe/netboot.xyz.kpxe
CMD \
    echo Setting up iptables... &&\
    iptables -t nat -A POSTROUTING -j MASQUERADE &&\
    echo Waiting for pipework to give us the eth1 interface... &&\
    /root/pipework --wait &&\
    myIP=$(ip addr show dev eth1 | awk -F '[ /]+' '/global/ {print $3}') &&\
    mySUBNET=$(echo $myIP | cut -d '.' -f 1,2,3) &&\
    echo Starting DHCP+TFTP server...&&\
    dnsmasq --interface=eth1 \
    	    --dhcp-range=$mySUBNET.101,$mySUBNET.199,255.255.255.0,1h \
	    --dhcp-boot=netboot.xyz.kpxe,pxeserver,$myIP \
	    --enable-tftp --tftp-root=/tftp/ --no-daemon

# This Dockerfile may require --privileged
