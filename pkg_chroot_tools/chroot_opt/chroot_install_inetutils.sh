#!/bin/bash

export FILE=inetutils-2.4
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

./configure --prefix=/usr \
  --bindir=/usr/bin \
  --localstatedir=/var \
  --disable-logger \
  --disable-whois \
  --disable-rcp \
  --disable-rexec \
  --disable-rlogin \
  --disable-rsh \
  --disable-servers

make
make check
make install
mv -v /usr/{,s}bin/ifconfig
