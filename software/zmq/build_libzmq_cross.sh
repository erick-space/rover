#!/bin/bash

# Exit on error
set -e

# === 1. Source the PetaLinux SDK environment ===
source /tools/Xilinx/Petalinux/2024.2/sdk/environment-setup-cortexa72-cortexa53-xilinx-linux

# === 2. Export compiler paths ===
export CC=aarch64-xilinx-linux-gcc
export CXX=aarch64-xilinx-linux-g++

# === 3. Define directories ===
#eZMQ_SRC_DIR to an absolute path based on the location of the script, 
#making it safe no matter where you run the script fr
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export ZMQ_SRC_DIR="$SCRIPT_DIR/libzmq"
export ZMQ_BUILD_DIR=$ZMQ_SRC_DIR/build
export ZMQ_INSTALL_DIR=$ZMQ_SRC_DIR/sysroot-stage/usr

# === 4. Clean and set up build directory ===
rm -rf "$ZMQ_BUILD_DIR"
mkdir -p "$ZMQ_BUILD_DIR"
cd "$ZMQ_BUILD_DIR"

# === 5. Configure with CMake ===
cmake "$ZMQ_SRC_DIR" \
  -DCMAKE_INSTALL_PREFIX="$ZMQ_INSTALL_DIR" \
  -DCMAKE_C_COMPILER="$CC" \
  -DCMAKE_CXX_COMPILER="$CXX" \
  -DCMAKE_SYSROOT="$SDKTARGETSYSROOT" \
  -DCMAKE_FIND_ROOT_PATH="$SDKTARGETSYSROOT" \
  -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
  -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
  -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
  -DWITH_PERF_TOOL=OFF \
  -DWITH_LIBBSD=OFF

# === 6. Build and install ===
make -j$(nproc)
make install
