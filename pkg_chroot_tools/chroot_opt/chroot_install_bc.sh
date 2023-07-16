#!/bin/bash

export FILE=bc-6.2.4
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

CC=gcc ./configure --prefix=/usr -G -O3 -r
make
make test
make install
