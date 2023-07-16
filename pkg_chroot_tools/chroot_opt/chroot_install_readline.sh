#!/bin/bash

export FILE=readline-8.2
export FILE_XZ=${FILE}.tar.gz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar zxvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

patch -Np1 -i ../readline-8.2-upstream_fix-1.patch
./configure --prefix=/usr \
  --disable-static \
  --with-curses \
  --docdir=/usr/share/doc/readline-8.2
make SHLIB_LIBS="-lncursesw"
make SHLIB_LIBS="-lncursesw" install
