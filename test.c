#include <stdio.h>
#include <time.h>
 
// A function that terminates when enter key is pressed
void fun()
{
    printf("fun() starts \n");
    printf("Press enter to stop fun \n");
    while(1)
    {
        if (getchar())
            break;
    }
    printf("fun() ends \n");
}
 
// The main program calls fun() and measures time taken by fun()
int main()
{
    // Calculate the time taken by fun()
    /*clock_t t;
    t = clock();
    fun();
    t = clock() - t;
    double time_taken = ((double)t)/CLOCKS_PER_SEC; // in seconds*/
    
    clock_t begin = clock();

    /* here, do your time-consuming job */
    fun();

    clock_t end = clock();
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
 
    printf("fun() took %f seconds to execute \n", time_spent);
    return 0;
}
