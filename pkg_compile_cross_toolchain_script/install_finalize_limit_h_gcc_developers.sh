#!/bin/bash

export LFS_TGT=$(uname -m)-lfs-linux-gnu
export LFS=/mnt/lfs

$LFS/tools/libexec/gcc/$LFS_TGT/12.2.0/install-tools/mkheaders
