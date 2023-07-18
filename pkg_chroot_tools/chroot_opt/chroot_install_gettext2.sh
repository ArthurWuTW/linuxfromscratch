#!/bin/bash

export FILE=gettext-0.21.1
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
  --docdir=/usr/share/doc/gettext-0.21.1
make
make check
make install
chmod -v 0755 /usr/lib/preloadable_libintl.so
