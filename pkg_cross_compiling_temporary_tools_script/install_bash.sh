#!/bin/bash

export FILE=bash-5.2.15
export FILE_XZ=${FILE}.tar.gz
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
  --build=$(sh support/config.guess) \
  --host=$LFS_TGT \
  --without-bash-malloc

make
make DESTDIR=$LFS install
ln -sv bash $LFS/bin/sh
