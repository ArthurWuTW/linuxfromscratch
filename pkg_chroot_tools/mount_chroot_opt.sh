#!/bin/bash 

export LFS=/mnt/lfs

mkdir -p $LFS/opt

mount -v --bind chroot_opt $LFS/opt
