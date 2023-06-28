select distinct
   owner c1,
   index_type c2,
   count(*)
from
   dba_indexes
where
   owner not in (
   'APEX_040200',
   'MDSYS',
   'OUTLN',
   'CTXSYS',
   'OLAPSYS',
   'FLOWS_FILES',
   'SYSTEM',
   'DVSYS',
   'AUDSYS',
   'DBSNMP',
   'GSMADMIN_INTERNAL',
   'OJVMSYS',
   'ORDSYS',
   'XDB',
   'ORDDATA',
   'SYS',
   'WMSYS',
   'LBACSYS')
group by
   owner,
   index_type
order by
   owner,
   index_type;
