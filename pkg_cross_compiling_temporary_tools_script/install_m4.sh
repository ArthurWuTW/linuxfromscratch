#!/bin/bash

export FILE=m4-1.4.19
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/mnt/lfs/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

if [ ! "${CURR_USER}" == "lfs" ];
then
  echo "Current user is ${CURR_USER}" && { printf '%s\n' "****** [Error]: NOT as lfs user!!!" >&2; exit 1; }
fi


cd /mnt/lfs/tools/lib/gcc/x86_64-lfs-linux-gnu/12.2.0/include-fixed
rm -v limits.h
$LFS/tools/libexec/gcc/$LFS_TGT/12.2.0/install-tools/mkheaders

cd ${SRC_DIR}/${FILE}
./configure --prefix=/usr   --host=$LFS_TGT   --build=$(build-aux/config.guess)
make
make DESTDIR=$LFS install
