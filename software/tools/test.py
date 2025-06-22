import zmq

context = zmq.Context()
socket = context.socket(zmq.SUB)
socket.connect("tcp://192.168.7.2:5555")
socket.setsockopt_string(zmq.SUBSCRIBE, "")

print("✅ Subscriber connected. Waiting for messages...")

while True:
    try:
        msg = socket.recv_string(flags=zmq.NOBLOCK)
        print("📨 Received:", msg)
    except zmq.Again:
        pass
