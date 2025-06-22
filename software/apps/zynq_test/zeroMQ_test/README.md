# ZeroMQ Communication Debug Test

Minimal C++ test applications used to verify and debug ZeroMQ communication between the Trenz board (APU) and the host PC.

---

## 📁 Location
All test source files, build scripts, and this note are stored in:
```
rover/software/apps/zynq_test/zeroMQ_test
```

---

## 🔧 Components

### `zmq_test_sender.cpp`
- 📍 Location: `sender/`
- 🔄 Publishes messages on `tcp://*:5555`
- 🛠️ Cross-compiled for the Trenz APU

### `zmq_test_receiver.cpp`
- 📍 Location: `receiver/`
- 📡 Subscribes to messages from `tcp://192.168.7.2:5555`
- 🛠️ Built on the host PC

---

## 🛠 Build Instructions

### Host Build (Receiver)
```bash
cd zeroMQ_test/receiver
chmod +x build.sh
./build.sh
./build/zmq_test
```

### Cross-Build for Trenz (Sender)
```bash
cd zeroMQ_test/sender
source /tools/Xilinx/Petalinux/2024.2/sdk/environment-setup-cortexa72-cortexa53-xilinx-linux
chmod +x build.sh
./build.sh
scp build/zmq_test root@192.168.7.2:/temp/
```

### Run on Trenz Board
```bash
ssh root@192.168.7.2
/temp/zmq_test
```

---

## ✅ Expected Output

**Sender Output (on Trenz):**
```
🟢 Sending: test_message: 0
🟢 Sending: test_message: 1
...
```

**Receiver Output (on Host PC):**
```
📨 Received: test_message: 0
📨 Received: test_message: 1
...
```

---

## 🧹 Notes
These test tools are for debugging purposes only and not part of production. They are useful for validating:
- RPMsg-to-ZMQ pipeline
- ZMQ socket connectivity
- Network reachability between board and host

Safe to retain in `zeroMQ_test/` for future diagnostics.

