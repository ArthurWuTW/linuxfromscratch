#!/bin/bash

export FILE=autoconf-2.71
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

sed -e 's/SECONDS|/&SHLVL|/' \
    -e '/BASH_ARGV=/a\        /^SHLVL=/ d' \
    -i.orig tests/local.at
./configure --prefix=/usr
make
make TESTSUITEFLAGS=-j4 check
make install
