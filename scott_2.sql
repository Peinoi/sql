SELECT
    *
FROM
    tab;

SELECT
    sysdate,
    to_char(sysdate, 'rrrr/mm/dd') AS "system",
    to_char(1234, '99,999.99')     AS "num" -- 문자 변환 후 표기 방식
FROM
    dual;

SELECT
    empno,
    ename,
    job,
    to_char(sal, '99,999.99') AS "salary"
FROM
    emp;

SELECT
    *
FROM
    professor
WHERE
    hiredate BETWEEN TO_DATE('1990/01/01 09:00:00', 'rrrr/mm/dd hh24:mi:ss') AND TO_DATE('1999/12/31 00:00:00', 'rrrr/mm/dd hh24:mi:ss'
    )
ORDER BY
    hiredate;

SELECT
    *
FROM
    emp
WHERE
    sal + nvl(comm, 0) >= 2000;

SELECT
    profno,
    name,
    pay,
    bonus,
    to_char((pay * 12) + nvl(bonus, 0),
            '99,999') AS "total"
FROM
    professor
WHERE
    deptno = 201;

SELECT
    profno,
    name,
    nvl2(bonus,(pay * 12) + bonus,(pay * 12)) AS "total"
FROM
    professor;

SELECT
    empno,
    ename,
    comm,
    nvl2(comm, 'Exist', 'NULL') AS "NVL2"
FROM
    emp
WHERE
    deptno = 30;

--sal > 30 ? '값' : '값2'

SELECT
    empno,
    ename,
    decode(job,
           'SALESMAN',
           '영업부서',
           decode(job, 'MANAGER', '관리부서', '기타부서')) AS "부서"
FROM
    emp;

SELECT
    name,
    jumin,
    decode(
        substr(jumin, 7, 1),
        '1',
        'man',
        'woman'
    ) AS "GENDER"
FROM
    student
WHERE
    deptno1 = 101;

SELECT
    name,
    jumin,
    decode(
        substr(tel,
               0,
               instr(tel, ')') - 1),
        '02',
        'SEOUL',
        '031',
        'GYEONGGL',
        '051',
        'BUSAN',
        '052',
        'ULSAN',
        '055',
        'GYEONGNAM'
    ) AS "LOC"
FROM
    student
WHERE
    deptno1 = 101;

SELECT
    name,
    tel,
    CASE substr(tel,
                0,
                instr(tel, ')') - 1)
        WHEN '02'  THEN
            'SEOUL'
        WHEN '031' THEN
            'GYEONGGL'
        WHEN '051' THEN
            'BUSAN'
        WHEN '052' THEN
            'ULSAN'
        WHEN '055' THEN
            'GYEONGNAM'
        ELSE
            'ETC'
    END "LOC"
FROM
    student;

SELECT
    profno,
    name,
    position,
    pay * 12,
    CASE
        WHEN pay * 12 > 5000 THEN
            'High'
        WHEN pay * 12 > 4000 THEN
            'MID'
        WHEN pay * 12 > 3000 THEN
            'LOW'
        ELSE
            'Etc'
    END AS "SAL"
FROM
    professor;

SELECT
    name,
    substr(jumin, 3, 2) AS "MONT",
    CASE
        WHEN substr(jumin, 3, 2) BETWEEN 01 AND 03 THEN
            '1/4'
        WHEN substr(jumin, 3, 2) BETWEEN 04 AND 06 THEN
            '2/4'
        WHEN substr(jumin, 3, 2) BETWEEN 07 AND 09 THEN
            '3/4'
        ELSE
            '4/4'
    END                 AS "Qua"
FROM
    student;

SELECT
    empno,
    ename,
    sal,
    CASE
        WHEN sal <= 1000 THEN
            'LEVEL 1'
        WHEN sal <= 2000 THEN
            'LEVEL 2'
        WHEN sal <= 3000 THEN
            'LEVEL 3'
        WHEN sal <= 4000 THEN
            'LEVEL 4'
        WHEN sal <= 5000 THEN
            'LEVEL 5'
        ELSE
            'ETC'
    END AS "LEVEL"
