#!/bin/bash

export FILE=libtool-2.4.7
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

./configure --prefix=/usr
make
make -k check
make install
rm -fv /usr/lib/libltdl.a
