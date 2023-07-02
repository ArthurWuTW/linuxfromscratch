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

  echo "Run install_bash.sh..."
  ./install_bash.sh

  echo "Run install_coreutils.sh..."
  ./install_coreutils.sh

  echo "Run install_diffutils.sh..."
  ./install_diffutils.sh

  echo "Run install_file.sh..."
  ./install_file.sh

  echo "Run install_findutils.sh..."
  ./install_findutils.sh

  echo "Run install_gawk.sh..."
  ./install_gawk.sh

  echo "Run install_grep.sh..."
  ./install_grep.sh

  echo "Run install_gzip.sh..."
  ./install_gzip.sh

  echo "Run install_make.sh..."
  ./install_make.sh

  echo "Run install_patch.sh..."
  ./install_patch.sh

  echo "Run install_sed.sh..."
  ./install_sed.sh
fi
