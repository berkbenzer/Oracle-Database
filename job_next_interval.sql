BEGIN
  begin
  SYS.DBMS_IJOB.WHAT
       (job => 811538
       ,what       => 'begin
                     jobx.jobxrun(3, 811538);
                  end;');
  SYS.DBMS_IJOB.NEXT_DATE
        (job => 811538
        ,next_date  => to_date('07/22/2019 23:00:03','mm/dd/yyyy hh24:mi:ss'));
  SYS.DBMS_IJOB.INTERVAL
        (job => 811538
        ,interval   => 'SYSDATE+1');
  exception
    when others then
    begin
      raise;
    end;
  end;
END;
