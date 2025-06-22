#!/bin/bash

# ============================================================================
# Script: build.sh
# Description:
#   Simple build script for ZeroMQ test sender or receiver.
#   Must be placed in the same directory as CMakeLists.txt and source file.
#   Automatically builds the C++ app using CMake and Make.
# ============================================================================

set -e  # Stop on any error

# Get the path of the script and use it as the app root
APP_DIR=$(dirname "$(realpath "$0")")
BUILD_DIR="$APP_DIR/build"

# Create a clean build directory
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Run CMake in the parent folder to configure the build
cmake ..

# Compile the project using all CPU cores
make -j$(nproc)

echo "✅ Build complete. Run: $BUILD_DIR/zmq_test"

