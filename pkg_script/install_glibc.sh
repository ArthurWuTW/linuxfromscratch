#!/bin/bash

export FILE=glibc-2.37
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/mnt/lfs/sources
export CURR_PATH=$(pwd)
export LFS_TGT=$(uname -m)-lfs-linux-gnu
export LFS=/mnt/lfs

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi


#patch -Np1 -i ${SRC_DIR}/glibc-2.37-fhs-1.patch
# NOT APPLICABLE

cd ${SRC_DIR}/${FILE}
mkdir -v build
cd build
echo "rootsbindir=/usr/sbin" > configparms

../configure  \
  --prefix=/usr  \
  --host=$LFS_TGT  \
  --build=$(../scripts/config.guess)  \
  --enable-kernel=3.2  \
  --with-headers=$LFS/usr/include  \
  libc_cv_slibdir=/usr/lib


make DESTDIR=$LFS install




