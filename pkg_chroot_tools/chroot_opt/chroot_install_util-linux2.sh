#!/bin/bash

export FILE=util-linux-2.38.1
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CHROOT_PKG=${SRC_DIR}/chroot-pkg

mkdir -p $CHROOT_PKG

if [ ! -d ${CHROOT_PKG}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${CHROOT_PKG}/
fi

cd ${CHROOT_PKG}/${FILE}

./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
  --bindir=/usr/bin \
  --libdir=/usr/lib \
  --sbindir=/usr/sbin \
  --disable-chfn-chsh \
  --disable-login \
  --disable-nologin \
  --disable-su \
  --disable-setpriv \
  --disable-runuser \
  --disable-pylibmount \
  --disable-static \
  --without-python \
  --without-systemd \
  --without-systemdsystemunitdir \
  --docdir=/usr/share/doc/util-linux-2.38.1

make
make install
