SET SERVEROUTPUT ON;
DECLARE
  match_count INTEGER;


--bbenzer.test_proc (kolon1) values ('ahandabu')

--the owner/schema of the tables you are looking at
  v_owner VARCHAR2( 255) :='BBENZER' ;

-- data type you look at (in CAPITAL)
-- VARCHAR2, NUMBER, etc.
  v_data_type VARCHAR2( 255) :='VARCHAR2' ;

--The value you are looking for with like "%" operator
  v_search_string VARCHAR2(4000) := '%ahandabu%' ;

BEGIN
  FOR t IN (SELECT atc.table_name
                  ,atc.column_name
                  ,atc.owner 
            FROM all_tab_cols atc
           WHERE atc.owner = v_owner
             AND data_type =  v_data_type
             -- exclude vir. columns
             AND atc.column_id is not null
             -- exclude views
             AND not exists (select 1 
                               from all_views 
                               where view_name = atc.table_name) ) LOOP

    EXECUTE IMMEDIATE
        'SELECT COUNT(*) FROM ' 
         || t.owner || '.'  ||t. table_name|| 
        ' WHERE UPPER("'||t.column_name ||'") LIKE  UPPER(:1)'
    INTO match_count
    USING v_search_string ;

    IF match_count > 0 THEN
      dbms_output.put_line( t. table_name ||' ' ||t.column_name ||' '||match_count );
    END IF;

  END LOOP;
END;
/
