#!/bin/bash

export FILE=automake-1.16.5
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.16.5

make
make -j4 check
make install
