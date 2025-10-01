--<-------------- 평가 ----------------------------->
SELECT * FROM COUNTRIES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;
SELECT * FROM JOB_HISTORY;
SELECT * FROM JOBS;
SELECT * FROM LOCATIONS;
SELECT * FROM REGIONS;

-- 문제 1번
SELECT EMPLOYEE_ID AS "사원 번호"
    , last_name as "이름"
    , DEPARTMENT_ID as "부서 번호"
FROM employees
WHERE SALARY BETWEEN 7000 AND 12000
AND last_name LIKE 'H%';

-- 문제 2번
SELECT EMPLOYEE_ID AS "사원 번호"
    , first_name || ' ' ||last_name as "이름"
    , job_id as "업무"
    , salary as "급여"
    , DEPARTMENT_ID as "부서 번호"
FROM employees
WHERE (DEPARTMENT_ID = 50 OR DEPARTMENT_ID =60)
AND SALARY > 5000
;

--문제 3번
SELECT  first_name || ' ' ||last_name as "이름"
   , salary as "급여"
   , case 
    when salary >15000 then salary  
    when salary BETWEEN 10001 AND 15000 then salary + salary* 0.1    
    when salary BETWEEN 5001 AND 10000 then salary + salary* 0.15
    when salary <=5000 then salary + salary* 0.2
    end
    as "인상된 급여"
FROM EMPLOYEES
WHERE EMPLOYEE_ID = &EMPLOYEE_ID
;


--문제 4번
SELECT D.DEPARTMENT_ID as "부서 번호"
    ,D.DEPARTMENT_NAME as "부서 이름"
    ,L.CITY as "도시명"
FROM DEPARTMENTS d
JOIN LOCATIONS l
ON D.LOCATION_ID = L.LOCATION_ID
;

--문제 5번
SELECT e.DEPARTMENT_ID
    ,e.LAST_NAME
    ,e.JOB_ID
FROM employees e
WHERE e.DEPARTMENT_ID =
(SELECT D.DEPARTMENT_ID FROM DEPARTMENTS d 
WHERE DEPARTMENT_NAME = 'IT' 
);


--문제 6번
SELECT *
FROM employees
WHERE HIRE_DATE < '2014/01/01'
AND JOB_ID = 'ST_CLERK'
;

--문제 7번
SELECT last_name
    ,job_id
    ,salary
    ,substr(COMMISSION_PCT,1,2) as "COMMISSION_PCT"
FROM employees
WHERE commission_pct is not null
order by salary desc
;

--문제 8번
CREATE TABLE PROF(
    PROFNO number(4),
    NAME varchar2(15) NOT NULL,
    ID varchar2(15) NOT NULL,
    HIREDATE DATE,
    PAY number(4) 
); 
SELECT * FROM PROF;
--drop table prof purge;
--문제 9번
-- 9-1번
INSERT INTO PROF VALUES(1001, 'MARK', 'm1001', to_date('07/03/01','rr/mm/dd'),800);
INSERT INTO PROF VALUES(1003, 'Adam', 'a1003', to_date('11/03/02','yy/mm/dd'), 0);
commit;
-- 9-2번
update prof set pay = 1200 where profno = 1001;
-- 9-3번
delete prof where profno = 1003;


--문제 10번
-- 10-1번
ALTER TABLE Prof ADD CONSTRAINT prof_pk PRIMARY KEY (profno);
-- 10-2번
ALTER TABLE prof ADD GENDER CHAR(3) default ' ';
-- 10-3번
ALTER TABLE prof MODIFY NAME VARCHAR2(20);


