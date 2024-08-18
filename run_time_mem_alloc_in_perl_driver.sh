iterations=100
filename='Perl_alloc_results.csv'
filename_avx2='Perl_alloc_results_avx2.csv'
filename_avx512='Perl_alloc_results_avx512.csv'
stumpfname='time_mem_alloc_stump.pl'
stumpfname_avx2='time_mem_alloc_stump_avx2.pl'
stumpfname_avx512='time_mem_alloc_stump_avx512.pl'
sleeptime=4
./time_mem_alloc_driver.pl --buffer_size 10000000 --init_value A --iterations $iterations --csv_file $filename_avx512 --stump_fname $stumpfname_avx512 
sleep $sleeptime
./time_mem_alloc_driver.pl --buffer_size 1000000 --init_value A --iterations $iterations --csv_file $filename_avx512 --stump_fname $stumpfname_avx512 
sleep $sleeptime
./time_mem_alloc_driver.pl --buffer_size 100000 --init_value A --iterations $iterations --csv_file $filename_avx512 --stump_fname $stumpfname_avx512 
sleep $sleeptime
./time_mem_alloc_driver.pl --buffer_size 100000000 --init_value A --iterations $iterations --csv_file $filename_avx512 --stump_fname $stumpfname_avx512 
sleep $sleeptime
./time_mem_alloc_driver.pl --buffer_size 10000000 --init_value A --iterations $iterations --csv_file $filename_avx2 --stump_fname $stumpfname_avx2 
sleep $sleeptime
./time_mem_alloc_driver.pl --buffer_size 1000000 --init_value A --iterations $iterations --csv_file $filename_avx2 --stump_fname $stumpfname_avx2 
sleep $sleeptime
./time_mem_alloc_driver.pl --buffer_size 100000 --init_value A --iterations $iterations --csv_file $filename_avx2 --stump_fname $stumpfname_avx2 
sleep $sleeptime
./time_mem_alloc_driver.pl --buffer_size 100000000 --init_value A --iterations $iterations --csv_file $filename_avx2 --stump_fname $stumpfname_avx2 
sleep $sleeptime
./time_mem_alloc_driver.pl --buffer_size 10000000 --init_value A --iterations $iterations --csv_file $filename --stump_fname $stumpfname 
sleep $sleeptime
./time_mem_alloc_driver.pl --buffer_size 1000000 --init_value A --iterations $iterations --csv_file $filename --stump_fname $stumpfname 
sleep $sleeptime
./time_mem_alloc_driver.pl --buffer_size 100000 --init_value A --iterations $iterations --csv_file $filename --stump_fname $stumpfname 
sleep $sleeptime
./time_mem_alloc_driver.pl --buffer_size 100000000 --init_value A --iterations $iterations --csv_file $filename --stump_fname $stumpfname 
