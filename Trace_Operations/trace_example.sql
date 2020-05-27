alter session set tracefile_identifier='10046ERRSTK';

alter session set timed_statistics = true;

alter session set statistics_level= all ;

alter session set max_dump_file_size = unlimited;

alter session set events '10046 trace name context forever,level 12';

alter session set events '12801 trace name ERRORSTACK level 3';

alter session set events '2003 trace name ERRORSTACK level 3';


------------------------------

##Run script via app

alter session set events '10046 trace name context off';

alter session set events '12801 trace name errorstack off';

alter session set events '2003 trace name errorstack off';
