#!/bin/bash

export FILE=binutils-2.40
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

if [ -d ${SRC_DIR}/${FILE}/build ];
then
  rm -rvf ${SRC_DIR}/${FILE}/build
fi

cd $SRC_DIR/$FILE

sed '6009s/$add_dir//' -i ltmain.sh
mkdir -v build
cd build

../configure \
  --prefix=/usr \
  --build=$(../config.guess) \
  --host=$LFS_TGT \
  --disable-nls \
  --enable-shared \
  --enable-gprofng=no \
  --disable-werror \
  --enable-64-bit-bfd

make
make DESTDIR=$LFS install
rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.{a,la}



