#include <unistd.h>
#include <stdio.h>
#include <sys/time.h>
int main(int argc, char *argv[]){
   struct timeval tstart, tstop, tresult;
// Start timer, call sleep and stop timer
   gettimeofday(&tstart, NULL);
   sleep(30);
   gettimeofday(&tstop, NULL);
// Timer has two values for resolution and prevent overflows
   tresult.tv_sec = tstop.tv_sec - tstart.tv_sec;
   tresult.tv_usec = tstop.tv_usec - tstart.tv_usec;
// Print calculated time from timers
   printf("Elapsed time is %f secs\n", (double)tresult.tv_sec +
      (double)tresult.tv_usec*1.0e-6);
}

