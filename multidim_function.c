// passing multidimensional arrays to functions

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

void display2Darray_as_pointer(int *a, size_t rows, size_t cols) {
    for(size_t i=0; i < rows; i++) {
        for(size_t j=0; j < cols; j++)
            printf("%d \t", *(a + i*cols + j));
        printf("\n");
    }
    printf("------------------\n");
    for(size_t i=0; i < rows; i++) {
    for(size_t j=0; j < cols; j++)
        printf("%d \t", (a+i)[j]);
    printf("\n");
}
}
int main() {
    size_t nrow = 10;
    size_t ncol = 5;
    int a[nrow][ncol];
    for(size_t i=0; i < nrow; i++)
        for(size_t j=0; j < ncol; j++)
            a[i][j] = i*ncol + j;
    display2Darray_as_pointer(&a[0][0],nrow,ncol);
    return 0;

}