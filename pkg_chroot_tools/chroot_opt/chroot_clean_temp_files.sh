#!/bin/bash

rm -rvf /usr/share/{info,man,doc}/*
find /usr/{lib,libexec} -name \*.la -delete

