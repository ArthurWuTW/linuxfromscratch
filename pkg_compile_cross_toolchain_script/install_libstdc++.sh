#!/bin/bash

LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE


export FILE=gcc-12.2.0
export SRC_DIR=/mnt/lfs/sources
export CURR_PATH=$(pwd)
#export LFS_TGT=$(uname -m)-lfs-linux-gnu
#export LFS=/mnt/lfs

cd ${SRC_DIR}/${FILE}
mkdir -v build
cd build

../libstdc++-v3/configure \
  --host=$LFS_TGT \
  --build=$(../config.guess) \
  --prefix=/usr \
  --disable-multilib \
  --disable-nls \
  --disable-libstdcxx-pch \
  --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/12.2.0

make
make DESTDIR=$LFS install

