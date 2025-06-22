import zmq

context = zmq.Context()
socket = context.socket(zmq.SUB)

# Replace with your Trenz board IP
socket.connect("tcp://192.168.7.2:5555")
socket.setsockopt_string(zmq.SUBSCRIBE, "")

print("✅ Subscriber connected. Waiting for messages...")

while True:
    message = socket.recv_string()
    print("📨 Received:", message)
