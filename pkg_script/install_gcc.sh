#!/bin/bash

export FILE=gcc-12.2.0
export SRC_DIR=/mnt/lfs/sources
export CURR_PATH=$(pwd)
export LFS_TGT=$(uname -m)-lfs-linux-gnu
export LFS=/mnt/lfs
export DEPEND_XZ=(gmp-6.2.1 mpfr-4.2.0)
export DEPEND_GZ=(mpc-1.3.1)
export DEPEND_ALL=("${DEPEND_XZ[@]}" "${DEPEND_GZ[@]}")

for((i=0;i<${#DEPEND_XZ[@]};i++));
do
  if [ ! -d ${SRC_DIR}/${DEPEND_XZ[i]} ];
  then
    tar xvf ${SRC_DIR}/${DEPEND_XZ[i]}.tar.xz -C ${SRC_DIR}/
  fi
done

for((i=0;i<${#DEPEND_GZ[@]};i++));
do
  if [ ! -d ${SRC_DIR}/${DEPEND_GZ[i]} ];
  then
    tar xvf ${SRC_DIR}/${DEPEND_GZ[i]}.tar.gz -C ${SRC_DIR}/
  fi
done

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE}.tar.xz -C ${SRC_DIR}/
fi

for((i=0;i<${#DEPEND_ALL[@]};i++));
do
  if [ -d ${SRC_DIR}/${DEPEND_ALL[i]} ];
  then
    FILENAME_WITHOUT_VERSION=$(echo ${DEPEND_ALL[i]} | cut -d"-" -f 1)
    
    if [ ! -d ${SRC_DIR}/${FILE}/${FILENAME_WITHOUT_VERSION} ];
    then
      cp -rv ${SRC_DIR}/${DEPEND_ALL[i]} ${SRC_DIR}/${FILE}/${FILENAME_WITHOUT_VERSION}
    fi

  fi
done


case $(uname -m) in
  x86_64)
    # replace lib64 with lib in line which matched pattern m64
    # -i.orig means backup origin file and named as XXXX.orig
    sed -e '/m64=/s/lib64/lib/' -i.orig ${SRC_DIR}/${FILE}/gcc/config/i386/t-linux64
;;
esac

# Issue: 
#   If autoconf version mismatch error, do this command
#cd ${SRC_DIR}/${FILE}/mpfr && autoreconf


cd ${SRC_DIR}/${FILE}
mkdir -v build
cd build

../configure \
  --target=$LFS_TGT \
  --prefix=$LFS/tools \
  --with-glibc-version=2.37 \
  --with-sysroot=$LFS \
  --with-newlib \
  --without-headers \
  --enable-default-pie \
  --enable-default-ssp \
  --disable-nls \
  --disable-shared \
  --disable-multilib \
  --disable-threads \
  --disable-libatomic \
  --disable-libgomp \
  --disable-libquadmath \
  --disable-libssp \
  --disable-libvtv \
  --disable-libstdcxx \
  --enable-languages=c,c++

make
make install
