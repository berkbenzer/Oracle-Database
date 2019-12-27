SQL> shutdown immediate;
Database closed.
Database dismounted.
ORACLE instance shut down.
SQL> startup;
ORA-01078: failure in processing system parameters
ORA-00823: Specified value of sga_target greater than sga_max_size

SQL> startup pfile='/xxx_mnt/test_xxx/datafile/init.ora';

ORACLE instance started.

Total System Global Area 4275781632 bytes
Fixed Size		    2260088 bytes
Variable Size		 2248147848 bytes
Database Buffers	 2013265920 bytes
Redo Buffers		   12107776 bytes
Database mounted.
Database opened.
SQL> show parameter sga;

NAME				     TYPE
------------------------------------ --------------------------------
VALUE
------------------------------
lock_sga			     boolean
FALSE
pre_page_sga			     boolean
FALSE
sga_max_size			     big integer
4G
sga_target			     big integer
4G



--Now edit the pfile in notepad to make sga_target greater then sga_max_size.
*.sga_max_size=8589934592
*.sga_target=8589934592

--




SQL> shutdown immediate;
Database closed.
Database dismounted.
ORACLE instance shut down.
SQL> startup pfile='/xxx_mnt/test_xxx/datafile/init.ora';
ORACLE instance started.

Total System Global Area 8551575552 bytes
Fixed Size		    2270360 bytes
Variable Size		 2248149864 bytes
Database Buffers	 6291456000 bytes
Redo Buffers		    9699328 bytes
Database mounted.
Database opened.
SQL> show parameter sga;

NAME				     TYPE
------------------------------------ --------------------------------
VALUE
------------------------------
lock_sga			     boolean
FALSE
pre_page_sga			     boolean
FALSE
sga_max_size			     big integer
8G
sga_target			     big integer
8G
SQL> create spfile from pfile='/xxx_mnt/test_xxx/datafile/init.ora'
  2  ;

File created.

--than test the database

SQL> shutdown immediate;
Database closed.
Database dismounted.
ORACLE instance shut down.
SQL> startup;
ORACLE instance started.

Total System Global Area 8551575552 bytes
Fixed Size		    2270360 bytes
Variable Size		 2248149864 bytes
Database Buffers	 6291456000 bytes
Redo Buffers		    9699328 bytes
Database mounted.
Database opened.
SQLL> 




