#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "INLINE.h"

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

SV* alloc_with_malloc(size_t length) {
    // Allocate memory for the array
    char* array = (char*)malloc(length * sizeof(char));
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    return newSVuv(PTR2UV(array));
}

SV* alloc_with_malloc_and_set(size_t length, short initial_value) {
    // Allocate memory for the array
    char* array = (char*)malloc(length * sizeof(char));
    char initial_value_byte = (char)initial_value;
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    // Initialize each element with the initial_value
    memset(array, initial_value_byte, length);
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_calloc(size_t length) {
    // Allocate memory for the array
    char* array = (char *)calloc(length ,sizeof(char));
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_calloc_and_set(size_t length, short initial_value) {
    // Allocate memory for the array
    char* array = (char *)calloc(length ,sizeof(char));
    char initial_value_byte = (char)initial_value;
    if (array == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    // Initialize each element with the initial_value
    memset(array, initial_value_byte, length);
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_Newx(size_t length) {
    char* array ;
    Newx(array, length, char);
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_Newxz(size_t length) {
    char* array ;
    Newxz(array, length, char);
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_Newx_and_set(size_t length, short initial_value) {
    char* array ;
    Newx(array, length, char);
    char initial_value_byte = (char)initial_value;
    memset(array, initial_value_byte, length);
    return newSVuv(PTR2UV(array));
}

SV* alloc_with_Newxz_and_set(size_t length, short initial_value) {
    char* array ;
    Newxz(array, length, char);
    char initial_value_byte = (char)initial_value;
    memset(array, initial_value_byte, length);
    return newSVuv(PTR2UV(array));
}

MODULE = IBpKwktryS_33e2  PACKAGE = main  

PROTOTYPES: DISABLE


SV *
alloc_with_malloc (length)
	size_t	length

SV *
alloc_with_malloc_and_set (length, initial_value)
	size_t	length
	short	initial_value

SV *
alloc_with_calloc (length)
	size_t	length

SV *
alloc_with_calloc_and_set (length, initial_value)
	size_t	length
	short	initial_value

SV *
alloc_with_Newx (length)
	size_t	length

SV *
alloc_with_Newxz (length)
	size_t	length

SV *
alloc_with_Newx_and_set (length, initial_value)
	size_t	length
	short	initial_value

SV *
alloc_with_Newxz_and_set (length, initial_value)
	size_t	length
	short	initial_value

