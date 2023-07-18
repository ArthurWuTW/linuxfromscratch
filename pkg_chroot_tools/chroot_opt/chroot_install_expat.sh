#!/bin/bash

export FILE=expat-2.5.0
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

./configure --prefix=/usr \
  --disable-static \
  --docdir=/usr/share/doc/expat-2.5.0
make
make check
make install
install -v -m644 doc/*.{html,css} /usr/share/doc/expat-2.5.0
