// ============================================================================
// File: zmq_test_sender.cpp
// Description:
//   Test ZMQ publisher for debugging ZeroMQ communication.
//   Publishes messages to tcp://*:5555 every second.
// ============================================================================

#include <zmq.hpp>
#include <iostream>
#include <thread>
#include <chrono>

int main() {
    zmq::context_t context(1);
    zmq::socket_t publisher(context, ZMQ_PUB);
    publisher.bind("tcp://*:5555");

    int counter = 0;
    while (true) {
        std::string message = "test_message: " + std::to_string(counter++);
        std::cout << "🟢 Sending: " << message << std::endl;
        publisher.send(zmq::buffer(message), zmq::send_flags::none);
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }

    return 0;
}

