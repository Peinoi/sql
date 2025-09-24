select empno, ename from emp;

select * from student;

update student set score = 80 ;

insert into student values (300, '로프꾼', 100);

DELETE from student where sno=300;

commit;

SELECT empno
    ,ename
    ,job
    ,mgr
FROM emp;

SELECT * from emp;


-------------------표현식 사용.
SELECT empno as "사원번호" -- 별칭(alias)
    ,ename as "사원명" --
    ,'Good Morning !! ' || ename as "welcome 메세지" -- aptpwl.
    , ename || '''s 급여' || sal as "급여"
FROM emp;


--distinct
SELECT DISTINCT job, deptno
FROM emp order by job DESC;

--연습 문제1
select name || '''s ' || 'ID: '|| id || ' , WEIGHT is ' ||weight ||'kg'  
    as "ID AND WEIGHT" 
from student;

--연습 문제2
SELECT ename ||
'(' || job ||')'|| ', '
|| ename || '''' || job || '''' 
as "NAME AND JOB"
from EMP;

--연습 문제3
SELECT ename || '''s sal is $'||
sal as "Name And Sal"
FROM emp;

--조건절
SELECT empno
    ,ename
    ,job
    ,mgr
    ,hiredate
    ,sal + comm as "급여"
    ,deptno
FROM emp 
where empno BETWEEN 7900 and 7999
and hiredate >= '82/01/01' ;

select *
from professor
where --email like '%@naver%' and
--pay + bonus >= 300 or pay >=300
pay + nvl(bonus,0) >= 300;

--단일 행 함수 
SELECT profno
    ,lower(name) as "low_name"
    ,upper(id) as "upp_id"
    ,initcap(position) as "pos"
    ,pay
    , concat(concat(name,' - '),id) as "name_id"
FROM professor where length(name) <> 10;

SELECT name 
    ,length(name) as "length"
    ,lengthb('홍길동') as "length"
    ,substr(name, 1 ,5) as "substr"
    ,instr(name,'a') as "instr"
    ,lpad(id,10,'*') as "lapd"
    ,ltrim(lpad(id , 10,'*'), '*' ) as "lpad"
    ,rtrim(' Hello, World ') as "str"
    ,replace('Hello', 'H','h') AS "rep"
from professor
where instr(upper(name), 'A')> 0;

--12000 00780


--substr/instr 퀴즈
select * from student;
select name
    ,tel
    ,substr(tel, 0,instr(tel,')')-1) as "AREA CODE" 
from student where deptno1 = 201;

--replace 문제
select * from student;
select name
    ,tel
    ,replace(tel,substr(tel,instr(tel,')')+1, (instr(tel,'-')-2)-instr(tel,')')+1),'***') as "REPLACE"
    FROM student where deptno1 = 102
  ;
select substr(tel,instr(tel,')')+1, (instr(tel,'-')-2)-instr(tel,')')+1) as"aa" from student;
--substr(변수,시작위치,시작위치부터 몇칸까지)
select tel as "전번"
    ,instr(tel,')')+1 as ")위치" 
    ,instr(tel,'-')-2  as "- 위치"
    from student;

select tel from student;


select empno
    ,round(sal / 12 ,2)as "월급" --올림 
    ,trunc(sal / 12) as "trunc" --내림
    ,mod(sal,12)as"mod" --나머지
    ,ceil(sal/12)as"ceil" --주어진 수와 가장 근접한 큰 정수 12.2-> 13
    ,floor(sal/12)as"floor" --주어진 수와 가장 작은 큰 정수 12.2 -> 12
    ,power(4,2)as"pw" --주어진 숫자의 2승 
from emp;

--날짜
select sysdate
from dual;

SELECT * 
FROM EMP
WHERE HIREDATE > '1982/01/01';

SELECT months_between('1915/01/01' , '1910/01/01')
from dual;

select add_months(sysdate, 2)
    ,next_day(sysdate+1, '목') AS "NEXT_DAY"
    ,last_day(add_months(sysdate,1))as "last"
FROM DUAL;

--1901, 2001 
select sysdate,
    to_char(sysdate, 'rrrr/mm/dd/hh24:mm:ss') as "today" 
from dual;

select to_date('2025-05-05','yyyy-mm-dd') as "date"
from dual;


