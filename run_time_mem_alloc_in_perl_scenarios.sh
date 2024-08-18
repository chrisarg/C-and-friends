iterations=100
filename='Perl_alloc_results.csv'
filename_avx2='Perl_alloc_results_avx2.csv'
./time_mem_alloc_custommemset.pl --buffer_size 10000000 --init_value A --iterations $iterations --csv_file $filename_avx2
sleep 10
./time_mem_alloc_custommemset.pl --buffer_size 1000000 --init_value A --iterations $iterations --csv_file $filename_avx2
sleep 10
./time_mem_alloc_custommemset.pl --buffer_size 100000000 --init_value A --iterations $iterations --csv_file $filename_avx2
sleep 10
./time_mem_alloc.pl --buffer_size 10000000 --init_value A --iterations $iterations --csv_file $filename
sleep 10
./time_mem_alloc.pl --buffer_size 1000000 --init_value A --iterations $iterations --csv_file $filename
sleep 10
./time_mem_alloc.pl --buffer_size 100000000 --init_value A --iterations $iterations --csv_file $filename
