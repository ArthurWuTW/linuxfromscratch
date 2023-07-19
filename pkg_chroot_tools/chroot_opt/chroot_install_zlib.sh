#!/bin/bash

export FILE=zlib-1.2.13
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
make check
rm -fv /usr/lib/libz.a

cp -v {zlib.h,zconf.h} /usr/include/ # fix compiling binutils

cp libz.so.1.2.13 /usr/lib/
ln -s /usr/lib/libz.so.1.2.13 /usr/lib/libz.so
ln -s /usr/lib/libz.so.1.2.13 /usr/lib/libz.so.1

cp zlib.pc /usr/lib/pkgconfig/ # fix compiling kmod
