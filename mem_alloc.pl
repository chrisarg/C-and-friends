#!/home/chrisarg/perl5/perlbrew/perls/current/bin/perl
use v5.38;
use Data::Dumper;

package MemAlloc;
use Carp qw(carp croak);
use Class::Std::Utils;
use constant { ZERO_STRING_BYTE => '\0', };
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
    my %allocators = (
        Perl_string => sub {
            my ( $num_of_items, $size_of_each_item, $init_value ) = @_;
            my $buffer_size = $num_of_items * $size_of_each_item -
              1;    ## -1 to account for the string terminator
            my $buffer = $init_value x $buffer_size;
            return \$buffer;
        },
    );

    ## inside out object attributes
    my %buffer;
    my %buffer_size_of_buffer;
    my %element_size_of_buffer;
    my %num_of_elements_of_buffer;
    my %allocator_of_buffer;

    sub new {
        my ( $self, $num_of_items, $size_of_each_item, $opts_ref ) = @_;
        ## exit if the number of items or the number of bytes per item is not defined
        croak "Number of items and size of each item must be defined"
          unless defined $num_of_items and defined $size_of_each_item;

        ## Various defaults here
        my $init_value     = $opts_ref->{init_value} // ZERO_STRING_BYTE;
        my $allocator_name = $opts_ref->{allocator}  // 'Perl_string';
        my $allocator      = $allocators{$allocator_name};

        ## Create a new object - calculate the buffer size
        my $buffer_size = $num_of_items * $size_of_each_item;
        my $new_obj     = bless do {
            my $anon_scalar =
              $allocator->( $num_of_items, $size_of_each_item, $init_value );
        }, $self;

        $buffer{ ident $new_obj } = get_buffer_address( ${$new_obj} );

        ## Store the buffer size, element size and number of elements
        $buffer_size_of_buffer{ ident $new_obj }     = $buffer_size;
        $element_size_of_buffer{ ident $new_obj }    = $size_of_each_item;
        $num_of_elements_of_buffer{ ident $new_obj } = $num_of_items;
        return $new_obj;
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

    sub DESTROY {
        my ($self) = @_;
        printf "Object %x with buffer address : %d is dying\n", ident($self),
          $buffer{ ident $self };
        delete $buffer{ ident $self };
        delete $buffer_size_of_buffer{ ident $self };
        delete $element_size_of_buffer{ ident $self };
        delete $num_of_elements_of_buffer{ ident $self };

    }

}
say "Allocate the FIRST buffer !";
my $memdeath = MemAlloc->new( 10, 1 );
printf( "Buffer %10s with buffer address %s\n\n",
    'memdeath', $memdeath->get_buffer() );
say "Allocate an Alpha buffer!";
my $mem = MemAlloc->new( 10, 1, { init_value => 'A' } );
say "Buffer contents !";
say $mem->get_buffer();
say
"\nThis is what is stored in the buffer's memory space (as string and as individual bytes)";
print_storage_space_info( $mem->get_buffer(), $mem->get_buffer_size() );
say "\nFreeing our very FIRST buffer!";
undef $memdeath;
say "\nCopying the Alpha buffer!";
my $mem_cp = $mem;
printf( "Buffer %10s with buffer address %s\n", 'Alpha', $mem->get_buffer() );
printf( "Buffer %10s with buffer address %s\n",
    'Alpha_copy', $mem_cp->get_buffer() );
say "\nKilling the Alpha buffer!";
undef $mem;
say "Trying to access the Alpha buffer would lead to an error";
say "mem : ", ( $mem ? $mem->get_buffer() : "does not exist anymore" );
say
"\nHowever, Perl's refcount mechanism keeps the copy of the Alpha buffer alive!";
say "Alpha copy still points to : ", $mem_cp->get_buffer();
say "\nFreeing the copy of the Alpha buffer upon program exit!";

__DATA__

__C__

#include <stdio.h>
SV* get_buffer_address(SV* sv);

SV* get_buffer_address(SV* sv) {
    if (!SvPOK(sv)) {
        croak("Input is not a string scalar");
    }
    char* buffer = SvPV_nolen(sv);
    return newSVuv(PTR2UV(buffer));
}

void print_storage_space_info(size_t str,size_t len) {
    char *x = (char *)str;
    printf("String stored : %s\n",x);
    puts("Individual bytes stored : ");
    for (int i = 0; i < len; i++) {
        printf("\t%d\n",x[i]);
    }
}
 
