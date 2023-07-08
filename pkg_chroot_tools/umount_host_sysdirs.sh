#!/bin/bash

export LFS=/mnt/lfs

# mountpoint <PATH>: check if <PATH> is a mountpoint
mountpoint -q $LFS/dev/shm && umount $LFS/dev/shm
umount -v $LFS/dev/pts
umount -v $LFS/{sys,proc,run,dev}
umount -v $LFS/opt
