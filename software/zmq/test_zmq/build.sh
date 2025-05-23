#!/bin/bash
set -e

# Set the PetaLinux SDK environment
source /tools/Xilinx/Petalinux/2024.2/sdk/environment-setup-cortexa72-cortexa53-xilinx-linux

# Export cross-compilers (optional, for clarity)
export CC=aarch64-xilinx-linux-gcc
export CXX=aarch64-xilinx-linux-g++

# Set install destination
export APP_INSTALL_DIR=$(pwd)/install/usr

# Create and enter build directory
rm -rf build
mkdir -p build
cd build

# Run CMake
cmake .. \
  -DCMAKE_INSTALL_PREFIX=$APP_INSTALL_DIR \
  -DCMAKE_C_COMPILER=$CC \
  -DCMAKE_CXX_COMPILER=$CXX \
  -DCMAKE_SYSROOT=$SDKTARGETSYSROOT \
  -DCMAKE_FIND_ROOT_PATH=$SDKTARGETSYSROOT \
  -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
  -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
  -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY

# Build and install
make -j$(nproc)
make install
