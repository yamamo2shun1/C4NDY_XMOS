cmake_minimum_required(VERSION 3.21)
include($ENV{XMOS_CMAKE_PATH}/xcommon.cmake)
project(boot_from_flash)

set(APP_HW_TARGET C4NDY-XMOS)
set(APP_COMPILER_FLAGS -Wall -report -lquadflash -g)

XMOS_REGISTER_APP()
