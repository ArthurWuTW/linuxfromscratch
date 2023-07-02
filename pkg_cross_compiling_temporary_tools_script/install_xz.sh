#!/bin/bash

export FILE=xz-5.4.1
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/mnt/lfs/sources
export CURR_USER=$(whoami)

if [ ! "${CURR_USER}" == "lfs" ];
then
  echo "Current user is ${CURR_USER}" && { printf '%s\n' "****** [Error]: NOT as lfs user!!!" >&2; exit 1; }
fi

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

./configure --prefix=/usr \
  --host=$LFS_TGT \
  --build=$(build-aux/config.guess) \
  --disable-static \
  --docdir=/usr/share/doc/xz-5.4.1

make
make DESTDIR=$LFS install
rm -v $LFS/usr/lib/liblzma.la
