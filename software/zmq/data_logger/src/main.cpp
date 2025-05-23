// main.cpp
#include <zmq.h>
#include <iostream>
#include <fstream>
#include <string>

int main() {
    void* context = zmq_ctx_new();
    void* subscriber = zmq_socket(context, ZMQ_SUB);

    if (zmq_connect(subscriber, "tcp://localhost:5555") != 0) {
        std::cerr << "Failed to connect to publisher." << std::endl;
        return 1;
    }

    zmq_setsockopt(subscriber, ZMQ_SUBSCRIBE, "", 0); // Subscribe to all messages
    std::ofstream logfile("sensor_log.txt");

    std::cout << "Data logger started, writing to sensor_log.txt..." << std::endl;

    while (true) {
        char buffer[256];
        int bytes = zmq_recv(subscriber, buffer, sizeof(buffer) - 1, 0);
        if (bytes > 0) {
            buffer[bytes] = '\0';
            std::string msg(buffer);
            std::cout << "Logged: " << msg << std::endl;
            logfile << msg << std::endl;
        }
    }

    zmq_close(subscriber);
    zmq_ctx_destroy(context);
    logfile.close();
    return 0;
}