FROM
    emp
ORDER BY
    sal DESC;

SELECT
    profno,
    name,
    'PROFESSON',
    pay
FROM
    professor
WHERE
    deptno = 101
UNION
SELECT
    studno,
    name,
    'STUDENT',
    0
FROM
    student
WHERE
    deptno1 = 101;

SELECT
    MIN(job)
--    ,MAX(JOB)
    ,
    COUNT(*)      AS "인원",
    SUM(sal)      AS "직무 급여 합계",
    AVG(sal)      AS "급여 평균",
    STDDEV(sal)   AS "표준편차",
    VARIANCE(sal) AS "분산"
FROM
    emp
GROUP BY
    job;

SELECT
    to_char(hiredate, 'RRRR') AS "HD",
    COUNT(*)                  AS "인원"
FROM
    emp
GROUP BY
    to_char(hiredate, 'RRRR');

--학생 , 학과별 인원

SELECT
    deptno1,
    COUNT(*)
FROM
    student
GROUP BY
    deptno1
HAVING
    COUNT(*) > 2; --그룹 바이 안의 조건문 HAVING

--교수 , POSITION, SUM(PAY), MAX(PAY), MIN(PAY)
SELECT
    position AS "역활",
    SUM(pay) AS "급여 합계",
    MAX(pay) AS "최고 급여",
    MIN(pay) AS "최저 급여"
FROM
    professor
GROUP BY
    position;

--직원 부서별 급여 평균과 인원
-- 사원, 부서, 직무별 평균 급여, 인원

-- UNION 연습

-- 부서, 직무, 급여, 인원
-- 부서        급여, 인원
-- 부서, 직무, 급여, 인원
-- 부서        급여, 인원
--             급여, 인원

SELECT
    deptno,
    NULL,
    round(avg(sal)),
    COUNT(*),
    'a'
FROM
    emp
GROUP BY
    deptno
UNION
SELECT
    deptno,
    job,
    round(avg(sal)),
    COUNT(*),
    'b'
FROM
    emp
GROUP BY
    deptno,
    job
UNION
SELECT
    NULL,
    NULL,
    round(avg(sal)),
    COUNT(*),
    'c'
FROM
    emp
ORDER BY
    1,
    2 -- 1번 컬럼, 2번 컬럼
    ;


-- ROLLUP , cube 
-- 롤업은 각각의 소급룹과 전체 합계 (주로쓰임)
-- 큐브는 각 항목간의 다차원적 소계를 계산
SELECT
    nvl(
        to_char(deptno),
        '전체'
    )               AS "부서",
    nvl(job, '합계')  AS "직무",
    round(avg(sal)) AS "평균 급여",
    COUNT(*)        AS "사원 수"
FROM
    emp
GROUP BY
    ROLLUP(deptno,
           job)
ORDER BY
    1,
    2;

SELECT
    COUNT(*)
FROM
    emp; ----12
SELECT
    COUNT(*)
FROM
    dept; ----4

SELECT
    COUNT(*) -- dept.*, emp.*
FROM
         emp
    JOIN dept ON emp.deptno = dept.deptno;

SELECT
    studno,
    s.name                AS "학생명",
    s.grade,
    nvl(p.name, '배정 대기중') AS "교수명",
    s.deptno1,
    d.dname               AS "학과명"
FROM
    student    s
    LEFT OUTER JOIN professor  p ON s.profno = p.profno
    JOIN department d ON s.deptno1 = d.deptno;

SELECT
    p.profno,
    p.name,
    s.studno,
    s.name,
    s.profno AS "담당교수"
FROM
    professor p
    LEFT OUTER JOIN student   s ON p.profno = s.profno;

SELECT
    *
FROM
    salgrade;
  
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
order by
age;

SELECT
    *
FROM
    emp2;

SELECT
    *
FROM
    p_grade;
    
--연습문제 4
SELECT
    *
