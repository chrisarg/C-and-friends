// passing multidimensional arrays to functions

#include <stdio.h>
#include <threads.h>
#include <stdatomic.h>
#include <math.h>
#include <tgmath.h>

#define COUNT 1000000L
#define USEDDOUBLE
#ifdef USEDDOUBLE
    #define TYPE_ARG long double
    #define FMT "Lf"
    #define MOD(x,y) fmodl((x),(y))
#else
    #define TYPE_ARG long 
    #define FMT "ld"
    #define MOD(x,y) (x) % (y)
#endif

TYPE_ARG counter1 = 0L;
TYPE_ARG counter2 = 0L;

void incCounter() {
    printf("Increase entry\n");
    for(long i=0; i < COUNT; i++) {
        counter1+=sin(i);
        if (MOD(i,100000) == 0)
            printf("\ti = %10.5ld, counter1 = %6.6" FMT "\n",i, counter1);
    }

    printf("Increase exit\n");
}   
void decCounter() {
    printf("Decrease entry\n");
    for(long i=0; i < COUNT; i++){
        counter2-=sin(i);
        if (MOD(i,100000) == 0)
            printf("\t\ti = %10.5ld, counter2 = %6.6" FMT "\n",i, counter2);
    }
    printf("Decrease exit\n");
}



int main() {
    thrd_t t1, t2;
    printf("Let the fun begin ""\n");
    clock_t start = clock();
    if(thrd_create(&t1, (thrd_start_t)incCounter, NULL) != thrd_success
        || thrd_create(&t2, (thrd_start_t)decCounter, NULL) != thrd_success) {
        printf("Error creating threads\n");
        return -1;
    }
    
    thrd_join(t1,NULL);
    printf("in between\n");
    thrd_join(t2,NULL);
    //atomic_thread_fence(memory_order_release);
    printf("counter1 = %" FMT ",\t counter2 = %" FMT "\n", counter1,counter2);
    printf("time = %f\n", (double)(clock() - start)/CLOCKS_PER_SEC);

    //alternative way to create threads
    printf("\n\n Alternative way to create threads\n\n");
    start = clock();
    if(thrd_create(&t1, (thrd_start_t)incCounter, NULL) != thrd_success) {
        printf("Error creating threads\n");
        return -1;
    }
    thrd_join(t1,NULL);
     if(thrd_create(&t2, (thrd_start_t)decCounter, NULL) != thrd_success) {
        printf("Error creating threads\n");
        return -1;
    }   
    printf("in between\n");
    thrd_join(t2,NULL);
    //atomic_thread_fence(memory_order_release);
    printf("counter1 = %" FMT ",\t counter2 = %" FMT "\n", counter1,counter2);
    printf("time = %f\n", (double)(clock() - start)/CLOCKS_PER_SEC);

    printf("\n\n Serial execution\n\n");
    start = clock();
    incCounter();
    printf("in between\n");
    decCounter();
    printf("counter1 = %" FMT ",\t counter2 = %" FMT "\n", counter1,counter2);
    printf("time = %f\n", (double)(clock() - start)/CLOCKS_PER_SEC);
    return 0;
}