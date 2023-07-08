#!/bin/bash

export FILE=glibc-2.37
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CHROOT_PKG=${SRC_DIR}/chroot-pkg

mkdir -p $CHROOT_PKG

if [ ! -d ${CHROOT_PKG}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${CHROOT_PKG}/
fi

cd ${CHROOT_PKG}/${FILE}

patch -Np1 -i ${SRC_DIR}/glibc-2.37-fhs-1.patch

sed '/width -=/s/workend - string/number_length/' \
  -i stdio-common/vfprintf-process-arg.c

mkdir -v build
cd build

echo "rootsbindir=/usr/sbin" > configparms

../configure --prefix=/usr \
  --disable-werror \
  --enable-kernel=3.2 \
  --enable-stack-protector=strong \
  --with-headers=/usr/include \
  libc_cv_slibdir=/usr/lib

make
make check

touch /etc/ld.so.conf
sed '/test-installation/s@$(PERL)@echo not running@' -i ../Makefile

make install

sed '/RTLDLIST=/s@/usr@@g' -i /usr/bin/ldd

cp -v ../nscd/nscd.conf /etc/nscd.conf
mkdir -pv /var/cache/nscd
