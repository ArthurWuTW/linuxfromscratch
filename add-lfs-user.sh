#!/bin/bash

export LFS=/mnt/lfs

if [ -z "$(cat /etc/passwd | grep lfs)" ];
then
  echo "Create User lfs"
  groupadd lfs
  useradd -s /bin/bash -g lfs -m -k /dev/null lfs

  chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
  case $(uname -m) in
    x86_64) 
      chown -v lfs $LFS/lib64 ;;
  esac
fi

LFS_HOME=/home/lfs

cat > $LFS_HOME/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > $LFS_HOME/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF

chown -v lfs $LFS_HOME/.bash_profile $LFS_HOME/.bashrc
