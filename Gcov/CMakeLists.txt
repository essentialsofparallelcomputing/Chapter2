cmake_minimum_required (VERSION 3.0)
project (stream_triad)

set (CMAKE_C_STANDARD 99)

# Set OpenMP flags for a few compilers
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g")

find_package(OpenMP)

# Adds build target of stream_triad with source code files
add_executable(stream_triad stream_triad.c timer.c timer.h)
set_target_properties(stream_triad PROPERTIES COMPILE_FLAGS "-fprofile-arcs -ftest-coverage")
set_target_properties(stream_triad PROPERTIES LINK_FLAGS "-fprofile-arcs -ftest-coverage")

# Cleanup
add_custom_target(distclean COMMAND rm -rf CMakeCache.txt CMakeFiles
                  Makefile cmake_install.cmake stream_triad.dSYM ipo_out.optrpt)
