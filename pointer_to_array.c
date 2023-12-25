// understand passing a pointer to an entire array

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

void print_pointer_to_array(int **a, size_t size) {
    int *b = *a;
    for(size_t i=0; i < size; i++)
        printf("Value of array at pos %lu is %d or  %d, or even %d\n",i,(*a)[i],*(*a+i),b[i]);
}
int main() {
    size_t len = 10;
    int * a = calloc(len,sizeof(int));
    for(size_t i=0;i<len;i++)
        a[i]=i;
    print_pointer_to_array(&a,len);
    return 0;

}