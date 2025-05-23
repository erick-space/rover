#!/bin/bash

# ============================================================================
# Script: deploy_services.sh
# Description:
#   This script deploys sensor_publisher and data_logger applications to a
#   PetaLinux-based Trenz board. It performs the following tasks:
#     - Transfers compiled binaries to the board
#     - Creates and installs systemd service files
#     - Enables and starts the services automatically at boot
#     - Cleans up temporary files
# ============================================================================

# === Configuration ===
BOARD_USER=root
BOARD_IP=192.168.7.2

BINARIES_DIR=$(pwd)
REMOTE_BIN_DIR=/usr/bin

# === Service files ===
cat <<EOF > sensor_publisher.service
[Unit]
Description=Sensor Publisher
After=network.target

[Service]
ExecStart=${REMOTE_BIN_DIR}/sensor_publisher
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

cat <<EOF > data_logger.service
[Unit]
Description=Data Logger
After=network.target

[Service]
ExecStart=${REMOTE_BIN_DIR}/data_logger
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# === Transfer binaries ===
echo "Copying binaries to the board..."
scp $BINARIES_DIR/sensor_publisher/build/sensor_publisher \
    $BINARIES_DIR/data_logger/build/data_logger \
    ${BOARD_USER}@${BOARD_IP}:/tmp/

# === Install and register services ===
ssh ${BOARD_USER}@${BOARD_IP} << EOF
  sudo mv /tmp/sensor_publisher $REMOTE_BIN_DIR/
  sudo mv /tmp/data_logger $REMOTE_BIN_DIR/
  sudo chmod +x ${REMOTE_BIN_DIR}/sensor_publisher
  sudo chmod +x ${REMOTE_BIN_DIR}/data_logger

  echo "Installing services..."
  sudo mv /tmp/sensor_publisher.service /etc/systemd/system/
  sudo mv /tmp/data_logger.service /etc/systemd/system/

  sudo systemctl daemon-reload
  sudo systemctl enable sensor_publisher
  sudo systemctl enable data_logger
  sudo systemctl restart sensor_publisher
  sudo systemctl restart data_logger
EOF

# === Transfer service files ===
echo "Copying .service files to the board..."
scp sensor_publisher.service data_logger.service \
    ${BOARD_USER}@${BOARD_IP}:/tmp/

# === Cleanup ===
rm sensor_publisher.service data_logger.service

echo "✅ Deployment complete. Both services are now running."

