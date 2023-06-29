#!/bin/bash

./install_binutils.sh
./install_gcc.sh
./install_linux_headers.sh
./install_glibc.sh
./install_glibc_setup_symbolic_link.sh
./install_finalize_limit_h_gcc_developers.sh
./install_libstdc++.sh
./remove_libstdc++_la_file.sh
