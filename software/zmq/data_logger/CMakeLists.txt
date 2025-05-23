cmake_minimum_required(VERSION 3.10)
project(data_logger)

set(CMAKE_CXX_STANDARD 14)

find_package(PkgConfig REQUIRED)
pkg_check_modules(ZMQ REQUIRED libzmq)

include_directories(${ZMQ_INCLUDE_DIRS})

add_executable(data_logger src/main.cpp)
target_link_libraries(data_logger ${ZMQ_LIBRARIES})

install(TARGETS data_logger DESTINATION bin)
