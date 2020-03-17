/* Formatted on 17.03.2020 15:32:31 (QP5 v5.269.14213.34769) */
DECLARE
   vcurrent_size      NUMBER;
   vtheorical_size    NUMBER;
   vgain              NUMBER;
   vpercentage_gain   NUMBER;

   FUNCTION format_size (value1 IN NUMBER)
      RETURN VARCHAR2
   AS
   BEGIN
      CASE
         WHEN (value1 > 1024 * 1024 * 1024)
         THEN
            RETURN LTRIM (
                         TO_CHAR (value1 / (1024 * 1024 * 1024),
                                  '999,999.999')
                      || 'GB');
         WHEN (value1 > 1024 * 1024)
         THEN
            RETURN LTRIM (
                      TO_CHAR (value1 / (1024 * 1024), '999,999.999') || 'MB');
         WHEN (value1 > 1024)
         THEN
            RETURN LTRIM (TO_CHAR (value1 / (1024), '999,999.999') || 'KB');
         ELSE
            RETURN LTRIM (TO_CHAR (value1, '999,999.999') || 'B');
      END CASE;
   END format_size;
BEGIN
   SELECT a.blocks * b.block_size,
          a.num_rows * a.avg_row_len,
          (a.blocks * b.block_size) - (a.num_rows * a.avg_row_len),
            (  ( (a.blocks * b.block_size) - (a.num_rows * a.avg_row_len))
             * 100
             / (a.blocks * b.block_size))
          - a.pct_free
     INTO vcurrent_size,
          vtheorical_size,
          vgain,
          vpercentage_gain
     FROM dba_tables a, dba_tablespaces b
    WHERE     a.tablespace_name = b.tablespace_name
          AND owner = UPPER ('&1.')
          AND table_name = UPPER ('&2.');

   DBMS_OUTPUT.put_line (
      'For table ' || UPPER ('&1.') || '.' || UPPER ('&2.'));
   DBMS_OUTPUT.put_line (
      'Current table size: ' || format_size (vcurrent_size));
   DBMS_OUTPUT.put_line (
      'Theoretical table size: ' || format_size (vtheorical_size));
   DBMS_OUTPUT.put_line ('Potential saving: ' || format_size (vgain));
   DBMS_OUTPUT.put_line (
      'Potential saving percentage: ' || ROUND (vpercentage_gain, 2) || '%');
END;
/
