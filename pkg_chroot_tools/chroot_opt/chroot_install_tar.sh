#!/bin/bash

export FILE=tar-1.34
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CHROOT_PKG=${SRC_DIR}/chroot-pkg

mkdir -p $CHROOT_PKG

if [ ! -d ${CHROOT_PKG}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${CHROOT_PKG}/
fi

cd ${CHROOT_PKG}/${FILE}

FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=/usr
make
make check

make install
make -C doc install-html docdir=/usr/share/doc/tar-1.34
