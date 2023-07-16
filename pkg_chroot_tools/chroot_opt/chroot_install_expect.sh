#!/bin/bash

export FILE=expect5.45.4
export FILE_XZ=${FILE}.tar.gz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

./configure --prefix=/usr \
  --with-tcl=/usr/lib \
  --enable-shared \
  --mandir=/usr/share/man \
  --with-tclinclude=/usr/include

make
make test
make install
ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib
