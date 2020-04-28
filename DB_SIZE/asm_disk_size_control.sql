SELECT G.NAME,
       round(sum(b.total_mb)/1024,2)                                  total_gb,
       round(sum((b.total_mb - b.free_mb))/1024,2)     used_gb,
       round(sum(B.FREE_MB)/1024,2)   free_gb,
       decode(sum(b.total_mb),0,0,(ROUND((1- (sum(b.free_mb) / sum(b.total_mb)))*100, 2)))      pct_used,
       decode(sum(b.total_mb),0,0,(ROUND(((sum(b.free_mb) / sum(b.total_mb)))*100, 2)))      pct_free
FROM
     v$asm_disk b,v$asm_diskgroup g
where b.group_number = g.group_number (+)
group by g.name;
