#!/bin/bash

export LFS=/mnt/lfs
export CURR_USER=$(whoami)

if [ ! "${CURR_USER}" == "root" ];
then
  echo "Current user is ${CURR_USER}" && { printf '%s\n' "****** [Error]: NOT as root !!!" >&2; exit 1; }
fi

chroot "$LFS" /usr/bin/env -i \
  HOME=/root \
  TERM="$TERM" \
  PS1='(lfs chroot) \u:\w\$ ' \
  PATH=/usr/bin:/usr/sbin \
  /bin/bash --login
