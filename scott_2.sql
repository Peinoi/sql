SELECT *
FROM tab;

SELECT 
    sysdate, to_char(sysdate, 'rrrr/mm/dd') as "system" 
    ,to_char(1234,'99,999.99') as "num" -- 문자 변환 후 표기 방식
FROM dual;

SELECT empno
    ,ename
    ,job
    ,to_char(sal,'99,999.99') as "salary"
    FROM emp;

SELECT *
FROM professor
    where hiredate BETWEEN 
    to_date('1990/01/01 09:00:00','rrrr/mm/dd hh24:mi:ss') and
    to_date('1999/12/31 00:00:00','rrrr/mm/dd hh24:mi:ss')
order by hiredate 
;

SELECT * 
FROM emp
where sal + nvl(comm , 0) >= 2000 
;


SELECT profno
    ,name
    ,pay
    ,bonus
    ,to_char((pay*12) + nvl(bonus,0),'99,999') as "total"
FROM professor
where deptno = 201
;

SELECT profno
    ,name
    ,nvl2(bonus, (pay*12)+bonus,(pay*12)) as "total"
FROM professor;

SELECT empno
    ,ename
    ,comm
    ,nvl2(comm,'Exist','NULL') as "NVL2"
FROM emp
where deptno = 30;

--sal > 30 ? '값' : '값2'

SELECT empno
    ,ename
    ,DECODE(job, 'SALESMAN', '영업부서', decode(job, 'MANAGER', '관리부서', '기타부서')) as "부서" 
FROM emp;

SELECT NAME
    ,JUMIN
    ,decode(substr(jumin,7,1), '1' , 'man', 'woman' ) as "GENDER"
FROM STUDENT
where deptno1 = 101;


SELECT NAME
    ,JUMIN
    ,decode(
    substr(tel,0,instr(tel,')')-1)
    , '02' , 'SEOUL'
    , '031', 'GYEONGGL'
    , '051', 'BUSAN'
    , '052', 'ULSAN'
    , '055', 'GYEONGNAM'
    ) as "LOC"
FROM STUDENT
where deptno1 = 101;

SELECT NAME
    ,TEL
    ,CASE substr(tel,0,instr(tel,')')-1)
        WHEN '02' THEN 'SEOUL'
        WHEN '031' THEN 'GYEONGGL'
        WHEN '051' THEN 'BUSAN'
        WHEN '052' THEN 'ULSAN'
        WHEN '055' THEN 'GYEONGNAM'
                   ELSE 'ETC'        
        END "LOC"
FROM STUDENT;

SELECT 
    PROFNO
    ,NAME
    ,POSITION
    ,pay*12
    ,CASE WHEN PAY * 12 > 5000 THEN 'High'
        WHEN PAY*12 > 4000 THEN 'MID'
        WHEN PAY*12 > 3000 THEN 'LOW'
        ELSE 'Etc'
        END AS "SAL"
FROM PROFESSOR;

SELECT NAME
    ,SUBSTR(JUMIN,3,2)
    AS "MONT"
    ,CASE 
    WHEN SUBSTR(JUMIN,3,2) BETWEEN 01 AND 03 THEN '1/4'
    WHEN SUBSTR(JUMIN,3,2) BETWEEN 04 AND 06 THEN '2/4'
    WHEN SUBSTR(JUMIN,3,2) BETWEEN 07 AND 09 THEN '3/4'
    ELSE '4/4'
    END 
    AS "Qua"
FROM STUDENT;



SELECT EMPNO
    ,ENAME
    ,SAL
    ,CASE 
    WHEN SAL <=1000 THEN 'LEVEL 1'
    WHEN SAL <=2000 THEN 'LEVEL 2'
    WHEN SAL <=3000 THEN 'LEVEL 3'
    WHEN SAL <=4000 THEN 'LEVEL 4'
    WHEN SAL <=5000 THEN 'LEVEL 5'
    ELSE 'ETC'
    END
    AS "LEVEL"
FROM EMP
ORDER BY SAL DESC;

SELECT PROFNO, NAME, 'PROFESSON' ,PAY FROM PROFESSOR
WHERE DEPTNO = 101
UNION
SELECT STUDNO, NAME , 'STUDENT' , 0
FROM STUDENT
WHERE DEPTNO1 = 101;

SELECT
    MIN(JOB)
--    ,MAX(JOB)
    ,COUNT(*) AS "인원"
    ,SUM(SAL) AS "직무 급여 합계"
    ,AVG(SAL) AS "급여 평균"
    ,STDDEV(SAL) AS "표준편차"
    ,VARIANCE(SAL) AS "분산"
FROM EMP
GROUP BY JOB 
;

SELECT TO_CHAR(HIREDATE, 'RRRR')AS"HD", COUNT(*) AS "인원"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'RRRR') ;

--학생 , 학과별 인원

SELECT  
    DEPTNO1,
    COUNT(*)
FROM STUDENT
GROUP BY DEPTNO1
HAVING COUNT(*) > 2
; --그룹 바이 안의 조건문 HAVING

--교수 , POSITION, SUM(PAY), MAX(PAY), MIN(PAY)
SELECT 
    POSITION AS "역활"
    ,SUM(PAY) AS "급여 합계"
    ,MAX(PAY) AS "최고 급여"
    ,MIN(PAY) AS "최저 급여"
FROM PROFESSOR
GROUP BY position;

--직원 부서별 급여 평균과 인원
-- 사원, 부서, 직무별 평균 급여, 인원

