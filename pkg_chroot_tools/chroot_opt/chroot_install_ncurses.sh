#!/bin/bash

export FILE=ncurses-6.4
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
  --mandir=/usr/share/man \
  --with-shared \
  --without-debug \
  --without-normal \
  --with-cxx-shared \
  --enable-pc-files \
  --enable-widec \
  --with-pkg-config-libdir=/usr/lib/pkgconfig

make
make DESTDIR=$PWD/dest install
install -vm755 dest/usr/lib/libncursesw.so.6.4 /usr/lib
rm -v dest/usr/lib/libncursesw.so.6.4
cp -av dest/* /

for lib in ncurses form panel menu ;
do
  rm -vf /usr/lib/lib${lib}.so
  echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
  ln -sfv ${lib}w.pc /usr/lib/pkgconfig/${lib}.pc
done

rm -vf /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sfv libncurses.so /usr/lib/libcurses.so

mkdir -pv /usr/share/doc/ncurses-6.4
cp -v -R doc/* /usr/share/doc/ncurses-6.4
