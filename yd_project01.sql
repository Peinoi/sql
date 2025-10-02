-- 사원 테이블 전체 조회
SELECT * FROM ydemployee;
DROP TABLE ydemployee purge;
-- 부서 테이블 전체 조회
SELECT * FROM yddepartment;
DROP TABLE yddepartment purge;
-- 발신자 메일 테이블 전체 조회
SELECT * FROM ydmessage;
DROP TABLE ydmessage purge;
-- 수신자 메일 테이블 전체 조회
SELECT * FROM YDmessage_RECIPIENT;
DROP TABLE YDmessage_RECIPIENT purge;
-- 전체 게시판 테이블 전체 조회
SELECT * FROM YDMAINBOARD;
DROP TABLE YDMAINBOARD purge;
-- 개인 게시판 테이블 전체 조회
SELECT * FROM YDMYBOARD;
DROP TABLE YDMYBOARD purge;


--샘플 데이터
INSERT INTO ydEmployee (emp_no, emp_id, emp_pw, emp_name, deptno, hiredate) VALUES (1, 'user01', 'pw01', '홍길동', 1, TO_DATE('2023-01-10','YYYY-MM-DD'));
INSERT INTO ydEmployee (emp_no, emp_id, emp_pw, emp_name, deptno, hiredate) VALUES (2, 'user02', 'pw02', '김철수', 1, TO_DATE('2023-02-15','YYYY-MM-DD'));
INSERT INTO ydEmployee (emp_no, emp_id, emp_pw, emp_name, deptno, hiredate) VALUES (3, 'user03', 'pw03', '이영희', 2, TO_DATE('2023-03-01','YYYY-MM-DD'));
INSERT INTO ydEmployee (emp_no, emp_id, emp_pw, emp_name, deptno, hiredate) VALUES (4, 'user04', 'pw04', '박민수', 2, TO_DATE('2023-03-20','YYYY-MM-DD'));
INSERT INTO ydEmployee (emp_no, emp_id, emp_pw, emp_name, deptno, hiredate) VALUES (5, 'user05', 'pw05', '최지은', 3, TO_DATE('2023-04-05','YYYY-MM-DD'));
INSERT INTO ydEmployee (emp_no, emp_id, emp_pw, emp_name, deptno, hiredate) VALUES (6, 'user06', 'pw06', '정우성', 3, TO_DATE('2023-04-15','YYYY-MM-DD'));
INSERT INTO ydEmployee (emp_no, emp_id, emp_pw, emp_name, deptno, hiredate) VALUES (7, 'user07', 'pw07', '한지민', 1, TO_DATE('2023-05-01','YYYY-MM-DD'));
INSERT INTO ydEmployee (emp_no, emp_id, emp_pw, emp_name, deptno, hiredate) VALUES (8, 'user08', 'pw08', '오승훈', 2, TO_DATE('2023-05-20','YYYY-MM-DD'));
INSERT INTO ydEmployee (emp_no, emp_id, emp_pw, emp_name, deptno, hiredate) VALUES (9, 'user09', 'pw09', '서연', 3, TO_DATE('2023-06-01','YYYY-MM-DD'));
INSERT INTO ydEmployee (emp_no, emp_id, emp_pw, emp_name, deptno, hiredate) VALUES (10, 'user10', 'pw10', '강호', 1, TO_DATE('2023-06-15','YYYY-MM-DD'));


--dept 샘플 데이터
INSERT INTO ydDepartment (deptno, dept_name) VALUES (1, '인사부');
INSERT INTO ydDepartment (deptno, dept_name) VALUES (2, '개발부');
INSERT INTO ydDepartment (deptno, dept_name) VALUES (3, '영업부');

--








commit;




















--테이블 생성
-- 부서 테이블
CREATE TABLE ydDepartment (
    deptno NUMBER(5) CONSTRAINT pk_department PRIMARY KEY, -- 부서 번호
    dept_name VARCHAR2(50) CONSTRAINT nn_department_name NOT NULL -- 부서 이름 (이름 변경)
);

