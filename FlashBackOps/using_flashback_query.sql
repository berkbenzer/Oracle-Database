

CREATE TABLE bbenzer.flashback_query_test (id NUMBER(10), name VARCHAR(50));


INSERT INTO bbenzer.flashback_query_test VALUES (1, 'Hello World!');
INSERT INTO bbenzer.flashback_query_test VALUES (2, 'This is a table row!');
INSERT INTO bbenzer.flashback_query_test VALUES (3, '#Another One!');
COMMIT;

SELECT * FROM bbenzer.flashback_query_test ;



SELECT SYSTIMESTAMP FROM dual;
--13/KAS/19 10:37:21.841120 ÖÖ +02:00



SELECT * FROM bbenzer.flashback_query_test AS OF TIMESTAMP TO_TIMESTAMP('13/KAS/19 10:37:21.841120 ÖÖ');
