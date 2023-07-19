#!/bin/bash

export FILE=elfutils-0.188
export FILE_XZ=${FILE}.tar
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  bunzip2 -k ${SRC_DIR}/${FILE_XZ}.bz2
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

./configure --prefix=/usr \
  --disable-debuginfod \
  --enable-libdebuginfod=dummy

make
make check # The test named run-native-test.sh is known to fail.
make -C libelf install # nstall only Libelf
install -vm644 config/libelf.pc /usr/lib/pkgconfig
rm /usr/lib/libelf.a