-- 사원(유저) 테이블
CREATE TABLE ydEmployee (
    emp_no NUMBER(10) CONSTRAINT pk_employee PRIMARY KEY, -- 사원 번호
    emp_id VARCHAR2(30) CONSTRAINT uq_employee_empid UNIQUE, -- 유저 아이디 (고유 제약 추가)
    emp_pw VARCHAR2(100) CONSTRAINT nn_employee_pw NOT NULL, -- 유저 비밀번호 (길이 확장)
    emp_name VARCHAR2(50) CONSTRAINT nn_employee_name NOT NULL, -- 유저 이름
    deptno NUMBER(5) CONSTRAINT nn_employee_deptno NOT NULL, -- 부서 번호
    hiredate DATE DEFAULT SYSDATE, -- 입사일
    CONSTRAINT fk_employee_department FOREIGN KEY (deptno)
        REFERENCES ydDepartment (deptno)
);

-- 개인 게시판
CREATE TABLE ydmyBoard (
    post_id NUMBER(5) CONSTRAINT pk_myboard PRIMARY KEY, -- 게시판 번호
    title VARCHAR2(100) CONSTRAINT nn_myboard_title NOT NULL, -- 게시글 제목
    content VARCHAR2(1000) CONSTRAINT nn_myboard_content NOT NULL, -- 게시글 내용
    writer_date DATE DEFAULT SYSDATE, -- 작성일
    emp_no NUMBER(10) CONSTRAINT nn_myboard_writer NOT NULL, -- 작성자 사원 번호
    CONSTRAINT fk_myboard_employee FOREIGN KEY (emp_no)
        REFERENCES ydEmployee (emp_no)
);

-- 공유 게시판
CREATE TABLE ydmainBoard (
    post_id NUMBER(5) CONSTRAINT pk_mainboard PRIMARY KEY, -- 게시판 번호
    deptno NUMBER(5), -- 부서 번호
    title VARCHAR2(100) CONSTRAINT nn_mainboard_title NOT NULL, -- 게시글 제목
    content VARCHAR2(1000) CONSTRAINT nn_mainboard_content NOT NULL, -- 게시글 내용
    writer_user_id VARCHAR2(30) CONSTRAINT nn_mainboard_writer NOT NULL, -- 작성자 아이디
    display_name VARCHAR2(50) CONSTRAINT nn_mainboard_display NOT NULL, -- 작성자 이름
    view_count NUMBER(10) DEFAULT 0, -- 조회수
    CONSTRAINT fk_mainboard_department FOREIGN KEY (deptno)
        REFERENCES ydDepartment (deptno)
);

-- 메일 테이블
CREATE TABLE ydmessage (
    msg_id NUMBER(10) CONSTRAINT pk_msg PRIMARY KEY, -- 메일 아이디
    sender_user_id VARCHAR2(30) CONSTRAINT nn_msg_sender NOT NULL, -- 보낸 사람 아이디
    title VARCHAR2(200) CONSTRAINT nn_msg_title NOT NULL, -- 메일 제목
    content VARCHAR2(2000) CONSTRAINT nn_msg_content NOT NULL, -- 메일 내용
    send_date DATE DEFAULT SYSDATE -- 보낸 날짜
);

-- 메일 수신자 테이블
CREATE TABLE ydmessage_Recipient (
    recipient_id NUMBER(10) CONSTRAINT pk_masg_recipient PRIMARY KEY, -- 수신자 번호
    msg_id NUMBER(10) CONSTRAINT nn_msg_recipient_msgid NOT NULL, -- 메일 아이디
    emp_no NUMBER(10) CONSTRAINT nn_msg_recipient_empno NOT NULL, -- 수신자 사원 번호
    is_read CHAR(1) DEFAULT 'N' CONSTRAINT ck_msg_isread CHECK (is_read IN ('Y','N')), -- 읽음 여부
    read_date DATE, -- 읽은 날짜
    is_deleted_by_recipient CHAR(1) DEFAULT 'N' CONSTRAINT ck_msg_deleted CHECK (is_deleted_by_recipient IN ('Y','N')), -- 삭제 여부
    CONSTRAINT fk_msgrecipient_msg FOREIGN KEY (msg_id)
        REFERENCES ydmessage (msg_id),
    CONSTRAINT fk_msgrecipient_employee FOREIGN KEY (emp_no)
        REFERENCES ydEmployee (emp_no),
    CONSTRAINT uq_msg_recipient UNIQUE (msg_id, emp_no)  -- 중복 방지 유니크 제약 추가
);
