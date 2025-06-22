#!/bin/bash

# ============================================================================
# Script: build.sh (Cross-compile version for Trenz board)
# Description:
#   Cross-compiles zmq_test_sender.cpp using PetaLinux SDK
# ============================================================================

set -e

# Set up the ARM cross-compile environment
source /tools/Xilinx/Petalinux/2024.2/sdk/environment-setup-cortexa72-cortexa53-xilinx-linux

APP_DIR=$(dirname "$(realpath "$0")")
BUILD_DIR="$APP_DIR/build"
INSTALL_DIR="$APP_DIR/install/usr"

mkdir -p "$BUILD_DIR" "$INSTALL_DIR"
cd "$BUILD_DIR"

cmake .. \
  -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
  -DCMAKE_C_COMPILER=aarch64-xilinx-linux-gcc \
  -DCMAKE_CXX_COMPILER=aarch64-xilinx-linux-g++ \
  -DCMAKE_SYSROOT=$SDKTARGETSYSROOT \
  -DCMAKE_FIND_ROOT_PATH=$SDKTARGETSYSROOT \
  -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
  -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
  -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY

make -j$(nproc)
make install

echo "✅ Cross-compiled for Trenz. Binary: $BUILD_DIR/zmq_test"

