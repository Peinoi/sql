alter session set "_ORACLE_SCRIPT"=true;

CREATE USER scott
IDENTIFIED BY tiger
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;

GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE
TO scott;


SELECT * FROM tab;
SELECT * FROM dba_users
order by username;


select * from dba_users
where username = 'SCOTT';

ALTER USER SCOTT ACCOUNT UNLOCK;

grant create view to scott;