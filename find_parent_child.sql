SELECT c.table_name CHILD_TABLE, p.table_name PARENT_TABLE
FROM dba_constraints p, dba_constraints c
WHERE (p.constraint_type = 'P' OR p.constraint_type = 'U')
AND c.constraint_type = 'R'
AND p.constraint_name = c.r_constraint_name
AND c.table_name = 'xxx'
and c.owner='yyy';
