/*
1- DUMMY BIR KULLANICI OLUSTURUP, GEREKEN HAKLARI VERIYORUZ
*/
create user rquser identified by welcome1;

CREATE TABLESPACE rquser DATAFILE 
  '/home/oracle/dbfile/rquser.dbf' SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;
-------------------------------------------------------------------------------
/*
2- ARDINDAN KULLANICI ALTINDA, BIR TABLO VE BU TABLOYA AIT INDEX YARATILIR
*/

CREATE TABLE RQUSER.DUMMY_TABLE AS SELECT * FROM ALL_OBJECTS;

CREATE INDEX RQUSER.DUMMY_IDX01 ON RQUSER.DUMMY_TABLE( OBJECT_ID );

-------------------------------------------------------------------------------
/*
3- INDEX IZLEME ISLEMI BASLATILIYOR
*/


ALTER INDEX RQUSER.DUMMY_IDX01 MONITORING USAGE;


-------------------------------------------------------------------------------
 /*
4- Aşağıda yazdığım sorguyu kullanarak, index kullanım durumunu görebiliriz.

INDEX KULLANIMINI ASAGIDAKI GIBI SORGULAYABILIRIZ
12c ONCESI VERITABANLARI ICIN V$OBJECT_USAGE VIEW'I KULLANILMALIDIR.
*/
 
 select   owner||'.'||index_name as index_name, 
        used, 
        start_monitoring, 
        end_monitoring 
from     DBA_OBJECT_USAGE; 

/*
INDEX IZLEME AKTIF AMA HENUZ HIC KULLANILMAMIS

RQUSER.DUMMY_IDX01    NO    07/03/2019 15:56:26    
*/


-------------------------------------------------------------------------------

/* 
5- INDEX KULLANACAK BIR SORGU CALISTIRIYORUZ
 SORGU CALISTIKTAN SONRA, ARTIK USED SUTUNUNU YES GEREKIYORUZ
*/

select count(*) from rquser.dummy_table where object_id = 1;
 
 select     owner||'.'||index_name as index_name, 
        used, 
        start_monitoring, 
        end_monitoring 
from     DBA_OBJECT_USAGE;

-------------------------------------------------------------------------------
/* 
6- DILERSEK INDEX MONITOR'LEME ISLEMINI ASAGIDAKI GIBI KAPATABILIRIZ
*/

alter index rquser.dummy_idx01 nomonitoring usage;


 select     owner||'.'||index_name as index_name, 
        used, 
        start_monitoring, 
        end_monitoring 
from     DBA_OBJECT_USAGE;

--RQUSER.DUMMY_IDX01    YES    07/03/2019 15:56:26    07/03/2019 15:59:24
-------------------------------------------------------------------------------
/*
7- Şimdi de kapattığımız monitoring işlemini tekrar aktive edelim. 
Tekrar aktivasyon yapıldığında, kullanım durumu 'NO' oluyor. Index'i kullanacak bir 
sorgu gelene kadar da, USED sütunu aynı şekilde kalıyor.

-- TEKRAR INDEX IZLEME BASLATMAK ISTERSEK
-- AYNI IFADEYI CALISTIRIYORUZ
*/

alter index rquser.dummy_idx01 monitoring usage;

 select     owner||'.'||index_name as index_name, 
        used, 
        start_monitoring, 
        end_monitoring 
from     DBA_OBJECT_USAGE;

--RQUSER.DUMMY_IDX01    NO    07/03/2019 16:00:46    
-------------------------------------------------------------------------------
/*
8- Index'ın kullanılmadıgına karar verdık ve INDEX INVISIBLE YAPILIYOR
*/

ALTER INDEX RQUSER.DUMMY_IDX01 INVISIBLE;
-------------------------------------------------------------------------------
/*
9- Index'i gizli hâle aldık ama henüz drop etmedik. Günün birinde bir kullanıcı çıkıp, 
performans sorunu olduğunu söyledi. 
Sorunun kapatılan index'ten olduğunu düşünmüyorsunuz; fakat index'i kullanıp, test etmek lâzım. 
Bu durumda, genele açmadan, sadece kendi oturumunuzdan index'i görülebilir yapabilirsiniz.
*/


select count(*) from rquser.dummy_table where object_id = 1;


/*
Plan hash value: 2784313200
 
----------------------------------------------------------------------------------
| Id  | Operation          | Name        | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |             |     1 |     5 |   394   (1)| 00:00:01 |
|   1 |  SORT AGGREGATE    |             |     1 |     5 |            |          |
|*  2 |   TABLE ACCESS FULL| DUMMY_TABLE |     1 |     5 |   394   (1)| 00:00:01 |
----------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):

*/

-------------------------------------------------------------------------------

/*
10- Büyük bir tablonuz olduğunu düşünelim. 
Bu büyük tablo üzerinde bir index yaratmayı düşünüyorsunuz ama gelecek sorguların bunu kullanıp-kullanmayacağından emin değilsiniz. 
Bu index'i oluşturmadan, optimizer'ın davranışını nasıl kestirebiliriz? Bunun da güzel bir yolu var: Sanal Index yaratmak... Kullanımına gelirsek,
ONCELIKLE ASAGIDAKI SORGUNUN PLANINA BAKIYORUZ
*/

select count(*) from rquser.dummy_table where OBJECT_NAME = 'DENEME';

/*
Plan hash value: 2784313200
 
----------------------------------------------------------------------------------
| Id  | Operation          | Name        | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |             |     1 |    35 |   394   (1)| 00:00:01 |
|   1 |  SORT AGGREGATE    |             |     1 |    35 |            |          |
|*  2 |   TABLE ACCESS FULL| DUMMY_TABLE |     1 |    35 |   394   (1)| 00:00:01 |

*/

CREATE INDEX RQUSER.DUMMY_IDX02 ON RQUSER.DUMMY_TABLE( OBJECT_NAME ) NOSEGMENT;

-- INDEX BOYUTU KONTROL EDILIYOR
select count(*) from dba_indexes where index_name='DUMMY_IDX02'

alter session set "_use_nosegment_indexes"=true;

select count(*) from rquser.dummy_table where OBJECT_NAME = 'DENEME';

/*
Plan hash value: 4247231693
 
---------------------------------------------------------------------------------
| Id  | Operation         | Name        | Rows  | Bytes | Cost (%CPU)| Time     |
---------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |             |     1 |    35 |     1   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE   |             |     1 |    35 |            |          |
|*  2 |   INDEX RANGE SCAN| DUMMY_IDX02 |     1 |    35 |     1   (0)| 00:00:01 |
---------------------------------------------------------------------------------
*/


/*Yaratılan index, aslında fiziksel anlamda hiç yaratılmadı. Fakat dictionary tanımı mevcut. 
Bu nedenle işiniz bittiğinde, isim çakışmaması olmaması için index'i drop etmek doğru olur. Standart bir index drop 
işleminden hiçbir farkı olmadığını aşağıda göreceksiniz:
*/

DROP INDEX RQUSER.DUMMY_IDX02;
