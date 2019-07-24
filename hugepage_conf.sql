--HUGEPAGES



~]$ free -g
             total       used       free     shared    buffers     cached
Mem:             3          1          2          0          0          1
-/+ buffers/cache:          0          3
Swap:           15          1         14





--1  Check Physical Memory
-- Second check your database parameter. Initially: AMM disabled? MEMORY_TARGET and MEMORY_MAX_TARGET should be set to 0:
SQL> select value from v$parameter where name = 'memory_target';

VALUE
--------------------------------------------------------------------------------
0


--2 Check Database Parameter
--How big is our SGA? In this example about 2 GB. Important: In the following query we directly convert into kB (value/1024). With that we can continue to calculate directly:
SQL> select value/1024 from v$parameter where name = 'sga_target';

VALUE/1024
----------
   2359296





--Finally as per default the parameter use_large_pages should be enabled:
SQL> select value from v$parameter where name = 'use_large_pages';

VALUE
--------------------------------------------------------------------------------
TRUE



--3 Check Hugepagesize
--In our example we use a x86_64 Red Hat Enterprise Linux Server. So by default hugepagesize should be set to 2 MB:
~]$grep Hugepagesize /proc/meminfo
Hugepagesize:       2048 kB



--4 Calculate Hugepages
/*Calculate Hugepages
--For the calculation of the number of hugepages there is a easy way:


SGA / Hugepagesize = Number Hugepages

2359296/2048=1152


If you run more than one database on your server, you should include the SGA of all of your instances into the calculation:
( SGA 1. Instance + SGA 2. Instance + … etc. ) / Hugepagesize = Number Hugepages

*/



--5 Change Server Configuration

/*
vi /etc/sysctl.conf

vm.nr_hugepages=1152


The next parameter is hard and soft memlock in /etc/security/limits.conf for our oracle user. 
This value should be smaller than our available memory but minor to our SGA. 
Our hugepages should fit into that by 100 percent. For that following calculation:

Number Hugepages * Hugepagesize = minimum Memlock


vi /etc/security/limits.conf

1152*2048=2359296

Correctly inserted, following result should show up:

muratgoynuk ~]# grep oracle /etc/security/limits.conf

oracle   hard   memlock    2359296
oracle   soft   memlock    2359296



As mentioned before we have to disable transparent hugepages from Red Hat Linux version 6 ongoing:



cat /sys/kernel/mm/redhat_transparent_hugepage/enabled
[always] madvise never

echo never > /sys/kernel/mm/redhat_transparent_hugepage/enabled
echo never > /sys/kernel/mm/redhat_transparent_hugepage/defrag

cat /sys/kernel/mm/redhat_transparent_hugepage/enabled
always madvise [never]

*/

--6 SERVER REBOOT


--sysctl -p
--init 6




--7. Check Configuration



~]$ grep Huge /proc/meminfo
AnonHugePages:      6144 kB
HugePages_Total:    1152
HugePages_Free:     1152
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB


~]$ ulimit -l
2359296

Transparent Hugepages disabled?

~]$ cat /sys/kernel/mm/redhat_transparent_hugepage/enabled
[always] madvise never




--8 Open database;

sqlplus / as sysdba

SQL> startup

SQL> exit



--9 Open Listener

]$ lsnrctl status

LSNRCTL for Linux: Version 12.2.0.1.0 - Production on 24-JUL-2019 11:53:45

Copyright (c) 1991, 2016, Oracle.  All rights reserved.

Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=muratgoynuk.bnp)(PORT=1521)))
TNS-12541: TNS:no listener
 TNS-12560: TNS:protocol adapter error
  TNS-00511: No listener
   Linux Error: 111: Connection refused


~]$ lsnrctl start


--10 Show memory parameter

NAME				     TYPE	 VALUE
------------------------------------ ----------- ------------------------------
memory_max_target		     big integer 0
memory_target			     big integer 0




















*/
