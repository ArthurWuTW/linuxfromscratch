#!/bin/bash


# Run version-check.sh...
# bash, version 4.4.20(1)-release
# /bin/sh -> /usr/bin/bash
# Binutils: version 2.30-119.el8
# ./version-check.sh: line 18: bison: command not found
# yacc not found
# Coreutils:  8.30
# diff (GNU diffutils) 3.6
# find (GNU findutils) 4.6.0
# GNU Awk 4.2.1, API: 2.0 (GNU MPFR 3.1.6-p2, GNU MP 6.1.2)
# /usr/bin/awk -> /usr/bin/gawk
# ./version-check.sh: line 41: gcc: command not found
# ./version-check.sh: line 42: g++: command not found
# grep (GNU grep) 3.1
# gzip 1.9
# Linux version 4.18.0-477.13.1.el8_8.x86_64 (mockbuild@iad1-prod-build001.bld.equ.rockylinux.org) (gcc version 8.5.0 20210514 (Red Hat 8.5.0-18) (GCC)) #1 SMP Tue May 30 22:15:39 UTC 2023
# ./version-check.sh: line 47: m4: command not found
# ./version-check.sh: line 48: make: command not found
# ./version-check.sh: line 49: patch: command not found
# Perl version='5.26.3';
# Python 3.6.8
# sed (GNU sed) 4.5
# tar (GNU tar) 1.30
# ./version-check.sh: line 54: makeinfo: command not found
# xz (XZ Utils) 5.2.4
# ./version-check.sh: line 57: g++: command not found
# g++ compilation failed

yum update -y
yum install -y bison byacc gcc gcc-c++ m4 make patch
dnf install -y dnf-plugins-core
dnf install -y epel-release
dnf config-manager --set-enabled powertools
dnf update -y
dnf install -y texinfo-tex