SELECT
  (a.blocks*b.block_size)/1024/1024/1024 AS current_size,
  (a.num_rows*a.avg_row_len)/1024/1024/1024 AS theorical_size,
  ((a.blocks*b.block_size)-(a.num_rows*a.avg_row_len))/1024/1024/1024 AS gain,
  (((a.blocks*b.block_size)-(a.num_rows*a.avg_row_len))*100/(a.blocks*b.block_size)) - a.pct_free AS percentage_gain
FROM dba_tables a, dba_tablespaces b
WHERE a.tablespace_name=b.tablespace_name
AND owner = UPPER('XXX')
AND table_name = UPPER('XXXX');


/*

It displays Table's Unused block,total blocks and High water mark.



*/
 
DECLARE
  CURSOR cu_tables IS
    SELECT a.owner,
           a.table_name
    FROM   all_tables a
    WHERE  a.table_name = Decode(Upper('&&Table_Name'),'ALL',a.table_name,Upper('&&Table_Name'))
    AND    a.owner      = Upper('&&Table_Owner') 
    AND    a.partitioned='NO'
    AND    a.logging='YES'
order by table_name;
 
  op1  NUMBER;
  op2  NUMBER;
  op3  NUMBER;
  op4  NUMBER;
  op5  NUMBER;
  op6  NUMBER;
  op7  NUMBER;
BEGIN
 
  Dbms_Output.Disable;
  Dbms_Output.Enable(1000000);
  Dbms_Output.Put_Line('TABLE                             UNUSED BLOCKS     TOTAL BLOCKS  HIGH WATER MARK');
  Dbms_Output.Put_Line('------------------------------  ---------------  ---------------  ---------------');
  FOR cur_rec IN cu_tables LOOP
    Dbms_Space.Unused_Space(cur_rec.owner,cur_rec.table_name,'TABLE',op1,op2,op3,op4,op5,op6,op7);
    Dbms_Output.Put_Line(RPad(cur_rec.table_name,30,' ') ||
                         LPad(op3,20,' ')                ||
                         LPad(op1,20,' ')                ||
                         LPad(Trunc(op1-op3-1),15,' ')); 
  END LOOP;
  
  
  
/* 
  
  Output before the shrink statement
  
  TABLE                             UNUSED BLOCKS     TOTAL BLOCKS  HIGH WATER MARK
------------------------------  ---------------  ---------------  ---------------
SALES                                 0                1920                1919
 
END;

*/


alter table xxx.xxx enable row movement;


alter table xxx.xxx shrink SPACE; 

/*

Output after the shrink statement

TABLE                             UNUSED BLOCKS     TOTAL BLOCKS  HIGH WATER MARK
------------------------------  ---------------  ---------------  ---------------
SALES                                    3                1816           1812


*/

select count(*) from  besprod.sales
where 1=1
AND ORDER_DATE like '%2013'

--34294

delete from  besprod.sales
where 1=1
AND ORDER_DATE like '%2013';


alter table xxx.xxx shrink SPACE cascade; 


/*
TABLE                             UNUSED BLOCKS     TOTAL BLOCKS  HIGH WATER MARK
------------------------------  ---------------  ---------------  ---------------
SALES                                    0                 792            791
*/



