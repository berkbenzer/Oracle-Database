Cause: Existing MEMORY_TARGET value not enough to start database.

Solution: Increase MEMORY_TARGET value.

 

Consider following workaround:

[oracle@12c bin]$ sqlplus “/ as sysdba”

SQL*Plus: Release 12.1.0.1.0 Production on Mon Jun 9 11:15:45 2014

Copyright (c) 1982, 2013, Oracle. All rights reserved.

Connected to an idle instance.

SQL> startup
ORA-00838: Specified value of MEMORY_TARGET is too small, needs to be at least 3072M

// As we know spfile isn’t human readable or editable, create pfile from spfile. So that we able to change oracle system parameter. ( i.e. MEMORY_TARGET )

SQL> create pfile=’/tmp/pfile.bac’ from spfile;

File created.

// After file has created, change MEMORY_TARGET parameter value from pfile.

[oracle@12c ~]$ nano /tmp/pfile.bac
*.memory_target=3072M

// Start oracle database with newly updated pfile as follows.

[oracle@12c ~]$ sqlplus “/ as sysdba”

SQL*Plus: Release 12.1.0.1.0 Production on Mon Jun 9 11:24:56 2014

Copyright (c) 1982, 2013, Oracle. All rights reserved.

Connected to an idle instance.

SQL> startup pfile=/tmp/pfile.bac

ORACLE instance started.

Total System Global Area 3206836224 bytes
Fixed Size 2293496 bytes
Variable Size 1879048456 bytes
Database Buffers 1308622848 bytes
Redo Buffers 16871424 bytes
Database mounted.
Database opened.

// Create spfile from newly created pfile. As we are using spfile for our database.

SQL> create spfile from pfile=’/tmp/pfile.bac’;

File created.

// Bounce the database after creating spfile to reflect changes in environment.
SQL> startup force;
ORACLE instance started.

Total System Global Area 3206836224 bytes
Fixed Size 2293496 bytes
Variable Size 1879048456 bytes
Database Buffers 1308622848 bytes
Redo Buffers 16871424 bytes
Database mounted.
Database opened.

// Ensure changes by following command.

SQL> show parameter memory_target

NAME TYPE VALUE
———————————— ———– ——————————
memory_target    big integer    3G
