cmake_minimum_required(VERSION 3.10)
project(sensor_publisher)

set(CMAKE_CXX_STANDARD 14)

find_package(PkgConfig REQUIRED)
pkg_check_modules(ZMQ REQUIRED libzmq)

include_directories(${ZMQ_INCLUDE_DIRS})

add_executable(sensor_publisher src/main.cpp)
target_link_libraries(sensor_publisher ${ZMQ_LIBRARIES})

install(TARGETS sensor_publisher DESTINATION bin)
