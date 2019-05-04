cmake_minimum_required (VERSION 3.0)
project (TimeIt)

# Enables CTest functionality in CMake
enable_testing()

# CMake has a built-in routine to find most MPI packages 
# Defines MPI_FOUND if found
# MPI_INCLUDE_PATH (being replaced by MPI_<lang>_INCLUDE_PATH)
# MPI_LIBRARIES (being replaced by MPI_<lang>_LIBRARIES)
find_package(MPI)

# Adds build targets of TimeIt and MPITimeIt with source code file(s) TimeIt.c and MPITimeIt.c
add_executable(TimeIt TimeIt.c)

add_executable(MPITimeIt MPITimeIt.c)
# Need an include path to the mpi.h file and to the MPI library
target_include_directories(MPITimeIt PUBLIC ${MPI_INCLUDE_PATH})
target_link_libraries(MPITimeIt ${MPI_LIBRARIES})

# This gets all files with the extension 'ctest' and adds it to the test list for CTest
# The ctest file needs to be executable or explicitly launched with the 'sh' command as below
file(GLOB TESTFILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "*.ctest")
foreach(TESTFILE ${TESTFILES})
     add_test(NAME ${TESTFILE} WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
              COMMAND sh ${CMAKE_CURRENT_SOURCE_DIR}/${TESTFILE})
endforeach()

# A custom command, distclean, to remove files that are created
add_custom_target(distclean COMMAND rm -rf CMakeCache.txt CMakeFiles
                  CTestTestfile.cmake Makefile Testing cmake_install.cmake)
