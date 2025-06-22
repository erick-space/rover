#!/bin/bash

# === Configuration ===
BOARD_IP=192.168.7.2     
BOARD_USER=root
APP_NAME=test_zmq
LOCAL_APP_PATH=$(pwd)/test_zmq/install/usr/bin/$APP_NAME
REMOTE_APP_PATH=/tmp/$APP_NAME

# === Deploy ===
echo "Deploying $APP_NAME to $BOARD_IP..."

# Transfer the app
scp $LOCAL_APP_PATH ${BOARD_USER}@${BOARD_IP}:$REMOTE_APP_PATH

if [ $? -ne 0 ]; then
  echo "❌ Failed to copy binary to the board."
  exit 1
fi

# Run the app remotely
echo "✅ Binary copied. Running the app on Trenz board..."

ssh ${BOARD_USER}@${BOARD_IP} << EOF
chmod +x $REMOTE_APP_PATH
$REMOTE_APP_PATH
EOF
