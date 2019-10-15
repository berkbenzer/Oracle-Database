/* Formatted on 15-Oct-19 11:39:05 AM (QP5 v5.269.14213.34769) */
SELECT LOGID,
       DBMS_LOB.SUBSTR (sendxml, 3000),
       DBMS_LOB.SUBSTR (RESPXML, 3000),
       SERVICENAME,
       LOG_TARIHI
  FROM besprod.xxx_log
 WHERE servicename = 'TABLO_ADI' 
 AND log_tarihi >= '01/05/2019'
