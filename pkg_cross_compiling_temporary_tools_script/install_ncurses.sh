#!/bin/bash

export FILE=ncurses-6.4
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

sed -i s/mawk// configure
mkdir build
pushd build
../configure
make -C include
make -C progs tic
popd

./configure --prefix=/usr \
  --host=$LFS_TGT \
  --build=$(./config.guess) \
  --mandir=/usr/share/man \
  --with-manpage-format=normal \
  --with-shared \
  --without-normal \
  --with-cxx-shared \
  --without-debug \
  --without-ada \
  --disable-stripping \
  --enable-widec

make
make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so
