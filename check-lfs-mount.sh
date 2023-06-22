#!/bin/bash

MOUNT_POINT=/dev/sdb1
LFS_DIR=/mnt/lfs

if [ ! -d ${LFS_DIR} ];
then
  echo "Create lfs directory"
  mkdir -p /mnt/lfs
else
  echo "${LFS_DIR} already exits"
fi

if [ -z "$(df -kh | grep ${LFS_DIR})" ];
then
  echo "mounting ${MOUNT_POINT} to ${LFS_DIR}..."
  mount ${MOUNT_POINT} ${LFS_DIR}
else
  echo "${LFS_DIR} already mounted..."
fi
