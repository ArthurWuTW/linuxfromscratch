#!/bin/bash

CURR_USER=$(whoami)

if [ ! "${CURR_USER}" == "lfs" ];
then
  echo "Current user is ${CURR_USER}" && { printf '%s\n' "****** [Error]: NOT as lfs user! Please use command>>> su lfs " >&2; exit 1; }
  
  echo "Run change_mnt_lfs_owner_to_lfs_user.sh..."
  ./change_mnt_lfs_owner_to_lfs_user.sh

  echo "Run install_m4.sh..."
  ./install_m4.sh

  echo "Run install_ncurses.sh..."
  ./install_ncurses.sh
fi
