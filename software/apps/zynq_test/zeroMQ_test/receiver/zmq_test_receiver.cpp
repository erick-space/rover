// ============================================================================
// File: zmq_test_receiver.cpp
// Description:
//   Test ZMQ subscriber application for debugging communication.
//   Connects to tcp://<target_ip>:5555 and prints received messages.
// ============================================================================

#include <zmq.hpp>
#include <iostream>

int main() {
    zmq::context_t context(1);
    zmq::socket_t subscriber(context, ZMQ_SUB);
    subscriber.connect("tcp://192.168.7.2:5555"); // Replace if needed
    subscriber.setsockopt(ZMQ_SUBSCRIBE, "", 0);

    std::cout << "🔵 Subscriber started. Waiting for messages...\n";

    while (true) {
        zmq::message_t msg;
        subscriber.recv(msg);
        std::string text(static_cast<char*>(msg.data()), msg.size());
        std::cout << "📨 Received: " << text << std::endl;
    }
    return 0;
}

