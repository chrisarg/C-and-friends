// play with the sizeof operator, differences between arrays and pointers

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

void show_diff(int a[],int * b) {
    printf("sizeof(a) = %lu, sizeof(b) = %lu\n", sizeof(a)/sizeof(int), sizeof(b));
}
int main() {
    int a[10];
    int * b = a;
    printf("sizeof(a) = %lu, sizeof(b) = %lu\n", sizeof(a)/sizeof(int), sizeof(b));
    show_diff(a,b);
    return 0;

}