#!/bin/bash

export FILE=make-4.4
export FILE_XZ=${FILE}.tar.gz
export SRC_DIR=/sources
export CHROOT_PKG=${SRC_DIR}/chroot-pkg

mkdir -p $CHROOT_PKG

if [ ! -d ${CHROOT_PKG}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${CHROOT_PKG}/
fi

cd ${CHROOT_PKG}/${FILE}

sed -e '/ifdef SIGPIPE/,+2 d' \
  -e '/undef FATAL_SIG/i FATAL_SIG (SIGPIPE);' \
  -i src/main.c
./configure --prefix=/usr
make
make check
make install
