cmake_minimum_required(VERSION 3.10)
project(test_zmq)

set(CMAKE_CXX_STANDARD 14)

# Find ZeroMQ
find_package(PkgConfig REQUIRED)
pkg_check_modules(ZMQ REQUIRED libzmq)
include_directories(${ZMQ_INCLUDE_DIRS})

add_executable(test_zmq src/test_zmq.cpp)
target_link_libraries(test_zmq ${ZMQ_LIBRARIES})

# Install rule
install(TARGETS test_zmq DESTINATION bin)
