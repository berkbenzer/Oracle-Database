select count(*) from  ORDERS.PAYMENT_DETAILS;

create table ORDERS.PAYMENT_DETAILS_1 AS  select * from    ORDERS.PAYMENT_DETAILS;


alter table orders.PAYMENT_DETAILS_1 enable row movement;

delete from ORDERS.PAYMENT_DETAILS_1;


select current_scn from v$database;


flashback table ORDERS.PAYMENT_DETAILS_1 to scn 8302524;



flashback table ORDERS.PAYMENT_DETAILS_1 to timestamp (systimestamp - interval '1' minute); 
