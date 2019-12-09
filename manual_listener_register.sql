istsl75rhel6db:~]# lsnrctl start

LSNRCTL for Linux: Version 12.2.0.1.0 - Production on 09-DEC-2019 10:41:24

Copyright (c) 1991, 2016, Oracle.  All rights reserved.

Starting /u01/app/oracle/product/12.2.0/db_1/bin/tnslsnr: please wait...

TNSLSNR for Linux: Version 12.2.0.1.0 - Production
System parameter file is /u01/app/oracle/product/12.2.0/db_1/network/admin/listener.ora
Log messages written to /u01/app/oracle/diag/tnslsnr/istsl75rhel6db/listener/alert/log.xml
Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=istsl75rhel6db)(PORT=1521)))

Connecting to (ADDRESS=(PROTOCOL=tcp)(HOST=)(PORT=1521))
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 12.2.0.1.0 - Production
Start Date                09-DEC-2019 10:41:24
Uptime                    0 days 0 hr. 0 min. 0 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /u01/app/oracle/product/12.2.0/db_1/network/admin/listener.ora
Listener Log File         /u01/app/oracle/diag/tnslsnr/istsl75rhel6db/listener/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=istsl75rhel6db)(PORT=1521)))
The listener supports no services
The command completed successfully


SQL> alter system set local_listener='(ADDRESS=(PROTOCOL=tcp)(HOST=xx.xxx.xxx.xxx)(PORT=1521))';

System altered.

SQL> alter system register;

System altered.






istsl75rhel6db:~]# lsnrctl status

LSNRCTL for Linux: Version 12.2.0.1.0 - Production on 09-DEC-2019 10:50:23

Copyright (c) 1991, 2016, Oracle.  All rights reserved.

Connecting to (ADDRESS=(PROTOCOL=tcp)(HOST=)(PORT=1521))
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 12.2.0.1.0 - Production
Start Date                09-DEC-2019 10:41:24
Uptime                    0 days 0 hr. 8 min. 58 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /u01/app/oracle/product/12.2.0/db_1/network/admin/listener.ora
Listener Log File         /u01/app/oracle/diag/tnslsnr/istsl75rhel6db/listener/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=istsl75rhel6db)(PORT=1521)))
  Services Summary...
Service "cdbXDB.cdb" has 1 instance(s).
  Instance "cdb", status READY, has 1 handler(s) for this service...
Service "orcl.cdb" has 1 instance(s).
  Instance "cdb", status READY, has 1 handler(s) for this service...
The command completed successfully
[oracle@istsl75rhel6db:~]# 
