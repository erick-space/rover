rpmsg_to_zmq/
├── src/
│   └── main.cpp          # C++ app that reads from /dev/rpmsg0 and sends ZMQ
├── include/              # (Optional for future headers)
├── CMakeLists.txt        # For cross-compilation using PetaLinux SDK
└── build.sh              # Automates build with cross-toolchain
