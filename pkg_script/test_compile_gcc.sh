#!/bin/bash

export CURR_PATH=$(pwd)
export LFS_TGT=$(uname -m)-lfs-linux-gnu
export LFS=/mnt/lfs
export TOOL_PATH=$LFS/tools/bin

echo 'int main(){}' | ${TOOL_PATH}/$LFS_TGT-gcc -xc -
readelf -l a.out | grep ld-linux
rm -v a.out
