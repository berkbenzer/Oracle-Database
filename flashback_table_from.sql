

select * from ORDERS.PAYMENT_DETAILS_11; 

--no rows selected

ALTER TABLE ORDERS.PAYMENT_DETAILS_11 ENABLE ROW MOVEMENT;

insert into ORDERS.PAYMENT_DETAILS_11  select * from   ORDERS.PAYMENT_DETAILS_1 where CARD_STRING IN ('778646','778647','778648')  ;

select * from  ORDERS.PAYMENT_DETAILS_11;

/*
778646	C	qwe	sdfdsf	252426586660	234	ewrewrewrewrwerewrewrewrewr
778647	A	qwe	asd	252426910847	234	wer
778648	A	qweq	asd	252427235034	234	gfdgfdg
*/

DELETE FROM ORDERS.PAYMENT_DETAILS_11 WHERE CARD_STRING IN ('778647','778648');


select * from  ORDERS.PAYMENT_DETAILS_11;
--778646	C	qwe	sdfdsf	252426586660	234	ewrewrewrewrwerewrewrewrewr



FLASHBACK TABLE ORDERS.PAYMENT_DETAILS_11 TO TIMESTAMP
TO_TIMESTAMP('02-08-2019 09:18:00','DD-MM-YYYY HH24:MI:SS');

select * from ORDERS.PAYMENT_DETAILS_11;

/*

778646	C	qwe	sdfdsf	252426586660	234	ewrewrewrewrwerewrewrewrewr
778647	A	qwe	asd	252426910847	234	wer
778648	A	qweq	asd	252427235034	234	gfdgfdg

*/


ALTER TABLE ORDERS.PAYMENT_DETAILS_11 DISABLE ROW MOVEMENT;
/*
It will necessarily consume processing resources on your machine while running (it will read the table, 
it will delete/insert the rows at the bottom of the table to move them up, it will generate redo, it will generate undo).
*/


