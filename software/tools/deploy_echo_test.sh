#!/bin/bash

# ============================================================================
# Script: deploy_echo_test.sh
# Description:
#   Transfers the openamp_echo_test.elf to the Trenz board, ensures
#   /lib/firmware exists, starts the remote processor using remoteproc0,
#   and verifies that the echo test is running correctly.
#
# Prerequisite:
#   Create a FreeRTOS RPU Application with OpenAMP in vitis
#     Click on Examples icon in vitis sidebar
#     Click on OpenAMP echo-test
#     Click Create Application Component from Template
#     Build app
# ============================================================================

# === Configuration ===
BOARD_USER=root
BOARD_IP=192.168.7.2
ELF_PATH=../vitis/openamp_echo_test/build/openamp_echo_test.elf
REMOTE_ELF_NAME=openamp_echo_test.elf

# === Step 1: Copy the ELF to the board ===
echo "Copying $ELF_PATH to /tmp on the board..."
scp "$ELF_PATH" ${BOARD_USER}@${BOARD_IP}:/tmp/

# === Step 2: SSH into board and deploy ===
ssh ${BOARD_USER}@${BOARD_IP} << EOF
  echo "Ensuring /lib/firmware exists..."
  mkdir -p /lib/firmware

  echo "Moving ELF into place..."
  mv /tmp/$REMOTE_ELF_NAME /lib/firmware/

  echo "Restarting remote processor..."
  if [ -e /sys/class/remoteproc/remoteproc0/state ]; then
    echo stop > /sys/class/remoteproc/remoteproc0/state
  fi

  echo $REMOTE_ELF_NAME > /sys/class/remoteproc/remoteproc0/firmware
  echo start > /sys/class/remoteproc/remoteproc0/state

  echo "Checking remoteproc state..."
  cat /sys/class/remoteproc/remoteproc0/state

  echo "Looking for RPMsg device..."
  if ls /dev/rpmsg* 1> /dev/null 2>&1; then
    echo "✅ RPMsg device found:"
    ls /dev/rpmsg*
    echo "Sending test message to RPU..."
    echo "ping from APU" > /dev/rpmsg0
    echo "Reading response from RPU..."
    cat /dev/rpmsg0
  else
    echo "❌ RPMsg device not found. Check OpenAMP config and firmware."
  fi
EOF
