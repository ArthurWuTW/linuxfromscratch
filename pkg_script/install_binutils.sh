#!/bin/bash

export FILE=binutils-2.40
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/mnt/lfs/sources
export CURR_PATH=$(pwd)
export LFS_TGT=$(uname -m)-lfs-linux-gnu
export LFS=/mnt/lfs

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd ${SRC_DIR}/${FILE}
mkdir -v build
cd build
../configure --prefix=$LFS/tools \
             --with-sysroot=$LFS \
             --target=$LFS_TGT \
             --disable-nls \
             --enable-gprofng=no \
             --disable-werror

make
make install
