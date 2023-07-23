#!/bin/bash

if [ "$(stat -c %d:%i /)" != "$(stat -c %d:%i /proc/1/root/.)" ]; then
  echo "We are chrooted!"
else
  printf '%s\n' "****** [Error]: NOT chroot lfs environment !!!" >&2; exit 1;
fi

cat > /etc/sysconfig/ifconfig.eth0 << "EOF"
ONBOOT=yes
IFACE=eth0
SERVICE=ipv4-static
IP=192.168.1.2
GATEWAY=192.168.1.1
PREFIX=24
BROADCAST=192.168.1.255
EOF

cat /etc/sysconfig/ifconfig.eth0

cat > /etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
# End /etc/resolv.conf
EOF

cat /etc/resolv.conf

echo "lfsesap01" > /etc/hostname

cat > /etc/hosts << "EOF"
# Begin /etc/hosts
127.0.0.1 localhost.localdomain localhost
::1 localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
# End /etc/hosts
EOF

cat /etc/hosts
