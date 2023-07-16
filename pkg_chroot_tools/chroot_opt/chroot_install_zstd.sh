#!/bin/bash

export FILE=zstd-1.5.4
export FILE_XZ=${FILE}.tar.gz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar zxvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

make prefix=/usr
make check
make prefix=/usr install
rm -v /usr/lib/libzstd.a
