#!/bin/bash

export FILE=sysvinit-3.06
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

patch -Np1 -i ../sysvinit-3.06-consolidated-1.patch
make
make install
