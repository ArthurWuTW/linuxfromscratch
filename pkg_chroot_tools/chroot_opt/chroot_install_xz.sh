#!/bin/bash

export FILE=xz-5.4.1
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CHROOT_PKG=${SRC_DIR}/chroot-pkg

mkdir -p $CHROOT_PKG

if [ ! -d ${CHROOT_PKG}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${CHROOT_PKG}/
fi

cd ${CHROOT_PKG}/${FILE}

./configure --prefix=/usr \
  --disable-static \
  --docdir=/usr/share/doc/xz-5.4.1

make
make check
make install
