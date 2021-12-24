# Chapter 2 Planning for parallel
This is from Chapter 2 of Parallel and High Performance Computing, Robey and Zamora,
Manning Publications, available at http://manning.com

The book may be obtained at
   http://www.manning.com/?a_aid=ParallelComputingRobey

Copyright 2019-2021 Robert Robey, Yuliana Zamora, and Manning Publications
Emails: brobey@earthlink.net, yzamora215@gmail.com

See License.txt for licensing information.

See README.osx, README.linux and soon README.win for MPI and cmake 
installation instructions

See README.ndiff for instructions to install ndiff. A copy of the
ndiff tar file is also included as a backup to getting it from
the ndiff website.
   -- check that the ndiff executable is in the path with 'which ndiff'

Numdiff is an alternative program that performs the same function. It
is at https://www.nongnu.org/numdiff/

Valgrind needs to be installed for the last example.

# Listing1

   Requires CMake, CTest, and ndiff

   Change into the Listing1 directory

   Run the test with

      cd Listing1
      mkdir build
      cd build
      cmake ..
      make
      make test
         or
      ctest
   
   To see the output when the test fails:
   
      ctest --output-on-failure

   If the test does not run properly, try invoking it manually with

      sh mympiapp.ctest
   
   You should get some results like the following.
   
      Running tests...
      Test project /Users/brobey/Programs/RunDiff
          Start 1: mpitest.ctest
      1/1 Test #1: mpitest.ctest ....................   Passed   30.24 sec
   
      100% tests passed, 0 tests failed out of 1
   
      Total Test time (real) =  30.24 sec
   
   This test is based on the sleep function and timers, so it may or may not pass.
   Test results are in Testing/Temporary/*
   
# Listing2

   Requires CMake and CTest

   Change into the Listing2 directory

   Run the test with

      cd Listing2
      mkdir build
      cd build
      cmake ..
      make
      ctest -R commit
         or
      make commit_tests

# Listing3

   Requires Valgrind and a C99 standard C compiler

   Change into the Listing3 directory

   Run the valgrind test with

      cd Listing3
      make
      valgrind --leak-check=full ./test 2
