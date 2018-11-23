# netboot.xyz for Docker

This is a Dockerfile to build a container running a PXE server to
server the netboot.xyz DHCP boot file.

## Quick start
Build and run the docker container with
```
./start.sh
```
and then bind the container to your network using pipework by running
```
./bind.sh <your interface name>
```
If you are running more than one docker container, you also need to specify the container ID:
```
./bind.sh <your interface name> <container id>
```

## Can I change the IP address, 192.168.242.1...?

Yes. Be aware that the DHCP server on this container will offer IPs from 101 to 199 on the same /24 subnet. 
So make sure that the IP you give to the container via pipework does not clash with that.
Also make sure that there are no other hosts on that bridge within that range. 
Otherwise, change it in the Dockerfile, check the line that says --dhcp-range=(...).


## Can I *not* use pipework?

Yes, but it will be more complicated. You will have to:

- make sure that Docker UDP can handle broadcast packets (since PXE/DHCP
  uses broadcast packets);
- make sure that UDP ports are correctly mapped;
- auto-detect the gateway address and DNS server, instead of using the
  container as a router+DNS server;
- maybe something else that I overlooked.
