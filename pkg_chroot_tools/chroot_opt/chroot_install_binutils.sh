#!/bin/bash

export FILE=binutils-2.40
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CHROOT_PKG=${SRC_DIR}/chroot-pkg

mkdir -p $CHROOT_PKG

if [ ! -d ${CHROOT_PKG}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${CHROOT_PKG}/
fi

cd ${CHROOT_PKG}/${FILE}

mkdir -v build
cd build

../configure --prefix=/usr \
  --sysconfdir=/etc \
  --enable-gold \
  --enable-ld=default \
  --enable-plugins \
  --enable-shared \
  --disable-werror \
  --enable-64-bit-bfd \
  --with-system-zlib

make tooldir=/usr
make -k check
make tooldir=/usr install
rm -fv /usr/lib/lib{bfd,ctf,ctf-nobfd,sframe,opcodes}.a
rm -fv /usr/share/man/man1/{gprofng,gp-*}.1
