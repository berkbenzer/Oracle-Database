BEGIN
  DBMS_NETWORK_ACL_ADMIN.create_acl (
    acl          => 'open_acl_file.xml', 
    description  => 'A test of the ACL functionality',
    principal    => 'TEST',
    is_grant     => TRUE, 
    privilege    => 'connect',
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);

  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => 'open_acl_file.xml',
    host        => '*', 
    lower_port  => 1,
    upper_port  => 9999); 

  COMMIT;
END;
/
