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
 
END;
