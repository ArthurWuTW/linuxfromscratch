#!/bin/bash

export FILE=coreutils-9.1
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/mnt/lfs/sources
export CURR_USER=$(whoami)

if [ ! "${CURR_USER}" == "lfs" ];
then
  echo "Current user is ${CURR_USER}" && { printf '%s\n' "****** [Error]: NOT as lfs user!!!" >&2; exit 1; }
fi

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi


cd $SRC_DIR/$FILE

./configure --prefix=/usr  \
  --host=$LFS_TGT  \
  --build=$(build-aux/config.guess) \
  --enable-install-program=hostname \
  --enable-no-install-program=kill,uptime


make
make DESTDIR=$LFS install
mv -v $LFS/usr/bin/chroot $LFS/usr/sbin
mkdir -pv $LFS/usr/share/man/man8
mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' $LFS/usr/share/man/man8/chroot.8
