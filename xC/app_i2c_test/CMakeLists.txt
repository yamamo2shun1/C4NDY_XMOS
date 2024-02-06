cmake_minimum_required(VERSION 3.21)
include($ENV{XMOS_CMAKE_PATH}/xcommon.cmake)
project(i2c_test)

set(APP_HW_TARGET XU316-1024-QF60B-C32)

set(APP_DEPENDENT_MODULES "lib_i2c")

set(XMOS_SANDBOX_DIR ${CMAKE_CURRENT_LIST_DIR}/..)

XMOS_REGISTER_APP()
