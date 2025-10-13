-- --------------------------------------------------
-- 1. YDPROFILE (프로필 테이블) 샘플 데이터
-- --------------------------------------------------
-- 사원 1(홍길동), 3(이영희), 5(최지은)에게 프로필 경로를 지정합니다.
--INSERT INTO YDPROFILE (EMP_NO, IMG_PATH) VALUES (1, '/profile/user01_hong.jpg');
--INSERT INTO YDPROFILE (EMP_NO, IMG_PATH) VALUES (3, '/profile/user03_lee.png');
--INSERT INTO YDPROFILE (EMP_NO, IMG_PATH) VALUES (5, '/profile/user05_choi.gif');


-- --------------------------------------------------
-- 2. ydmyBoard (개인 게시판) 샘플 데이터
-- --------------------------------------------------
-- 개인적인 업무 일지나 메모를 작성합니다.
INSERT INTO ydmyBoard (post_id, title, content, emp_no, write_date)
VALUES (1, '오늘의 업무 일지: 프로젝트 A', '프로젝트 A,B 진행 상황 정리 및 내일 계획 수립. (내용 테스트)', 1, SYSDATE - 2);
INSERT INTO ydmyBoard (post_id, title, content, emp_no, write_date)
VALUES (2, '개인 학습 메모: SQL 튜닝', 'SQL 최적화 튜닝 기법 관련 자료 정리. 중요 내용 요약.', 3, SYSDATE - 1.5);
INSERT INTO ydmyBoard (post_id, title, content, emp_no, write_date)
VALUES (3, '팀 회의 준비 완료', '다음 주 영업 전략 회의 자료 초안 작성 완료 및 검토 요청.', 5, SYSDATE - 0.5);
INSERT INTO ydmyBoard (post_id, title, content, emp_no, write_date)
VALUES (4, '하반기 목표 설정', '하반기 목표 달성을 위한 세부 계획 작성 완료. 1차 목표는 9월 말 달성.', 1, SYSDATE - 0.2);


-- --------------------------------------------------
-- 3. ydmainBoard (공유 게시판) 샘플 데이터
-- --------------------------------------------------
-- 부서별 공지사항 및 전사 공유 게시글입니다.
-- deptno가 NULL이면 전사 공지입니다.
INSERT INTO ydmainBoard (post_id, deptno, title, content, writer_user_id, display_name, view_count, write_date)
VALUES (101, 10, '인사부 공지: 10월 정기 교육 안내', '10월 20일 전 직원 대상 역량 강화 교육을 실시합니다. 필참 바랍니다.', 'user01', '홍길동', 15, SYSDATE - 5);
INSERT INTO ydmainBoard (post_id, deptno, title, content, writer_user_id, display_name, view_count, write_date)
VALUES (102, 20, '개발부: 신규 프로젝트 런칭 보고서 공유', '프로젝트 X의 최종 런칭 보고서를 공유합니다. 버그 리포트 부탁드립니다.', 'user03', '이영희', 30, SYSDATE - 4);
INSERT INTO ydmainBoard (post_id, deptno, title, content, writer_user_id, display_name, view_count, write_date)
VALUES (103, 30, '영업부: 3분기 실적 우수 사례 공유', '최지은 사원의 3분기 우수 영업 사례를 전 부서에 공유합니다. 참고하세요.', 'user05', '최지은', 50, SYSDATE - 3);
INSERT INTO ydmainBoard (post_id, deptno, title, content, writer_user_id, display_name, view_count, write_date)
VALUES (104, 20, '개발 자료 공유: 최신 React 트렌드', '프론트엔드 개발자들이 참고할 만한 최신 React 업데이트 내용입니다.', 'user04', '박민수', 10, SYSDATE - 1);
INSERT INTO ydmainBoard (post_id, deptno, title, content, writer_user_id, display_name, view_count, write_date)
VALUES (105, NULL, '전사 공지: 주간 식단표 (10/09 ~ 10/13)', '이번 주 구내식당 식단표를 공유합니다. 파일 확인 필수.', 'user07', '한지민', 88, SYSDATE);


-- --------------------------------------------------
-- 4. ydmessage (메일 테이블) 샘플 데이터
-- --------------------------------------------------
-- 발신자 정보만 기록합니다.
INSERT INTO ydmessage (msg_id, sender_user_id, title, content, send_date)
VALUES (1, 'user01', '업무 요청 드립니다: 프로젝트 A 데이터', '프로젝트 A 관련 데이터 검토 및 피드백 요청 드립니다.', SYSDATE - 3); -- 발신자: 홍길동(user01)
INSERT INTO ydmessage (msg_id, sender_user_id, title, content, send_date)
VALUES (2, 'user05', '점심 식사 제안 드립니다.', '오늘 점심 같이 드실래요? 12시에 뵙겠습니다. (답장 부탁)', SYSDATE - 1); -- 발신자: 최지은(user05)
INSERT INTO ydmessage (msg_id, sender_user_id, title, content, send_date)
VALUES (3, 'user03', '긴급: 서버 장애 조치 보고서', '새벽 2시에 발생한 서버 장애 관련 조치 보고서 첨부합니다. 확인 바랍니다.', SYSDATE); -- 발신자: 이영희(user03)


-- --------------------------------------------------
-- 5. ydmessage_Recipient (메일 수신자 테이블) 샘플 데이터
-- --------------------------------------------------
-- 메일 수신자와 읽음/삭제 여부를 기록합니다.
-- msg_id 1 (홍길동 -> 이영희, 박민수)
INSERT INTO ydmessage_Recipient(recipient_id, msg_id, emp_no, is_read, read_date, is_deleted_by_recipient)
VALUES(1, 1, 3, 'Y', SYSDATE - 2.8, 'N'); -- 이영희(3)가 읽음
INSERT INTO ydmessage_Recipient(recipient_id, msg_id, emp_no, is_read, read_date, is_deleted_by_recipient)
VALUES(2, 1, 4, 'N', NULL, 'N'); -- 박민수(4)는 아직 안 읽음

-- msg_id 2 (최지은 -> 정우성)
INSERT INTO ydmessage_Recipient(recipient_id, msg_id, emp_no, is_read, read_date, is_deleted_by_recipient)
VALUES(3, 2, 6, 'Y', SYSDATE - 0.9, 'N'); -- 정우성(6)이 읽음

-- msg_id 3 (이영희 -> 홍길동 외 인사부 3명)
INSERT INTO ydmessage_Recipient(recipient_id, msg_id, emp_no, is_read, read_date, is_deleted_by_recipient)
VALUES(4, 3, 1, 'Y', SYSDATE - 0.1, 'N'); -- 홍길동(1)이 읽음
INSERT INTO ydmessage_Recipient(recipient_id, msg_id, emp_no, is_read, read_date, is_deleted_by_recipient)
VALUES(5, 3, 2, 'N', NULL, 'N'); -- 김철수(2)는 아직 안 읽음
INSERT INTO ydmessage_Recipient(recipient_id, msg_id, emp_no, is_read, read_date, is_deleted_by_recipient)
VALUES(6, 3, 7, 'N', NULL, 'Y'); -- 한지민(7)은 안 읽고 삭제함
INSERT INTO ydmessage_Recipient(recipient_id, msg_id, emp_no, is_read, read_date, is_deleted_by_recipient)
VALUES(7, 3, 10, 'Y', SYSDATE - 0.2, 'N'); -- 강호(10)가 읽음

commit;