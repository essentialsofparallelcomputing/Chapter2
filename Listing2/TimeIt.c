#include <unistd.h>
#include <stdio.h>
#include <time.h>
int main(int argc, char *argv[]){
   struct timespec tstart, tstop, tresult;
// Start timer, call sleep and stop timer
   clock_gettime(CLOCK_MONOTONIC, &tstart);
   sleep(30);
   clock_gettime(CLOCK_MONOTONIC, &tstop);
// Timer has two values for resolution and prevent overflows
   tresult.tv_sec = tstop.tv_sec - tstart.tv_sec;
   tresult.tv_nsec = tstop.tv_nsec - tstart.tv_nsec;
// Print calculated time from timers
   printf("Elapsed time is %f secs\n", (double)tresult.tv_sec +
      (double)tresult.tv_nsec*1.0e-9);
}

