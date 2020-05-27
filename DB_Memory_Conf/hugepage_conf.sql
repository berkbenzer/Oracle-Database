Check Physical Memory
First we should check our „physical“ available Memory. In the example we have about 128 GB of RAM. SGA_TARGET and PGA_AGGREGATE_TARGET together, should not be more than the availabel memory. Besides should be enough space for OS processes itself:

grep MemTotal /proc/meminfo

MemTotal: 132151496 kB
2. Check Database Parameter
Second check your database parameter. Initially: AMM disabled? MEMORY_TARGET and MEMORY_MAX_TARGET should be set to 0:

SQL> select value from v$parameter where name = 'memory_target';

VALUE
---------------------------
0 
How big is our SGA? In this example about 40 GB. Important: In the following query we directly convert into kB (value/1024). With that we can continue to calculate directly:

SQL> select value/1024 from v$parameter where name = 'sga_target';

VALUE
---------------------------
41943040
Finally as per default the parameter use_large_pages should be enabled:

SQL> select value from v$parameter where name = 'use_large_pages';

VALUE
---------------------------
TRUE
3. Check Hugepagesize
In our example we use a x86_64 Red Hat Enterprise Linux Server. So by default hugepagesize should be set to 2 MB:

grep Hugepagesize /proc/meminfo

Hugepagesize:       2048 kB
4. Calculate Hugepages
For the calculation of the number of hugepages there is a easy way:

SGA / Hugepagesize = Number Hugepages
Following our example:

41943040 / 2048 = 20480
If you run more than one database on your server, you should include the SGA of all of your instances into the calculation:

( SGA 1. Instance + SGA 2. Instance + … etc. ) / Hugepagesize = Number Hugepages
In My Oracle Support you can find a script (Doc ID 401749.1) called hugepages_settings.sh, which does the calculation. This also includes a check of your kernel version and the actually used shared memory area by the SGA. Please consider that this calculation observes only the actual use of SGA and their use. If your second instance is down it will be not in the account. That means to adjust your SGA and restart your database first. Than you can run the script. Result should be the following line. Maybe you can make your own calculation and than check it with the script:

Recommended setting: vm.nr_hugepages = 20480
5. Change Server Configuration
The next step is to enter the number of hugepages in the server config file. For that you need root permissions. On Red Hat Linux 6 /etc/sysctl.conf.

vi /etc/sysctl.conf

vm.nr_hugepages=20480
Correctly inserted, following result should show up:

grep vm.nr_hugepages /etc/sysctl.conf

vm.nr_hugepages=20480 
The next parameter is hard and soft memlock in /etc/security/limits.conf for our oracle user. This value should be smaller than our available memory but minor to our SGA. Our hugepages should fit into that by 100 percent. For that following calculation:

Number Hugepages * Hugepagesize = minimum Memlock
Following our example:

20480 * 2048 = 41943040
vi /etc/security/limits.conf

oracle               soft    memlock 41943040
oracle               hard    memlock 41943040
Correctly inserted, following result should show up:

grep oracle /etc/security/limits.conf

...
oracle               soft    memlock 41943040
oracle               hard    memlock 41943040
As mentioned before we have to disable transparent hugepages from Red Hat Linux version 6 ongoing:

cat /sys/kernel/mm/redhat_transparent_hugepage/enabled
[always] madvise never

echo never > /sys/kernel/mm/redhat_transparent_hugepage/enabled
echo never > /sys/kernel/mm/redhat_transparent_hugepage/defrag

cat /sys/kernel/mm/redhat_transparent_hugepage/enabled
always madvise [never]
6. Server Reboot
If all parameter are set, make a complete reboot your server. As an alternative you can reload the parameters with sysctl -p.

7. Check Configuration
Memlock correct?

ulimit -l

41943040 
HugePages correctly configured and in use?

grep Huge /proc/meminfo

AnonHugePages:    538624 kB 
HugePages_Total:    20480
HugePages_Free:     12292
HugePages_Rsvd:      8188
HugePages_Surp:        0
Hugepagesize:       2048 kB
Transparent Hugepages disabled?

cat /sys/kernel/mm/redhat_transparent_hugepage/enabled

always madvise [never]
Did the database uses HugePages? For that we take a look into the alert log. After „Starting ORACLE instance (normal)“ following entry „Large Pages Information“ gives us advise:

************************ Large Pages Information *******************

Per process system memlock (soft) limit = 100 GB
Total Shared Global Region in Large Pages = 40 GB (100%) 
Large Pages used by this instance: 20481 (40 GB)
Large Pages unused system wide = 0 (0 KB)
Large Pages configured system wide = 20481 (40 GB)
Large Page size = 2048 KB

********************************************************************
If your configuration is incorrect Oracle delivers recommendation here for the right setting. In the following example exactly one Page is missing, so 2048 kB memlock to come to 100% of SGA use of hugepages:

************************ Large Pages Information *******************
...
...

RECOMMENDATION:

Total System Global Area size is 40 GB. For optimal performance,
prior to the next instance restart:
1. Increase the number of unused large pages by
at least 1 (page size 2048 KB, total size 2048 KB) system wide to
get 100% of the System Global Area allocated with large pages
2. Large pages are automatically locked into physical memory.
Increase the per process memlock (soft) limit to at least 40 GB to lock
100% System Global Area's large pages into physical memory

********************************************************************
