#!/bin/bash

export FILE=wheel-0.38.4
export FILE_XZ=${FILE}.tar.gz
export SRC_DIR=/sources
export CURR_USER=$(whoami)

if [ ! -d ${SRC_DIR}/${FILE} ];
then
  tar xvf ${SRC_DIR}/${FILE_XZ} -C ${SRC_DIR}/
fi

cd $SRC_DIR/$FILE

PYTHONPATH=src pip3 wheel -w dist --no-build-isolation --no-deps $PWD
pip3 install --no-index --find-links=dist wheel
