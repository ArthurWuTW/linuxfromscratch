#!/bin/bash

export FILE=gcc-12.2.0
export SRC_DIR=/mnt/lfs/sources
export LFS_PKG=${SRC_DIR}/lfs-pkg
export CURR_PATH=$(pwd)
export LFS_TGT=$(uname -m)-lfs-linux-gnu
export LFS=/mnt/lfs
export DEPEND_XZ=(gmp-6.2.1 mpfr-4.2.0)
export DEPEND_GZ=(mpc-1.3.1)
export DEPEND_ALL=("${DEPEND_XZ[@]}" "${DEPEND_GZ[@]}")
export CURR_USER=$(whoami)


if [ ! "${CURR_USER}" == "lfs" ];
then
  echo "Current user is ${CURR_USER}" && { printf '%s\n' "****** [Error]: NOT as lfs user!!!" >&2; exit 1; }
fi

mkdir -p ${LFS_PKG}

for((i=0;i<${#DEPEND_XZ[@]};i++));
do
  if [ ! -d ${LFS_PKG}/${DEPEND_XZ[i]} ];
  then
    tar xvf ${SRC_DIR}/${DEPEND_XZ[i]}.tar.xz -C ${LFS_PKG}/
  fi
done

for((i=0;i<${#DEPEND_GZ[@]};i++));
do
  if [ ! -d ${LFS_PKG}/${DEPEND_GZ[i]} ];
  then
    tar xvf ${SRC_DIR}/${DEPEND_GZ[i]}.tar.gz -C ${LFS_PKG}/
  fi
done

if [ ! -d ${LFS_PKG}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE}.tar.xz -C ${LFS_PKG}/
fi

for((i=0;i<${#DEPEND_ALL[@]};i++));
do
  if [ -d ${LFS_PKG}/${DEPEND_ALL[i]} ];
  then
    FILENAME_WITHOUT_VERSION=$(echo ${DEPEND_ALL[i]} | cut -d"-" -f 1)
    
    if [ ! -d ${LFS_PKG}/${FILE}/${FILENAME_WITHOUT_VERSION} ];
    then
      cp -rv ${LFS_PKG}/${DEPEND_ALL[i]} ${LFS_PKG}/${FILE}/${FILENAME_WITHOUT_VERSION}
    fi

  fi
done

cd ${LFS_PKG}/${FILE}

case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
;;
esac

sed '/thread_header =/s/@.*@/gthr-posix.h/' \
  -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

mkdir -v build
cd build

../configure \
  --build=$(../config.guess) \
  --host=$LFS_TGT \
  --target=$LFS_TGT \
  LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc \
  --prefix=/usr \
  --with-build-sysroot=$LFS \
  --enable-default-pie \
  --enable-default-ssp \
  --disable-nls \
  --disable-multilib \
  --disable-libatomic \
  --disable-libgomp \
  --disable-libquadmath \
  --disable-libssp \
  --disable-libvtv \
  --enable-languages=c,c++

make
make DESTDIR=$LFS install
ln -sv gcc $LFS/usr/bin/cc






