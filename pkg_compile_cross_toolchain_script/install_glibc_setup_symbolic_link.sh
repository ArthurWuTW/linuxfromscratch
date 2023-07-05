#!/bin/bash

export LFS=/mnt/lfs

# symbolic link points to relative path
case $(uname -m) in
  x86_64) 
    ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
    ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
;;
esac

sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd
