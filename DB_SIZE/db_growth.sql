/* Formatted on 28.04.2020 14:43:32 (QP5 v5.269.14213.34769) */
CREATE OR REPLACE FORCE VIEW SYS.V_DB_GROWTH
(
   "SYSDATE",
   TOTAL_SIZE_GB,
   FREE_SPACE_GB,
   "FREE_SPACE_RATIO%"
)
AS
   SELECT "SYSDATE",
          "TOTAL_SIZE_GB",
          "FREE_SPACE_GB",
          "FREE_SPACE_RATIO%"
     FROM (SELECT SYSDATE,
                  t2.total "TOTAL_SIZE_GB",
                  t1.free "FREE_SPACE_GB",
                  (t1.free / t2.total) * 100 "FREE_SPACE_RATIO%"
             FROM (SELECT SUM (bytes) / 1024 / 1024 / 1024 free
                     FROM dba_free_space
                    WHERE TABLESPACE_NAME NOT IN ('UNDOTBS1', 'UNDOTBS2')) t1,
                  (SELECT SUM (bytes) / 1024 / 1024 / 1024 total
                     FROM dba_Data_files
                    WHERE TABLESPACE_NAME NOT IN ('UNDOTBS1', 'UNDOTBS2')) t2);



CREATE TABLE SYS.DB_GROWTH
(
  "SYSDATE"             DATE,
  TOTAL_SIZE_GB         NUMBER,
  FREE_SPACE_GB         NUMBER,
  "FREE_SPACE_RATIO% "  NUMBER
)
TABLESPACE SYSTEM
RESULT_CACHE (MODE DEFAULT)
PCTUSED    40
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;









DECLARE
  X NUMBER;
  user_name varchar2(30);
BEGIN
  select user into user_name from dual;
  execute immediate 'alter session set current_schema = SYS';
  BEGIN
    SYS.DBMS_JOB.SUBMIT
    ( job       => X 
     ,what      => 'begin insert into db_growth select * from v_db_growth;commit;end;'
     ,next_date => to_date('29.04.2020 06:00:00','dd/mm/yyyy hh24:mi:ss')
     ,interval  => 'TRUNC(SYSDATE+1)+6/24'
     ,no_parse  => FALSE
    );
    SYS.DBMS_OUTPUT.PUT_LINE('Job Number is: ' || to_char(x));
    execute immediate 'alter session set current_schema = ' || user_name ;
  EXCEPTION
    WHEN OTHERS THEN 
      execute immediate 'alter session set current_schema = ' || user_name ;
      RAISE;
  END;
  COMMIT;
END;
/
