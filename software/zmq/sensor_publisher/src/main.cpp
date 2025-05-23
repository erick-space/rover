// main.cpp
#include <zmq.h>
#include <iostream>
#include <string>
#include <thread>
#include <chrono>

int main() {
    void* context = zmq_ctx_new();
    void* publisher = zmq_socket(context, ZMQ_PUB);

    if (zmq_bind(publisher, "tcp://*:5555") != 0) {
        std::cerr << "Failed to bind ZMQ socket." << std::endl;
        return 1;
    }

    std::cout << "Sensor publisher started on tcp://*:5555..." << std::endl;

    int count = 0;
    while (true) {
        std::string message = "imu_data: " + std::to_string(count++);
        zmq_send(publisher, message.c_str(), message.size(), 0);
        std::this_thread::sleep_for(std::chrono::milliseconds(500));
    }

    zmq_close(publisher);
    zmq_ctx_destroy(context);
    return 0;
}
