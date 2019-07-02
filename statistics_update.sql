exec dbms_stats.create_stat_table(user,'U_001_01_INVOICES_stat1')

exec dbms_stats.create_stat_table(user,'U_001_01_LCONNPOSTBOX_stat1')




exec dbms_stats.export_table_stats('LOGO','U_001_01_LCONNPOSTBOX',NULL,'LCONNPOSTBOX_stat1')

 exec dbms_stats.export_table_stats('LOGO','U_001_01_INVOICES',NULL,'INVOICES_stat1')


exec dbms_stats.export_table_stats(LOGO,'U_001_01_INVOICES_stat1',NULL,'LOGO')

exec dbms_stats.export_table_stats(LOGO,'U_001_01_LCONNPOSTBOX_stat1',NULL,'LOGO')






begin

  dbms_stats.gather_table_stats (ownname => 'LOGO', tabname => 'U_001_01_INVOICES',

  estimate_percent => dbms_stats.auto_sample_size,

  method_opt => 'for all columns size auto', cascade => true, degree => 16);

end;

/
