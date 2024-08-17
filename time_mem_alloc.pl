#!/home/chrisarg/perl5/perlbrew/perls/current/bin/perl
use v5.38;
use Inline (
    C         => 'DATA',
    cc        => 'g++',
    ld        => 'g++',
    inc       => q{},      # replace q{} with anything else you need
    ccflagsex => q{},      # replace q{} with anything else you need
    lddlflags => join(
        q{ },
        $Config::Config{lddlflags},
        q{ },              # replace q{ } with anything else you need
    ),
    libs => join(
        q{ },
        $Config::Config{libs},
        q{ },              # replace q{ } with anything else you need
    ),
    myextlib => ''
);

use Benchmark::Dumb qw(cmpthese);
use Convert::Scalar qw(grow);
use Getopt::Long;
my ($buffer_size, $init_value, $iterations);
GetOptions(
    'buffer_size=i' => \$buffer_size,
    'init_value=s'  => \$init_value,
    'iterations=i'  => \$iterations,
) or die "Usage: $0 --buffer_size <size> --init_value <value> --iterations <count>\n";
my $init_value_byte = ord($init_value);


my %code_snippets   = (
    'pack_dot' => sub {
         pack( ".", $buffer_size );
    },
    'pack_x' => sub {
       pack( "x$buffer_size" );
    },
    'grow' => sub {
        my $str;
        grow $str, $buffer_size;
    },
    'Newx'=> sub {
        my $str = alloc_with_Newx( $buffer_size );
    },
    'Newxz'=> sub {
        my $str = alloc_with_Newxz( $buffer_size );
    },
    'control' => sub {
        my $str;
    },
    'C_malloc' => sub {
        alloc_with_malloc( $buffer_size );
    },
    'C_calloc' => sub {
        alloc_with_calloc( $buffer_size );
    },
);
say "Functions that allocate memory without initializing it to a user defined value";
cmpthese( $iterations, \%code_snippets );

undef %code_snippets;

my %code_snippets_with_set   = (
    'string' => sub {
        $init_value x ( $buffer_size - 1 );
    },
    'pack' => sub {
        pack "C*", ( ($init_value_byte) x $buffer_size );
    },
    'vec' => sub {
        my $z = ''; 
        vec($z, $buffer_size - 1, 8) = $init_value_byte; 
        $z = '';
    },
    'Newx_set'=> sub {
        my $str = alloc_with_Newx_and_set( $buffer_size, $init_value_byte );
    },
    'Newxz_set'=> sub {
        my $str = alloc_with_Newxz_and_set( $buffer_size, $init_value_byte );
    },
    'control' => sub {
        my $str;
    },
    'C_malloc_and_set' => sub {
        alloc_with_malloc_and_set( $buffer_size, $init_value_byte );
    },
    'C_calloc_and_Set' => sub {
        alloc_with_calloc_and_set( $buffer_size, $init_value_byte );
    },
);
say "Functions that allocate memory and initialize it to a user defined value";
cmpthese( $iterations, \%code_snippets_with_set );

__DATA__

__C__

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
    //memset(array, initial_value_byte, length);
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


// dumped perl code as a comment
/*
my %code_snippets   = (
    'string' => sub {
        $init_value x ( $buffer_size - 1 );
    },
    'pack' => sub {
        pack "C*", ( ($init_value_byte) x $buffer_size );
    },
    'pack_dot' => sub {
         pack( ".", $buffer_size );
    },
    'pack_x' => sub {
       pack( "x$buffer_size" );
    },
    'vec' => sub {
        my $z = ''; 
        vec($z, $buffer_size - 1, 8) = $init_value_byte; 
        $z = '';
    },
    'grow' => sub {
        my $str;
        grow $str, $buffer_size;
    },
    'Newx'=> sub {
        my $str = alloc_with_Newx( $buffer_size, $init_value_byte );
    },
    'Newxz'=> sub {
        my $str = alloc_with_Newxz( $buffer_size, $init_value_byte );
    },
    'control' => sub {
        my $str;
    },
    'C_malloc' => sub {
        alloc_with_malloc( $buffer_size, $init_value_byte );
    },
    'C_malloc_and_set' => sub {
        alloc_with_malloc_and_set( $buffer_size, $init_value_byte );
    },
    'C_calloc' => sub {
        alloc_with_calloc( $buffer_size, $init_value_byte );
    },
);
*/
