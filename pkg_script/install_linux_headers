#!/bin/bash

export FILE=linux-6.1.11
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
make mrproper
make headers
find ${SRC_DIR}/${FILE}/usr/include -type f ! -name '*.h' -delete
cp -rv ${SRC_DIR}/${FILE}/usr/include ${LFS}/usr
