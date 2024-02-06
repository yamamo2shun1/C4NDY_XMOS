cmake_minimum_required(VERSION 3.21)
include($ENV{XMOS_CMAKE_PATH}/xcommon.cmake)
project(hello_world)

set(APP_HW_TARGET XU316-1024-QF60B-C32)

XMOS_REGISTER_APP()
