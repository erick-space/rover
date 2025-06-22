#!/bin/bash

# ============================================================================
# Script: build.sh
# Description:
#   Builds the C++ ZMQ subscriber application for host PC.
#   Must be located in the same directory as CMakeLists.txt.
# ============================================================================

set -e

APP_DIR=$(dirname "$(realpath "$0")")
BUILD_DIR=$APP_DIR/build

mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

cmake ..
make -j$(nproc)

echo "✅ Build complete. Run: $BUILD_DIR/zmq_subscriber"

