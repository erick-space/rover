#!/bin/bash

# ============================================================================
# Script: deploy_zmq_libs.sh
# Description:
#   Deploys required shared libraries to the Trenz board to support
#   running the rpmsg_to_zmq application.
#   This includes:
#     - libzmq
#     - libstdc++
#     - libgcc_s (added)
# ============================================================================

# === Configuration ===
BOARD_IP=192.168.7.2
BOARD_USER=root
REMOTE_LIB_DIR=/usr/lib

# === SDK sysroot path (updated to match system) ===
SYSROOT=/tools/Xilinx/Petalinux/2024.2/sdk/sysroots/cortexa72-cortexa53-xilinx-linux/usr/lib

# === Library list to deploy ===
LIBS=(
  "$SYSROOT/libzmq.so.5"
  "$SYSROOT/libzmq.so"
  "$SYSROOT/libstdc++.so.6"
  "$SYSROOT/libstdc++.so"
  "$SYSROOT/libgcc_s.so.1"
)

# === Deploy libraries ===
echo "Deploying required shared libraries to Trenz board..."
for lib in "${LIBS[@]}"; do
  if [ -f "$lib" ]; then
    echo "Copying $(basename "$lib") to $REMOTE_LIB_DIR"
    scp "$lib" ${BOARD_USER}@${BOARD_IP}:$REMOTE_LIB_DIR/
  else
    echo "❌ Library not found: $lib"
  fi

done

# === Reminder ===
echo -e "\n✅ Libraries copied. On the board, run:"
echo "  export LD_LIBRARY_PATH=/usr/lib"
echo "  /usr/bin/rpmsg_to_zmq"

