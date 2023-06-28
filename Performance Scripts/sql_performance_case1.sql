---Case 1

--- Two queries working different execution plan.
-- One that slow was using "BITMAP CONVERSION FROM ROWIDS" other was reaching the table using "INDEX RANGE SCAN DESCENDING"
-- First check the Index type in the Database. There is not BITMAP index found in the database .


 SELECT DISTINCT owner c1, index_type c2, COUNT (*)
    FROM dba_indexes
   WHERE owner NOT IN ('APEX_040200',
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
GROUP BY owner, index_type
ORDER BY owner, index_type;

-- Second enable hidden parameter to false.
alter session set "_b_tree_bitmap_plans"=false

-- Sql was retriving data 36 seconds after enable hidden "_b_tree_bitmap_plans"  on it returns data in 3 seconds.
