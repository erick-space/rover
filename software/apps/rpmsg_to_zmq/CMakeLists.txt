cmake_minimum_required(VERSION 3.10)
project(rpmsg_to_zmq)

set(CMAKE_CXX_STANDARD 14)

find_package(PkgConfig REQUIRED)
pkg_check_modules(ZMQ REQUIRED libzmq)
include_directories(${ZMQ_INCLUDE_DIRS})

add_executable(rpmsg_to_zmq src/main.cpp)
target_link_libraries(rpmsg_to_zmq ${ZMQ_LIBRARIES})

install(TARGETS rpmsg_to_zmq DESTINATION bin)
