#!/bin/bash

export FILE=man-db-2.11.2
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

./configure --prefix=/usr \
  --docdir=/usr/share/doc/man-db-2.11.2 \
  --sysconfdir=/etc \
  --disable-setuid \
  --enable-cache-owner=bin \
  --with-browser=/usr/bin/lynx \
  --with-vgrind=/usr/bin/vgrind \
  --with-grap=/usr/bin/grap \
  --with-systemdtmpfilesdir= \
  --with-systemdsystemunitdir=
make
make check
make install