FROM
    customer;

SELECT
    *
FROM
    gift;

SELECT
    c.gname                                             AS "CUST_NAME",
    c.point,
    decode(g.gname, 'Notebook', 'NotebooK', 'Notebook') AS "GIFT_NAME"
FROM
    customer c,
    gift     g
WHERE
    c.point BETWEEN g.g_start AND g.g_end
                                  AND c.point > 600000;

--연습문제 5
SELECT
    *
FROM
    professor;

SELECT
    p1.profno,
    p1.name,
    p1.hiredate,
    COUNT(p2.hiredate) AS "COUNT"
FROM
    professor p1
left JOIN    professor p2
ON
    p1.hiredate > p2.hiredate
group by p1.name, p1.profno, p1.hiredate
--HAVING p1.hiredate > p2.hiredate
order by p1.hiredate;

select hiredate from professor;

--연습문제 6
select * from emp;
select  e1.empno
    ,e1.ename
    ,e1.hiredate
    , count(e2.hiredate) as "COUNT"
from emp e1
left join emp e2
on e1.hiredate > e2.hiredate
group by e1.empno, e1.ename, e1.hiredate
order by e1.hiredate
;

delete emp where empno=7788 or empno=7876;
SELECT * FROM tab;

SELECT 'purge table "' || tname || '";' FROM tab; -- 테이블 일괄 삭제

SELECT *
FROM
    emp;
-- <----------------------------3일차 DDL ----------------------------------------------------------->
--테이블 생성
CREATE TABLE new_emp(
    no number(4) constraint emp_no_pk PRIMARY KEY,
    name varchar2(20) constraint emp_name_nn not null,
    jumin varchar2(13) constraint emp_jumin_nn not null
                    constraint emp_jumin_uk UNIQUE,
    loc_code number(1) constraint emp_area_ck CHECK (loc_code <5),
    deptno number(2) constraint emp_dept_fk REFERENCES dept(deptno)
); 

CREATE TABLE new_table (
    no    NUMBER(3) PRIMARY KEY, --회원번호
    name  VARCHAR2(100) NOT NULL, --이름
    birth DATE DEFAULT sysdate --생일 to_date('2020-01-01','rrrr-mm-dd')
);
--조회
SELECT * FROM new_table;

SELECT * FROM user_recyclebin; --테이블 내역 확인

flashback table new_table to before drop; -- 쓰레기통에 있는 테이블 복원 

--테이블 컬럼 변경
--추가
ALTER TABLE new_table ADD phone VARCHAR2(20);

--이름 변경
ALTER TABLE new_table RENAME COLUMN phone to tel;
ALTER TABLE new_table modify tel varchar2(30);

-- 컬럼 삭제
alter table new_table drop column tel;

-- 읽기 전용으로 변경
ALTER TABLE new_table READ ONLY;

ALTER TABLE new_table add info GENERATED always as (no || '-' || name);



--ROLLBACK 이전 커밋으로 되돌리기
ROLLBACK;

--COMMIT
COMMIT;

--DELETE
DELETE FROM new_table
where no = 1;

-- 자르기 (데이터 일괄 삭제)
truncate table new_table;

--테이블 삭제
drop table new_table purge;

--데이터 삽입
INSERT INTO new_table (
    no,
    name
) VALUES ( 1,
           '홍길동' );

INSERT INTO new_table (
    no,
    name,
    birth
) VALUES ( 2,
           '홍길동',
           '2001-01-01' );
           
INSERT INTO new_table (
    no,
    name
) VALUES ( 3,
           '홍길동3' );

INSERT INTO new_table (
    no,
    name,
    birth
) VALUES ( 4,
           '홍길동4',
           '2001-01-01' );
           

--데이터 업데이트
UPDATE new_table
SET
    phone = '010-1111-1111'
WHERE
    no = 1;
    
UPDATE new_table
SET
    phone = '010-2222-2222'
    ,birth = '2001-02-02'
WHERE
    no = 2;
    

    
