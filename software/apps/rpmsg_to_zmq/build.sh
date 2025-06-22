// build.sh
#!/bin/bash
set -e

source /tools/Xilinx/Petalinux/2024.2/sdk/environment-setup-cortexa72-cortexa53-xilinx-linux
export CC=aarch64-xilinx-linux-gcc
export CXX=aarch64-xilinx-linux-g++

APP_ROOT=$(pwd)
BUILD_DIR=$APP_ROOT/build
INSTALL_DIR=$APP_ROOT/install/usr

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR $INSTALL_DIR
cd $BUILD_DIR

cmake .. \
  -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR \
  -DCMAKE_C_COMPILER=$CC \
  -DCMAKE_CXX_COMPILER=$CXX \
  -DCMAKE_SYSROOT=$SDKTARGETSYSROOT \
  -DCMAKE_FIND_ROOT_PATH=$SDKTARGETSYSROOT \
  -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
  -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
  -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY

make -j$(nproc)
make install
