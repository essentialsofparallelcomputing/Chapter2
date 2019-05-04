#include <unistd.h>
#include <stdio.h>
#include <mpi.h>
int main(int argc, char *argv[]){
   int mype;
// Initialize MPI and get processor rank
   MPI_Init(&argc, &argv);
   MPI_Comm_rank(MPI_COMM_WORLD, &mype);
   double t1, t2;
// Start timer, call sleep and stop timer
   t1 = MPI_Wtime();
   sleep(10);
   t2 = MPI_Wtime();
// Print timing output from first processor
   if (mype == 0) printf( "Elapsed time is %f secs\n", t2 - t1 );
// Shutdown MPI
   MPI_Finalize();
}

