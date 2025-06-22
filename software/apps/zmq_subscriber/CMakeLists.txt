cmake_minimum_required(VERSION 3.10)
project(zmq_subscriber)

set(CMAKE_CXX_STANDARD 14)

find_package(PkgConfig REQUIRED)
pkg_check_modules(ZMQ REQUIRED libzmq)
include_directories(${ZMQ_INCLUDE_DIRS})

add_executable(zmq_subscriber src/main.cpp)
target_link_libraries(zmq_subscriber ${ZMQ_LIBRARIES})
