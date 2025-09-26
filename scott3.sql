--<------------------------3일차 DML ----------------------------------->
SELECT * 
FROM dept2
ORDER BY dcode ;

INSERT INTO dept2 (dcode, pdept, dname, area)
VALUES('9001','temp_2','1006','temp area'
);

CREATE TABLE professor3
as
SELECT * FROM professor
where 1 = 2;

SELECT * FROM professor
where 1 = 2; --false 용어 =>(CTAS)

SELECT * FROM professor3;

INSERT INTO professor3
SELECT * FROM professor; -- 용어 =>(ITAS)

ROLLBACK;

CREATE TABLE prof_1 (
    profno number,
    name varchar2(25)
);

CREATE TABLE prof_2 (
    profno number,
    name varchar2(25)
);

-- INSERT 

INSERT ALL
WHEN profno BETWEEN 1000 AND 1999 THEN INTO prof_1 VALUES (profno,name)
WHEN profno BETWEEN 2000 AND 2999 THEN INTO prof_2 VALUES (profno,name)
SELECT profno, name
FROM professor;

INSERT ALL
    INTO prof_1 VALUES (profno,name)    
    INTO prof_2 VALUES (profno,name)
SELECT profno, name
FROM professor;

SELECT * FROM prof_2;

-- UPDATE
SELECT * FROM professor;

UPDATE professor
SET BONUS = DECODE(BONUS, NULL , 100, BONUS)
    ,PAY = PAY + (PAY * 0.1)
    ,HPAGE = DECODE(HPAGE, NULL, 
    'http://www.'|| SUBSTR(EMAIL,INSTR(EMAIL,'@')+1) 
    ,HPAGE)
WHERE 1=1 ;

--DELETE
DELETE FROM professor
where hpage is not null
;

SELECT * FROM dept;

DELETE dept where deptno = 30;

SELECT * FROM emp
where deptno = 30
;
delete emp
where deptno = 30
;

--UPDATE

SELECT * FROM EMP;
SELECT * FROM dept;

UPDATE EMP SET deptno = 50
where deptno = 20;

--emp 조회시 이름, 부서, 부서지역
SELECT 
    ename
    ,e.sal
    ,e.job
    ,d.loc
FROM EMP e 
JOIN dept d ON e.deptno = d.deptno;

update emp e
SET SAL = SAL +100
WHERE EXISTS (SELECT 1
                FROM dept d 
                where e.deptno = d.deptno
                and d.loc = 'DALLAS')
;


--<--------------------------- 게시판, 회원가입, 상품관리 ---------------------------------------------->
-- 오라클 서버 --- 웹서버(노드) -- 클라이언트  

select * from emp;

