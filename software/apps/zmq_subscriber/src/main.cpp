// ============================================================================
// File: main.cpp
// Description:
//   C++ ZeroMQ subscriber application.
//   Connects to a ZeroMQ PUB socket (e.g., from the Trenz board),
//   subscribes to all topics, and prints received messages to stdout.
//   Used to verify receipt of RPMsg-forwarded data from the board.
// ============================================================================

#include <zmq.hpp>
#include <iostream>

int main() {
    // Create a ZeroMQ context with a single I/O thread
    zmq::context_t context(1);

    // Create a SUB (subscriber) socket
    zmq::socket_t subscriber(context, ZMQ_SUB);

    // Connect to the Trenz board's publisher at TCP port 5555
    subscriber.connect("tcp://192.168.7.2:5555");

    // Subscribe to all incoming messages (empty topic = no filter)
    subscriber.setsockopt(ZMQ_SUBSCRIBE, "", 0);

    std::cout << "✅ ZMQ subscriber connected. Listening for messages...\n";

    while (true) {
        // Prepare to receive a message
        zmq::message_t msg;

        // Blocking wait for a message from the publisher
        subscriber.recv(&msg);

        // Convert raw data to a C++ string for easy printing
        std::string data(static_cast<char*>(msg.data()), msg.size());

        // Display the received message
        std::cout << "📨 Received: " << data << std::endl;
    }

    return 0;
}

