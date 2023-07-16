#!/bin/bash

export FILE=mpfr-4.2.0
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CHROOT_PKG=${SRC_DIR}/chroot-pkg

mkdir -p $CHROOT_PKG

if [ ! -d ${CHROOT_PKG}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${CHROOT_PKG}/
fi

cd ${CHROOT_PKG}/${FILE}

sed -e 's/+01,234,567/+1,234,567 /' \
  -e 's/13.10Pd/13Pd/' \
  -i tests/tsprintf.c

./configure --prefix=/usr \
  --disable-static \
  --enable-thread-safe \
  --docdir=/usr/share/doc/mpfr-4.2.0
make
make html
make check
make install
make install-html
