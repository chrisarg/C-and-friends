package MemAlloc;
use Carp qw(carp croak);
use Class::Std::Utils;
use constant { ZERO_STRING_BYTE => "\0", };
use Inline (
    C         => 'DATA',
    CC        => 'g++',
    LD        => 'g++',
    INC       => q{},      # replace q{} with anything else you need
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
{
    # class attributes

    ## inside out object attributes
    my %buffer;
    my %buffer_size_of_buffer;
    my %element_size_of_buffer;
    my %num_of_elements_of_buffer;
    my %delayed_gc_for;
    
    ## change to use pack 
    sub new {
        my ( $self, $num_of_items, $size_of_each_item, $init_value, $is_delayed_gc ) = @_;
        ## exit if the number of items or the number of bytes per item is not defined
        croak "Number of items and size of each item must be defined"
          unless defined $num_of_items and defined $size_of_each_item;

        ## Various defaults here
        $init_value = ZERO_STRING_BYTE
          unless $init_value;

        ## Create a new object - calculate the buffer size
        my $buffer_size = $num_of_items * $size_of_each_item;
         my $new_obj     = bless \do {
             my $anon_scalar = $init_value x ( $buffer_size - 1 );

        }, $self;

        $buffer{ ident $new_obj } = get_buffer_address( ${$new_obj} );

        ## Store the buffer size, element size and number of elements
        $buffer_size_of_buffer{ ident $new_obj }     = $buffer_size;
        $element_size_of_buffer{ ident $new_obj }    = $size_of_each_item;
        $num_of_elements_of_buffer{ ident $new_obj } = $num_of_items;

        if ( $is_delayed_gc ) {
            $delayed_gc_for{ ident $new_obj } = $new_obj;
        }
        return $new_obj;
    }

    sub DESTROY {
        my ($self) = @_;
        printf "Object %x with buffer address : %d is dying\n", ident($self),
          $buffer{ ident $self };
        delete $buffer{ ident $self };
        delete $buffer_size_of_buffer{ ident $self };
        delete $element_size_of_buffer{ ident $self };
        delete $num_of_elements_of_buffer{ ident $self };

    }

    sub get_buffer {
        my ($self) = @_;
        return $buffer{ ident $self };
    }

    sub get_buffer_size {
        my ($self) = @_;
        return $buffer_size_of_buffer{ ident $self };
    }

    sub get_element_size {
        my ($self) = @_;
        return $element_size_of_buffer{ ident $self };
    }

    sub get_num_of_elements {
        my ($self) = @_;
        return $num_of_elements_of_buffer{ ident $self };
    }

    ## todo : write method to return a list of delayed gc objects
    sub get_delayed_gc_objects {
        my @delayed_gc_objects = keys %delayed_gc_for;
        return \@delayed_gc_objects;
    }

    sub print_storage_space_info {
        my ($self) = @_;
        _print_storage_space_info( $buffer{ ident $self },
            $buffer_size_of_buffer{ ident $self } );
    }

}

1;
__DATA__

__C__

#include <stdio.h>
#include <stdint.h>
SV* get_buffer_address(SV* sv);

SV* get_buffer_address(SV* sv) {
    if (!SvPOK(sv)) {
        croak("Input is not a string scalar");
    }
    char* buffer = SvPVbyte_nolen(sv);
    return newSVuv(PTR2UV(buffer));
}

void _print_storage_space_info(size_t str,size_t len) {
    char *x = (char *)str;
    printf("String stored : %s at address %zu\n",x,(uintptr_t)x);
    puts("Individual bytes stored (hex): ");
    printf("\t");
    for (int i = 0; i < len; i++) {
        printf("%02x ", (unsigned char)x[i]);
        if ((i + 1) % 8 == 0) {
            printf("\n\t");  // Print a newline after every 8 bytes
        }
    }
    puts("");
}
 
