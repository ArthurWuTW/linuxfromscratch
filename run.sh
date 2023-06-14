#!/bin/bash

echo "Run version-check.sh..."
./version-check.sh

echo "Install host pkg..."
./install_host_pkg.sh

echo "Run version-check.sh..."
./version-check.sh