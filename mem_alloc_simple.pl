#!/home/chrisarg/perl5/perlbrew/perls/current/bin/perl
use v5.38;

use Data::Dumper;
use Const::Fast;
use FindBin qw($Bin);    # Locate the directory of the script
use lib $Bin;            # Add the script's directory to @INC
use MemAlloc;




say "Allocate the FIRST buffer with all null bytes!";
my $memdeath = MemAlloc->new( 10, 1 );
printf( "Buffer %10s with buffer address %s\n\n",
    'memdeath', $memdeath->get_buffer() );
$memdeath->print_storage_space_info();
say "Allocate an Alpha buffer!";
my $mem = MemAlloc->new( 10, 1, 'A' );
say
"\nThis is what is stored in the buffer's memory space (as string and as individual bytes)";
MemAlloc::print_storage_space_info( $mem->get_buffer(),
    $mem->get_buffer_size() );
say "\nFreeing our very FIRST all null_byte buffer!";
undef $memdeath;
say "\nCopying the Alpha buffer!";
my $mem_cp = $mem;
printf "Buffer %10s with buffer address %s\n", 'Alpha', $mem->get_buffer();
printf "Buffer %10s with buffer address %s\n",
  'Alpha_copy', $mem_cp->get_buffer();
say "\nKilling the Alpha buffer!";
undef $mem;
say "Trying to access the Alpha buffer would lead to an error";
say "mem : ", ( $mem ? $mem->get_buffer() : "does not exist anymore" );
say
"\nHowever, Perl's refcount mechanism keeps the copy of the Alpha buffer alive!";
say "Alpha copy still points to : ", $mem_cp->get_buffer();
$mem_cp->print_storage_space_info();
say "\nModifying the Alpha_copy buffer!";
$mem_cp = MemAlloc->new( 10, 1, 'B' );
printf "Buffer %10s with buffer address %s\n",
  'Alpha_copy after modification', $mem_cp->get_buffer();
$mem_cp->print_storage_space_info();
say "\nCopying the Alpha_copy buffer to illustrate delayed garbage collection!";
my $mem_cp2 = $mem_cp;
printf "Buffer %10s with buffer address %s\n", 'mem_cp', $mem_cp->get_buffer();
printf "Buffer %10s with buffer address %s\n", 'mem_cp2',
  $mem_cp2->get_buffer();
printf "Print contents of %-10s followed by %10s\n", 'mem_cp', 'mem_cp2';
$mem_cp->print_storage_space_info();
$mem_cp2->print_storage_space_info();
printf "Changing the contents of %-10s does not lead to destruction of %10s\n",
  'mem_cp2', 'mem_cp';
$mem_cp2 = MemAlloc->new( 10, 1, 'C' );
printf "Buffer %10s with buffer address %s\n", 'mem_cp2',
  $mem_cp2->get_buffer();
$mem_cp2->print_storage_space_info();
printf
"\nIllustrate, by re-assigning %-10s to a new object with delayed garbage collection\n",
  'mem_cp';
say "Reassignment, should free the old object first";
$mem_cp = MemAlloc->new( 10, 1, 'D', 1 );
printf "Buffer %10s with buffer address %s\n", 'mem_cp', $mem_cp->get_buffer();
printf "\nAssigning new contents to %-10s does not trigger autodestruct\n",
  'mem_cp';
$mem_cp = MemAlloc->new( 10, 1, 'E', 1 );
printf "Buffer %10s with buffer address %s\n", 'mem_cp', $mem_cp->get_buffer();
say "Objects with delayed GC : @{ MemAlloc::get_delayed_gc_objects() }";

const my $mem_constant => MemAlloc->new( 10, 1, 'F' );
#undef $mem_constant;
#$mem_constant = MemAlloc->new( 10, 1, 'G' );
say "\nEnd of program - see how Perl's destroying all objects now";