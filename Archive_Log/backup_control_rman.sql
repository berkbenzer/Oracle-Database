list backup summary;



List of Backups
===============
Key     TY LV S Device Type Completion Time #Pieces #Copies Compressed Tag
------- -- -- - ----------- --------------- ------- ------- ---------- ---
109041  B  A  A DISK        07-AUG-22       1       1       YES        AUTO_ARCHIVE
109046  B  A  A DISK        07-AUG-22       1       1       YES        AUTO_ARCHIVE
109051  B  A  A DISK        07-AUG-22       1       1       YES        AUTO_ARCHIVE
109056  B  A  A DISK        07-AUG-22       1       1       YES        AUTO_ARCHIVE
109061  B  A  A DISK        07-AUG-22       1       1       YES        AUTO_ARCHIVE
109066  B  A  A DISK        07-AUG-22       1       1       YES        AUTO_ARCHIVE
109071  B  A  A DISK        07-AUG-22       1       1       YES        AUTO_ARCHIVE
109076  B  0  A DISK        07-AUG-22       2       1       YES        L0_20220807_085701
109077  B  A  A DISK        07-AUG-22       1       1       YES        AUTO_ARCHIVE



##############

list backup of archivelog all;
List of Backup Sets
===================
BS Key  Size       Device Type Elapsed Time Completion Time
------- ---------- ----------- ------------ --------------------
43      2.49M      DISK        00:00:00     20-MAR-2014 21:02:30
        BP Key: 43   Status: AVAILABLE  Compressed: YES  Tag: AINC0_THU20
        Piece Name: /oradata/backup/DB01_1470673955_20140320_21p3m7b6_1_1.inc0
  List of Archived Logs in backup set 43
  Thrd Seq     Low SCN    Low Time             Next SCN   Next Time
  ---- ------- ---------- -------------------- ---------- ---------
  1    53      1013038    20-MAR-2014 16:31:34 1019638    20-MAR-2014 20:58:44
  1    54      1019638    20-MAR-2014 20:58:44 1019722    20-MAR-2014 20:59:53
  1    55      1019722    20-MAR-2014 20:59:53 1019884    20-MAR-2014 21:01:19
  1    56      1019884    20-MAR-2014 21:01:19 1019955    20-MAR-2014 21:02:29
