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
-- 사원번호 / 이름 / 직업 / 입사일 /deptnoALTER
select * from emp
order by hiredate;
select * from dept;

--INSERT 사원 추가
INSERT INTO EMP(empno, ename, job ,hiredate, deptno)
VALUES (9999,'Hong','SALESMAN',to_date('1982-03-01','rrrr-mm-dd'),30 );



--UPDATE 정보 변경

--SAL 1000으로 변경 1000이하만
UPDATE EMP 
SET 
SAL = 1000
WHERE SAL<1000;
--500미만 comm 500만들기 새일즈맨만
UPDATE EMP 
SET 
COMM = 500
WHERE COMM<500 AND JOB = 'SALESMAN'; 
-- 1981년 전반기 입사한 사원 (1~6월) => 10% 급여 인상
UPDATE EMP 
SET 
sal = sal + sal*0.1
WHERE '1980/01/01'<= hiredate and hiredate <'1981/07/01'; 

--조회

SELECT *
FROM professor;

SELECT *
FROM student;

--Rene Russo의 담당교수의 번호, 이름, 포지션 혹은 직책

SELECT p.profno, p.name, p.position
FROM professor p
left join student s
on s.profno = p.profno
where s.name = 'Rene Russo';


select * from 
department;
--전공 : Computer Engineering => 학생들의 학번 이름 을 확인
SELECT s.studno, s.name
FROM student s
left join department d
on s.deptno1 = d.deptno or s.deptno2 = d.deptno
where d.deptno = 101;

--학생중 전공1 Computer Engineering 학생들의 담당 교수의 
--교수 번호,교수이름,포지션
select * from professor;
select * from department;
select * from student;

SELECT DISTINCT p.profno, p.name, p.position
FROM professor p
join student s
on p.profno = s.profno 
join department d on s.deptno1 = d.deptno
where d.dname = 'Computer Engineering'
;

select DISTINCT position from professor;
--학생들중 담당 교수의 포지션이 어시스트
SELECT s.name, p.position
FROM professor p
join student s
on p.profno = s.profno 
where p.position = 'assistant professor'
;

--학생의 전공 중 Computer Engineering 의 학생들의 
--몸무게의 평균을 구한다 더 큰 학생들.
select * from student ss
where ss.weight > (select avg(weight) from student s
join department d 
on s.deptno1 = d.deptno 
where d.dname = 'Computer Engineering');

select name ,weight from student
where deptno1 =101 and
weight >
(select avg(weight) from student
where deptno1 =101);

select name, weight from student
where deptno1 =101;

--전공: Electronic Engineering 학생들의 담당 교수, 

select * from professor pp  
where pp.position in
(select p.position from professor p 
join student s
on p.profno = s.profno
join department d
on s.deptno1 = d.deptno
where d.dname = 'Electronic Engineering');


-- professor pay의 평균 이상 받는 교수들

select profno,name,pay from professor
where pay > (
select avg(pay) from professor
);

select * from professor;

--보너스 못받은 사람중 제일 먼저 입사한 사람 보다 먼저 입사한 사람
select name from professor
where hiredate < (select min(hiredate) from professor where bonus is null)
--and bonus is not null
order by hiredate
;
select min(hiredate) from professor where bonus is null;

--보너스를 안받는 사람들 보다 월급이 더 적은 보너스를 받는 사람 월 급 10% 인상
select max(pay) from professor where bonus is null;

update professor set pay = pay + pay*0.1 
where pay <
(select max(pay) from professor where bonus is null);

select max(pay) from professor where bonus is null;

select name, pay from professor 
where bonus is not null and pay <330;

select * from emp;

select dname from emp e
join dept d
on e.deptno =d.deptno;
SELECT 
      e.*, d.DNAME
      FROM emp e
      join dept d
      on e.deptno = d.deptno
      WHERE ename = DECODE('ALL', 'ALL',ename,'ALL')
      AND job = DECODE('ANALYST', 'ALL',job,'ANALYST')
      AND e.deptno = DECODE(-1, -1,e.deptno,-1)
    ;

--<---------------------VIEW------------------------------------>
create or replace view emp_dept_v --or replace 필요시 컬럼 추가가능
as
select empno, ename, job, sal, e.deptno, dname, comm
from emp e
join dept d
on e.deptno = d.deptno;

select *
from emp_dept_v;

create or replace view emp_v
as
select empno, ename, job, deptno
from emp;

select position, count(*)
from stud_prof_v v
join department d
on v.deptno = d.deptno
group by position
;
--where position = 'a full professor';
select deptno from stud_prof_v;
select * from tab;

--학생, 담당 교수 뷰
create or replace view  stud_prof_v
as
select studno, s.name as "STUDENT_NAME"
,birthday
,tel
,deptno1 deptno
,p.profno
,p.name AS "PROFESSOR NAME"
,position
, email
from student s
left outer join professor p
on s.profno = p.profno;

select * from stud_prof_v;

--뷰 업데이트 가능은 하지만 왠만해선 조회만 해라
update emp_v
set ename =''
    ,deptno = ''
where empno ='9999';

--<---------------------게시판 제작 연습 ---------------------->

CREATE TABLE board_t(
    board_no number(5) primary key
    ,title varchar2(100) not null
    ,content varchar2(1000) not null
    ,writer varchar2(50) not null
    ,write_date date default sysdate
    ,likes number(3) default 0
);
select * from board_t;
insert into board_t(board_no,title,content,writer) values(1,'게시판 글 연습','게시판이 잘 되는지 연습','홍길동');
insert into board_t(board_no,title,content,writer) values(2,'글연습','게시판이 글이 안써짐','잘써짐');
insert into board_t(board_no,title,content,writer) values(3,'왔다감','일하기 싫다','백수동');
insert into board_t(board_no,title,content,writer) values(4,'분탕ㄴㄴ','내가 분탕임','가길동');

update board_t set title='업데이트 연습 중' where board_no=2;

insert into board_t(board_no, title, content ,writer)
values (board_t_seq.nextval,'테크놀로지아','no 자동설정','홍길동');

delete board_t ;

-- 시퀀스 사용
create sequence board_t_seq; -- 자동 증가 번호

create sequence board_t_seq
increment by 1 -- 2씩 증가
start with 1 --100부터 시작
minvalue 1 -- 최저값
maxvalue 9999999999 --맥스값
cycle --반복 맥스찍고 1부터 시작
;

select board_t_seq.nextval from dual;

drop sequence board_t_seq;

select count(*) from board_t;

alter table board_t modify(board_no number(10));

select max(board_no) from board_t;

insert into board_t(board_no, title, content ,writer)
select board_t_seq.nextval, title,content,writer
from board_t;
