select tabs.table_name,
  trigs.trigger_name,
  seqs.sequence_name
from dba_tables tabs
join dba_triggers trigs
  on trigs.table_owner = tabs.owner
  and trigs.table_name = tabs.table_name
join dba_dependencies deps
  on deps.owner = trigs.owner
  and deps.name = trigs.trigger_name
join dba_sequences seqs
  on seqs.sequence_owner = deps.referenced_owner
  and seqs.sequence_name = deps.referenced_name
where tabs.owner = <'SCHEME_NAME'>;
