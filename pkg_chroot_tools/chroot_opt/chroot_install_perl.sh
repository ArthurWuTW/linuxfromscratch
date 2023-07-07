#!/bin/bash

export FILE=perl-5.36.0
export FILE_XZ=${FILE}.tar.xz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

sh Configure -des \
  -Dprefix=/usr \
  -Dvendorprefix=/usr \
  -Dprivlib=/usr/lib/perl5/5.36/core_perl \
  -Darchlib=/usr/lib/perl5/5.36/core_perl \
  -Dsitelib=/usr/lib/perl5/5.36/site_perl \
  -Dsitearch=/usr/lib/perl5/5.36/site_perl \
  -Dvendorlib=/usr/lib/perl5/5.36/vendor_perl \
  -Dvendorarch=/usr/lib/perl5/5.36/vendor_perl
make
make install
