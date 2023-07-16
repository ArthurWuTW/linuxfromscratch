#!/bin/bash

export FILE=flex-2.6.4
export FILE_XZ=${FILE}.tar.gz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

./configure --prefix=/usr \
  --docdir=/usr/share/doc/flex-2.6.4 \
  --disable-static

make
make check
make install
ln -sv flex /usr/bin/lex
