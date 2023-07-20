#!/bin/bash

export FILE=gawk-5.2.1
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CHROOT_PKG=${SRC_DIR}/chroot-pkg

mkdir -p $CHROOT_PKG

if [ ! -d ${CHROOT_PKG}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${CHROOT_PKG}/
fi

cd ${CHROOT_PKG}/${FILE}

sed -i 's/extras//' Makefile.in
./configure --prefix=/usr

make
make check
make LN='ln -f' install
mkdir -pv /usr/share/doc/gawk-5.2.1
cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-5.2.1
