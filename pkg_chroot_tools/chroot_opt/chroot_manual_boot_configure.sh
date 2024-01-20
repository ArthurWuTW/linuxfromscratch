#!/bin/bash

if [ "$(stat -c %d:%i /)" != "$(stat -c %d:%i /proc/1/root/.)" ]; then
  echo "We are chrooted!"
else
  printf '%s\n' "****** [Error]: NOT chroot lfs environment !!!" >&2; exit 1;
fi

echo "============================================================================"
echo "Manual Step: >> grub-install <LFS_FILE_SYSTEM> (ex: grub-install /dev/sdb)"
echo "<LFS_FILE_SYSTEM>: see the filesystem below with command >> df -kh"
echo "============================================================================"

BOOT_DF=$(df -kh | grep boot)
if [ -z "$BOOT_DF" ]; then
  echo "Grub install in / partition --- "
  df -kh | grep "/$"
else
  echo "Grub install in /boot partition --- "
  df -kh | grep boot
fi
