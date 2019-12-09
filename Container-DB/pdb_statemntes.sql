COLUMN name FORMAT A30

SELECT name, pdb
FROM   v$services
ORDER BY name;
