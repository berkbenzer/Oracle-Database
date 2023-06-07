locate awrrpt.sql
/u01/app/19.0.0.0/grid/rdbms/admin/awrrpt.sql
/u01/app/oracle/product/18.0.0.0/dbhome_1/rdbms/admin/awrrpt.sql
[oracle@etest-oracle03 ]$ cd /u01/app/oracle/product/18.0.0.0/dbhome_1/rdbms/admin/
[oracle@etest-oracle03 admin]$ sqlplus / as sysdba

 @awrrpt.sql

Specify the Report Type
~~~~~~~~~~~~~~~~~~~~~~~
AWR reports can be generated in the following formats.  Please enter the
name of the format at the prompt.  Default value is 'html'.

'html'          HTML format (default)
'text'          Text format
'active-html'   Includes Performance Hub active report

Enter value for report_type: html
old   1: select 'Type Specified: ',lower(nvl('&&report_type','html')) report_type from dual
new   1: select 'Type Specified: ',lower(nvl('html','html')) report_type from dual

Type Specified:  html

old   1: select '&&report_type' report_type_def from dual
new   1: select 'html' report_type_def from dual



old   1: select '&&view_loc' view_loc_def from dual
new   1: select 'AWR_PDB' view_loc_def from dual

locate awrrpt.sql
/u01/app/19.0.0.0/grid/rdbms/admin/awrrpt.sql
/u01/app/oracle/product/18.0.0.0/dbhome_1/rdbms/admin/awrrpt.sql
[oracle@etest-oracle03 ]$ cd /u01/app/oracle/product/18.0.0.0/dbhome_1/rdbms/admin/
[oracle@etest-oracle03 admin]$ sqlplus / as sysdba

 @awrrpt.sql

Specify the Report Type
~~~~~~~~~~~~~~~~~~~~~~~
AWR reports can be generated in the following formats.  Please enter the
name of the format at the prompt.  Default value is 'html'.

'html'          HTML format (default)
'text'          Text format
'active-html'   Includes Performance Hub active report

Enter value for report_type: html
old   1: select 'Type Specified: ',lower(nvl('&&report_type','html')) report_type from dual
new   1: select 'Type Specified: ',lower(nvl('html','html')) report_type from dual

Type Specified:  html

old   1: select '&&report_type' report_type_def from dual
new   1: select 'html' report_type_def from dual



old   1: select '&&view_loc' view_loc_def from dual
new   1: select 'AWR_PDB' view_loc_def from dual



Current Instance
~~~~~~~~~~~~~~~~
DB Id          DB Name        Inst Num       Instance       Container Name
-------------- -------------- -------------- -------------- --------------
 1863334040     CDB                        1 CDB           CDB$ROOT








Instances in this Workload Repository schema
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  DB Id      Inst Num   DB Name      Instance     Host
------------ ---------- ---------    ----------   ------
  1271902152     1      ORACLE-PROD     ORACLE-PROD     ORACLE-PROD
  2371751144     1      CEPROD       ceprod       ORACLE-PROD
* 1863334040     1      CDB         CDB         etest-oracle

Using 1863334040 for database Id
Using          1 for instance number


Specify the number of days of snapshots to choose from
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Entering the number of days (n) will result in the most recent
(n) days of snapshots being listed.  Pressing <return> without
specifying a number lists all completed snapshots.


Enter value for num_days: 1

Listing the last day's Completed Snapshots
Instance     DB Name      Snap Id       Snap Started    Snap Level
------------ ------------ ---------- ------------------ ----------

CDB         CDB               251  07 Jun 2023 00:00    1
                                252  07 Jun 2023 01:00    1
                                253  07 Jun 2023 02:00    1
                                254  07 Jun 2023 03:00    1
                                255  07 Jun 2023 04:00    1
                                256  07 Jun 2023 05:00    1
                                257  07 Jun 2023 06:00    1
                                258  07 Jun 2023 07:00    1
                                259  07 Jun 2023 08:00    1
                                260  07 Jun 2023 09:00    1
                                261  07 Jun 2023 10:00    1
                                262  07 Jun 2023 11:00    1
                                263  07 Jun 2023 12:00    1
                                264  07 Jun 2023 13:00    1
                                265  07 Jun 2023 14:00    1
                                266  07 Jun 2023 15:00    1


Specify the Begin and End Snapshot Ids
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Enter value for begin_snap: 265
Begin Snapshot Id specified: 265

Enter value for end_snap: 266
End   Snapshot Id specified: 266



