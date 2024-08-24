iterations=5
filename='Perl_alloc_results_limited.csv'
stumpfname='time_mem_alloc_stump.pl'
sleeptime=4
sleep $sleeptime
./time_mem_alloc_driver_limited.pl --buffer_size 10000000 --init_value A --iterations $iterations --csv_file $filename --stump_fname $stumpfname 
sleep $sleeptime
./time_mem_alloc_driver_limited.pl --buffer_size 1000000 --init_value A --iterations $iterations --csv_file $filename --stump_fname $stumpfname 
sleep $sleeptime
./time_mem_alloc_driver_limited.pl --buffer_size 100000 --init_value A --iterations $iterations --csv_file $filename --stump_fname $stumpfname 
sleep $sleeptime
./time_mem_alloc_driver_limited.pl --buffer_size 100000000 --init_value A --iterations $iterations --csv_file $filename --stump_fname $stumpfname 
sleep $sleeptime
./time_mem_alloc_driver_limited.pl --buffer_size 1000000000 --init_value A --iterations $iterations --csv_file $filename --stump_fname $stumpfname 
sleep $sleeptime
./time_mem_alloc_driver_limited.pl --buffer_size 10000000000 --init_value A --iterations $iterations --csv_file $filename --stump_fname $stumpfname 
