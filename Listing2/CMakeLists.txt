cmake_minimum_required (VERSION 3.0)
project (TimeIt)

# Enables CTest functionality in CMake
enable_testing()

add_executable(TimeIt TimeIt.c)

# Add two tests, one with commit in the name
add_test(NAME blur_short_commit WORKING_DIRECTORY ${CMAKE_BINARY_DIRECTORY}
         COMMAND sh ${CMAKE_CURRENT_SOURCE_DIR}/blur_short.ctest)
add_test(NAME blur_long WORKING_DIRECTORY ${CMAKE_BINARY_DIRECTORY}
         COMMAND sh ${CMAKE_CURRENT_SOURCE_DIR}/blur_long.ctest)

# Custom target "commit_tests" to run all tests with commit in the name
add_custom_target(commit_tests COMMAND ctest -R commit DEPENDS TimeIt)

# A custom command, distclean, to remove files that are created
add_custom_target(distclean COMMAND rm -rf CMakeCache.txt CMakeFiles
                  CTestTestfile.cmake Makefile Testing cmake_install.cmake)
