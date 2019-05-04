#include <stdlib.h>
 
int main(int argc, char *argv[]){
   int ipos, ival; 
   int *iarray = (int *) malloc(10*sizeof(int));
   if (argc == 2) ival = atoi(argv[1]);
   for (int i = 0; i<=10; i++){ iarray[i] = ipos; }
   for (int i = 0; i<=10; i++){ 
      if (ival == iarray[i]) ipos = i;
   }  
}  
