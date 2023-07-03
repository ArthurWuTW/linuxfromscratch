#!/bin/bash

export FILE=binutils-2.40
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/mnt/lfs/sources
export LFS_PKG=${SRC_DIR}/lfs-pkg
export CURR_USER=$(whoami)

if [ ! "${CURR_USER}" == "lfs" ];
then
  echo "Current user is ${CURR_USER}" && { printf '%s\n' "****** [Error]: NOT as lfs user!!!" >&2; exit 1; }
fi

mkdir ${LFS_PKG}

tar xvf ${SRC_DIR}/${FILE_XZ} -C ${LFS_PKG}/

cd ${LFS_PKG}/${FILE}

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



