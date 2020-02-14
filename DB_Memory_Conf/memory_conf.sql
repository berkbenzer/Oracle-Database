
########## MEMORY CONF. ORACLE ##########



##20gb physical memory
##16gb to database
##4 gb to OS

############ SHMMAX ############


##64-bit servers - Half the RAM - "1/2 of physical RAM" on the server
##the "theoretical limit" for SHMMAX is the amount of physical RAM that you have on the server.
##You can use your max SGA size (sga_target or memory_target variables) to determine the optimal setting for SHMMAX


#wrong parameter it defines 64Gb memory
kernel.shmmax = 68719476736


#16g memory 14.02.2020
#kernel.shmmax = 17179869184



xxxxx:~]# free -g
             total       used       free     shared    buffers     cached
Mem:            19         19          0          4          0         17
-/+ buffers/cache:          1         18
Swap:            3          1          2
[oracle@eutrishrdblp:~]# 

############SHMALL -CONFIGURATUON############



## Need to exclude swap and cache.
##This case will configure 20GB memory.
##In this  machine we have single oracle instance
##16 GB to rest of the to OS





XXXX:~]# free -m
             total       used       free     shared    buffers     cached
Mem:         20120      19940        179       5082        129      18236
-/+ buffers/cache:       1574      18545
Swap:         4095       1021       3074
[oracle@XXXX:~]#  getconf PAGE_SIZE
4096

##Calculation
Convert 16GB into bytes and divide by page size, I used the linux calc to do the math.

xxxx:~]# echo "( 16 * 1024 * 1024 * 1024 ) / 4096 " | bc -l
4194304.00000000000000000000

xxxx:~]# echo "4194304" > /proc/sys/kernel/shmall
xxxx:~]# sysctl –p

#16g memory 14.02.2020
#kernel.shmall = 4194304



##backup spfile
SQL> create pfile='/u01/xxx.ora' from spfile;

SQL> show parameter sga;

NAME				     TYPE	       VALUE
-------------------     --------       ------ 
lock_sga			     boolean	   FALSE
pre_page_sga			 boolean	   FALSE
sga_max_size			 big integer   5920M
sga_target			     big integer   5920M
SQL> shutdown immediate;
SQL> startup mount;
SQL> alter system set sga_max_size=16gb scope=both;
SQL> alter system set sga_target=16gb   scope=both;






