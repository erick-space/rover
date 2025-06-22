cmake_minimum_required(VERSION 3.10)
project(zmq_test)

set(CMAKE_CXX_STANDARD 14)

find_package(PkgConfig REQUIRED)
pkg_check_modules(ZMQ REQUIRED libzmq)
include_directories(${ZMQ_INCLUDE_DIRS})

add_executable(zmq_test zmq_test_sender.cpp)
target_link_libraries(zmq_test ${ZMQ_LIBRARIES})
