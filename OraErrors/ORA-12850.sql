While parsing PX SQls the QC plan matches with PX slave plans and if it does not then it errors with '
ORA-12850: Could not allocate slaves on all specified instances'. Setting the parameter makes the slave use the QC plan without issues.



:WARNING: too many parse errors, count=800 SQL hash=0xda6506d3 ==================================>>>>>>>>>>>>>>>>>>>>>>>>>>
PARSE ERROR: ospid=23304, error=12850 for statement


set the parameter _gby_hash_aggregation_enabled=FALSE at system level and monitor the database for ORA-12850 errors.

alter system set "_gby_hash_aggregation_enabled"=false;

