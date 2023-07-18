#!/bin/bash

export FILE=bash-5.2.15
export FILE_XZ=${FILE}.tar.gz
export SRC_DIR=/sources
export CHROOT_PKG=${SRC_DIR}/chroot-pkg

mkdir -p $CHROOT_PKG

if [ ! -d ${CHROOT_PKG}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${CHROOT_PKG}/
fi

cd ${CHROOT_PKG}/${FILE}

./configure --prefix=/usr \
  --without-bash-malloc \
  --with-installed-readline \
  --docdir=/usr/share/doc/bash-5.2.15
make
chown -Rv tester .

su -s /usr/bin/expect tester << EOF
set timeout -1
spawn make tests
expect eof
lassign [wait] _ _ _ value
exit $value
EOF

make install
