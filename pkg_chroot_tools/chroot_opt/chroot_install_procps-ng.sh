#!/bin/bash

export FILE=procps-ng-4.0.2
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

./configure --prefix=/usr \
  --docdir=/usr/share/doc/procps-ng-4.0.2 \
  --disable-static \
  --disable-kill
make
make check
make install
