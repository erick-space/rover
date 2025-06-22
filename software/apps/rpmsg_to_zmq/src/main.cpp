#include <zmq.h>
#include <fcntl.h>
#include <unistd.h>
#include <iostream>

int main() {
    int fd = open("/dev/rpmsg0", O_RDONLY);
    if (fd < 0) {
        std::cerr << "❌ Failed to open /dev/rpmsg0\n";
        return 1;
    }

    void* context = zmq_ctx_new();
    void* publisher = zmq_socket(context, ZMQ_PUB);
    if (zmq_bind(publisher, "tcp://*:5555") != 0) {
        std::cerr << "❌ Failed to bind ZMQ PUB socket\n";
        return 1;
    }

    std::cout << "📡 Forwarding RPMsg data on tcp://*:5555\n";

    char buffer[128];
    while (true) {
        int n = read(fd, buffer, sizeof(buffer) - 1);
        if (n > 0) {
            buffer[n] = '\0';
            std::cout << "📨 RPU: " << buffer << std::endl;
            zmq_send(publisher, buffer, n, 0);
        }
    }

    close(fd);
    zmq_close(publisher);
    zmq_ctx_destroy(context);
    return 0;
}
