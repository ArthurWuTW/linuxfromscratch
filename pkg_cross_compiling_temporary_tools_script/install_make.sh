#!/bin/bash

export FILE=make-4.4
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

sed -e '/ifdef SIGPIPE/,+2 d' \
  -e '/undef FATAL_SIG/i FATAL_SIG (SIGPIPE);' \
  -i src/main.c

./configure --prefix=/usr \
  --without-guile \
  --host=$LFS_TGT \
  --build=$(build-aux/config.guess)

make
make DESTDIR=$LFS install
