#!/bin/bash

source host.env
wget --input-file=wget-list-sysv --continue --directory-prefix=$LFS/sources
