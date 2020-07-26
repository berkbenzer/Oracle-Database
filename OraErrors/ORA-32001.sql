 
SQL> show parameter pfile
 
NAME    TYPE VALUE
------ -------- ------------------------------
spfile  string
 
 
 
create spfile from pfile;
 
cd $ORACLE_HOME/dbs
ls -ltr spfile*


shutdown immediate;
startup

