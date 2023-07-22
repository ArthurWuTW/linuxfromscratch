#!/bin/bash

export FILE=findutils-4.9.0
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CHROOT_PKG=${SRC_DIR}/chroot-pkg

mkdir -p $CHROOT_PKG

if [ ! -d ${CHROOT_PKG}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${CHROOT_PKG}/
fi

cd ${CHROOT_PKG}/${FILE}

case $(uname -m) in
  i?86)
    TIME_T_32_BIT_OK=yes ./configure --prefix=/usr --localstatedir=/var/lib/locate ;;
  x86_64)
    ./configure --prefix=/usr --localstatedir=/var/lib/locate ;;
esac

make
chown -Rv tester .
su tester -c "PATH=$PATH make check"
make install
