#!/bin/bash

export FILE=findutils-4.9.0
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
  --localstatedir=/var/lib/locate \
  --host=$LFS_TGT \
  --build=$(build-aux/config.guess)

make
make DESTDIR=$LFS install

