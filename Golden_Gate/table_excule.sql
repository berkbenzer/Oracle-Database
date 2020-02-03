--edit the parameter from extract process

xxxx.tr.xcd.net.intra) 28> edit params EXXXX

--add following line to params Extract configuration save and quit
TABLEEXCLUDE XXXX.XXXXX
TABLEEXCLUDE XXXX.XXXXX1



-- edit parameter Replicat process with two table

xxxx1.tr.xcd.net.intra) 28> edit params RXXXX1

--01.02.2020
MAPEXCLUDE XXXX.XXXXX
MAPEXCLUDE XXXX.XXXXX1


--Restart Extract process
xxx.tr.xcd.net.intra) 15> stop EXTRACT EXTRACT

Sending STOP request to EXTRACT EXTRACT ...

There are open, long-running transactions. Before you stop Extract, make the archives containing data for those transactions available for when Extract restarts. To force Extract to stop, use the SEND EXTRACT EXTRACT, FORCESTOP command.
.


--there is a long transaction which is blocking to the stop process

GSCI (xxx.tr.xcd.net.intra) 16> send EXTRACT EXTRACT, showtrans duration 20 MIN

Sending showtrans request to EXTRACT EXTRACT ...



------------------------------------------------------------
XID:                  80.23.1953389         
Items:                0        
Extract:              EXTRACT  
Redo Thread:          2      
Start Time:           2020-02-02:17:40:14  
SCN:                  2634.2160879077 (11315104736741)  
Redo Seq:             36661
Redo RBA:             1122211856          
Status:               Running             




GGSCI (xxx.tr.xcd.net.intra) 19> send EXTRACT EXTRACT, FORCESTOP

Sending FORCESTOP request to EXTRACT EXTRACT ...
Request processed.


GGSCI (xxx.tr.xcd.net.intra) 20> info all

Program     Status      Group       Lag at Chkpt  Time Since Chkpt

MANAGER     RUNNING                                           
EXTRACT     STOPPED     EXTRACT    00:00:04      00:00:07    


GGSCI (xxx.tr.xcd.net.intra) 20> start EXTRACT

GGSCI (xxx.tr.xcd.net.intra)31> info all

Program     Status      Group       Lag at Chkpt  Time Since Chkpt

MANAGER     RUNNING                                           
EXTRACT     RUNNING     EXTRACT    00:00:02      00:00:21   


---restart the Replicat process