-- UNION 연습

-- 부서, 직무, 급여, 인원
-- 부서        급여, 인원
-- 부서, 직무, 급여, 인원
-- 부서        급여, 인원
--             급여, 인원

SELECT 
    DEPTNO
     ,NULL
     ,ROUND(AVG(SAL)) 
    ,COUNT(*) , 'a'
FROM EMP
GROUP BY DEPTNO
UNION
SELECT
    DEPTNO
    ,JOB
    ,ROUND(AVG(SAL)) 
    ,COUNT(*), 'b'
FROM EMP
GROUP BY DEPTNO, JOB
UNION
SELECT 
    NULL, NULL
    ,ROUND(AVG(SAL))    
    ,COUNT(*),'c'
FROM EMP
ORDER BY 1, 2 -- 1번 컬럼, 2번 컬럼
;


-- ROLLUP , cube 
-- 롤업은 각각의 소급룹과 전체 합계 (주로쓰임)
-- 큐브는 각 항목간의 다차원적 소계를 계산
SELECT NVL(TO_CHAR(DEPTNO),'전체') AS "부서"
    ,NVL(JOB,'합계') AS "직무"
    ,ROUND(AVG(SAL)) AS "평균 급여"
    ,COUNT(*) AS "사원 수"
FROM EMP
GROUP BY rollup(DEPTNO, JOB)
ORDER BY 1, 2;

select count(*) from emp; ----12
select count(*) from dept; ----4

SELECT count(*) -- dept.*, emp.*
FROM emp
join dept
on emp.deptno = dept.deptno
;

SELECT 
    studno    
    ,S.name AS "학생명"
    ,S.grade
    ,NVL(P.name, '배정 대기중') AS "교수명"
    , S.DEPTNO1
    , D.DNAME AS "학과명"
FROM student S
LEFT OUTER join professor P ON S.profno = P.profno
JOIN DEPARTMENT D
ON S.DEPTNO1 = D.DEPTNO
;

SELECT p.profno, p.name , s.studno, s.name, s.profno as"담당교수"
FROM professor p left outer join student s on p.profno = s.profno
;

SELECT * FROM 
  salgrade 

  ;
  
SELECT s.grade, e.*
FROM EMP e
join salgrade s
on e.sal >= s.losal
and e.sal <= s.hisal
 s.grade = 2
;


SELECT e.*, d.*
FROM emp e, dept d
where e.deptno = d.deptno;


SELECT 
    e1.empno as"사번"
    ,e1.ename as "사원명"
    ,e1.empno as"관리자번호"
    ,e1.ename as"관리자 이름"
FROM emp e1, emp e2
where e1.mgr = e2.empno(+)
;

--연습문제 1
select s.name as "STU_NAME"
    ,s.deptno1 
    ,d.dname
from student s 
join department d on s.deptno1 = d.deptno;

select s.name as "STU_NAME"
    ,s.deptno1 
    ,d.dname
from student s, department d 
where s.deptno1 = d.deptno;


--연습문제 2

SELECT position FROM p_grade;
SELECT e.name
        ,e.position
        ,to_char(e.pay,'999,999,999') as "PAY"
        ,to_char(s_pay,'999,999,999') AS "LOW PAY"       
        ,to_char(E_pay,'999,999,999') AS "HIGH PAY"       
FROM emp2 e
join p_grade p on e.position = p.position
where e.position is not null ;

--연습문제 3

select 
    e.name
    ,trunc(MONTHS_BETWEEN('2014/01/01', e.birthday) / 12) as "AGE"
    ,nvl(e.position,' ') as "BE_POSITION"
    ,case
        WHEN trunc(MONTHS_BETWEEN('2014/01/01', e.birthday) / 12) BETWEEN 0 AND 24 THEN 'Manager'
        WHEN trunc(MONTHS_BETWEEN('2014/01/01', e.birthday) / 12) BETWEEN 25 AND 28 THEN 'Deputy Section chief'
        WHEN trunc(MONTHS_BETWEEN('2014/01/01', e.birthday) / 12) BETWEEN 29 AND 32 THEN 'Section head'
        WHEN trunc(MONTHS_BETWEEN('2014/01/01', e.birthday) / 12) BETWEEN 33 AND 36 THEN 'Deputy department head'
        WHEN trunc(MONTHS_BETWEEN('2014/01/01', e.birthday) / 12) BETWEEN 37 AND 40 THEN 'Department head'
        WHEN trunc(MONTHS_BETWEEN('2014/01/01', e.birthday) / 12) BETWEEN 41 AND 55 THEN 'Director'
        ELSE 'ETC'
        END AS "BE_POSITION"
from emp2 e 
LEFT OUTER join p_grade p 
on e.position = p.position
order by age
;


select *
from emp2;
select * from p_grade;
    
--연습문제 4
select * from customer;
select * from gift;

select 
    c.gname as "CUST_NAME"
    ,c.point
    ,decode(g.gname,'Notebook','NotebooK','Notebook') as "GIFT_NAME"
from customer c, gift g
where c.point between g.g_start and g.g_end
and c.point > 600000 
;

--연습문제 5
select * from professor;
select 
    p1.profno
    ,p1.name
    ,trunc(MONTHS_BETWEEN(SYSDATE, p1.hiredate) / 12)
    ,p1.hiredate
    ,COUNT()  as "COUNT"
FROM PROFESSOR p1, professor p2 
where p1.profno = p2.profno
GROUP BY P1.HIREDATE
order by HIREDATE;
