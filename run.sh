#!/bin/bash

source env.sh

if [ ${VERSION_CHECK} == 1 ];
then
  echo "Run version-check.sh..."
  ./version-check.sh

fi

if [ ${INSTALL_HOST_PKG} == 1 ];
then
  echo "Install host pkg..."
  ./install_host_pkg.sh
fi

if [ ${CHECK_PARTITION} == 1 ];
then
  echo "Run check-partition.sh..."
  ./check-partition.sh
fi

if [ ${CHECK_MOUNT} == 1 ];
then
  echo "Run check-lfs-mount.sh..."
  ./check-lfs-mount.sh
fi

if [ ${DOWNLOAD_LFS_PKG} == 1 ];
then
  echo "Run downlad_lfs_pkg.sh..."
  ./download_lfs_pkg.sh
fi

if [ ${LFS_INIT} == 1 ];
then
  echo "Run create-lfs-dirs.sh..."
  ./create-lfs-dirs.sh
  echo "Run add-lfs-user.sh..."
  ./add-lfs-user.sh

fi

