

begin
dbms_stats.gather_index_stats(ownname=>'XXXX', indname=>'XXXX', ESTIMATE_PERCENT=>NULL, DEGREE=>4);
end;




begin

  DBMS_STATS.GATHER_DICTIONARY_STATS;

  end;

 

 

BEGIN

   DBMS_STATS.GATHER_FIXED_OBJECTS_STATS;

END;

/


