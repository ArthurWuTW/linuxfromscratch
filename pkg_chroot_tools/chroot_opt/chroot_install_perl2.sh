#!/bin/bash

export FILE=perl-5.36.0
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CHROOT_PKG=${SRC_DIR}/chroot-pkg

mkdir -p $CHROOT_PKG

if [ ! -d ${CHROOT_PKG}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${CHROOT_PKG}/
fi

cd ${CHROOT_PKG}/${FILE}

export BUILD_ZLIB=False
export BUILD_BZIP2=0

sh Configure -des \
  -Dprefix=/usr \
  -Dvendorprefix=/usr \
  -Dprivlib=/usr/lib/perl5/5.36/core_perl \
  -Darchlib=/usr/lib/perl5/5.36/core_perl \
  -Dsitelib=/usr/lib/perl5/5.36/site_perl \
  -Dsitearch=/usr/lib/perl5/5.36/site_perl \
  -Dvendorlib=/usr/lib/perl5/5.36/vendor_perl \
  -Dvendorarch=/usr/lib/perl5/5.36/vendor_perl \
  -Dman1dir=/usr/share/man/man1 \
  -Dman3dir=/usr/share/man/man3 \
  -Dpager="/usr/bin/less -isR" \
  -Duseshrplib \
  -Dusethreads

make
make test
make install
unset BUILD_ZLIB BUILD_BZIP2
