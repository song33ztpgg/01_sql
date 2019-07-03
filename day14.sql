--DAY 14 

--3) DELECTE : 테이블에서 [행]단위로 데이터를 삭제 
-- DELETE 구문 구조 
DELETE [FROM] 테이블이름 [테이블 명칭] 
 WHERE 문장 
; 

---1.WHERE 조건이 있는 DELETE 구문 
--삭제 전 커밋  
COMMIT; 

-- member 테이블에서 gender가 'F'인 데이터를 삭제
DELETE member m 
 WHERE m.gender = 'R' -- 오타 입력 
; 
/* 0개의 행이 삭자 되었습니다. (구문의 오류는 없었다)*/


DELETE member m 
 WHERE m.gender = 'F' 
 ; 
 /* 1개의 행이 삭제 되었습니다.  
특정 행 삭제시 PK 가 아닌 조건으로 삭제하는것은 주의해야 함 
*/  
 
 ROLLBACK;
 
 --만약 'M004'행을 삭제 하는것이 목적이라면 PK로 삭제해야 함 
 DELETE member m 
  WHERE m.member_id = 'M004' 
  ; 
  
  COMMIT;
 
 --2.WHERE 조건이 없는 DELETE 구문 
 --  WHERE 조건이 아애 누락(생략)된 경우 전체 행을 삭제  
 DELETE member; 
 ROLLBACK; 
 
 ---3.DELETE 의 WHERE 에 서브쿼리 조합 
 -- 주소가 '아산시'인 사람을 모두 삭제
 DELETE member m 
  WHERE m.address = '아산시' 
  ; 
  
 ---(1) 주소가 '아신시'인 사람을 조회
SELECT m.member_id 
  FROM member m 
 WHERE m.address = '아산시' 
; 

--(2) 삭제하는 메인 쿼리 작성 
DELETE member m 
 WHERE m.member_id = ?   -- 값은 1개밖에 들어가지 못한다
; 

--(3) 2q번의 메인 쿼리에 1번의 서브쿼리 조합
DELETE member m 
 WHERE m.member_id IN (SELECT m.member_id 
                         FROM member m 
                        WHERE m.address = '아산시')
;  

ROLLBACK;
 
-------------------------------------------------------- 
--DELETE VS TRUNCATE 
/*
1.TRUNCATE 는 DDL에 속하는 명령어 따라서 
  ROLLBACK 지점을 생성하지 않음 
  한 번 실행된 DDL은 되돌릴 수 없음 
  
2.TRUNCATE 는 DDL 이기 때문에 
  WHERE 조건절 조합이 불가능 하므로 
  특정 데이터를 선별하여 삭제하는 것이 불가능 
*/ 


--TRUNCATE 실행 후에 되돌아갈 COMMIT 지검 생성 
COMMIT; 

--new member를 잘라내기
TRUNCATE TABLE  new_member;
/* Table NEW_MEMBER이(가) 잘렸습니다. */ 
--되돌리기 시도 

ROLLBACK;
/* 롤백이 성공인듯 보이지만 
TRUNCATE 명령은 실행과 동시에 자동커밋이 이루어 지므로 
TRUNCATE 이후 시점이 롤백가능한 커밋지점으로 잡힙니다.*/ 

------------------------------------------------------------------- 
--TCL : Transaction Control Language 
--1)COMMIT 
--2)ROLLBACK  
--3)SAVEPOINT 
---1.member 테이블에 1행을 추가  
-----1.1 INSERT 전에 커밋지점 생성 
COMMIT;

-----1.2 DML : INSERT 작업 실행
INSERT INTO member m(m.member_id, m.member_name) 
VALUES ('M010','홍길동') 
;
/*1 행 이(가) 삽입되었습니다.*/ 

-----1.3 1행 추가까지 중간 상태 저장 
SAVEPOINT do_insert; 
--Savepoint가 생성되었습니다. 

--2.홍길동의 주소를 업데이트 
---2.1 DML : UPDATE 작업 실행 
--- 
UPDATE member m 
   SET m.address = '율도국' 
 WHERE m.member_id = 'M010' 
 ; 
 
---2.2 주소 수정까지 중간 저장  
SAVEPOINT do_address;

--3.홍길도의 전화번호 업데이트 
UPDATE member m 
   SET m.phone = '9999' 
 WHERE m.member_id = 'M010' 
 ; 
---3.2 전화번호 수정까지 중간저장 
SAVEPOINT do_update_phone; 

--4.홍길동의 성별 업데이트 
--4.1 DML : UPDATE 작업 실행 
UPDATE member m 
   SET m.gender = 'F' 
 WHERE m.member_id = 'M010'
;

--4.2 성별 업데이트  
SAVEPOINT do_update_gender;

--현제 4개의 SAVEPOINT가 하나의 트랙잰셕으로 묶여 있는 상황 
--COMMIT을 하지 않아서 트랙잰션 정상종료가 아닌 상황
/*
1.COMMIT
2.SAVEPOINT1 
3.SAVEPOINT2
4.SAVEPOINT3 
5.SAVEPOINT4  
 
순자적 역순으로 밖에 가지 못함 
*/ 

ROLLBACK TO do_update_addr; -- 롤백 세이브포인트를 잘못 설정한 것
-- 롤백 완료.

-- 2. 주소, 전화번호 수정까지는 맞았고, 성별 수정만 잘못되었음.
ROLLBACK TO do_update_phone;
/*
 'DO_UPDATE_PHONE' 저장점이 이 세션에 설정되지 않았거나 부적합합니다.

  SAVEPOINT 에는 순서가 있다.
  do_update_addr 이 do_update_phone 보다 앞서 생성된 지점이기때문에
  여기까지 ROLLBACK TO 가 일어나면
  그 후 생성된 SAVEPOINT 는 모두 삭제 됨.
*/


--3. 2번의 ROLLBACK TO 수행 후에 되돌릴 수 있는 지점 
ROLLBACK TO do_insert -- insert 후 지점 
ROLLBACK;             -- 최초 시작 지점 
----------------------------------------------------- 

--기타 객체 : SEQUENCE , INDEX , VIEW 
--SEQUENCE : 기본 키(PK)등으로 사용되는 일련번호 생성 객체
--1.시작 번호 : 1, 최대 : 30, 사이클이 없는 시쿼스 생성 
CREATE SEQUENCE seq_member_id 
 START WITH 1 
MAXVALUE 30 
NOCYCLE 
;
/* Sequence SEQ_MEMBER_ID이(가) 생성되었습니다. */
/*
CREATED	        19/07/03
LAST_DDL_TIME	19/07/03
SEQUENCE_OWNER	SCOTT
SEQUENCE_NAME	SEQ_MEMBER_ID
MIN_VALUE	    1      -최소 숫자
MAX_VALUE	    30     -최대 숫자
INCREMENT_BY	1
CYCLE_FLAG	    N
ORDER_FLAG	    N
CACHE_SIZE	    20
LAST_NUMBER	    1      -마지막 번호
SCALE_FLAG	    N
EXTEND_FLAG	    N
SESSION_FLAG	N
KEEP_VALUE	    N
DUPLICATED	    N
SHARDED	        N
*/   
--시퀀스는 객체이기 때문에 DDL 생선한다  
-- 시퀀스가 생성되면 시스템 카탈로그에 저장된다. 
--user_sequences  
SELECT s.sequence_name 
     , s.min_value 
     , s.max_value 
     , s.cycle_flag 
     , s.increment_by
  FROM user_sequences s 
 WHERE s.sequence_name = 'SEQ_MEMBER_ID' 
 ;
 /*
 SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, CYCLE_FLAG, INCREMENT_BY 
 -------------------------------------------------------------
 SEQ_MEMBER_ID	    1	    30	            N	        1
 */
 
 
 --만약 동일 시퀀스를 실행하면 
CREATE SEQUENCE seq_member_id 
 START WITH 1 
MAXVALUE 30 
NOCYCLE 
;
 /*기존의 객체가 이름을 사용하고 있습니다  
 결과를 얻게 된다.
 */
 
 
 --메타 데이터를 저장하는 유저 딕셔너리 
 /*
 무결성 제약조선  : user_constraints 
 시퀀스 생성정보  : user_sequences 
 테이블 생성정보  : user_tables 
 인덱스 생성정보  : user_indexes 
 객체들 생성정보  : user_objects
 */


--2.시퀀스 사용 
-- : 생성된 시퀀스는 SELECT 구문에서 사용가능 
--(1) NEXTVAL : 시퀀스의 다음 번호를 얻어냄 
--              CREATE 되고 나서 반드시 최초 1번 NEXTVAL 
--              호출이 되어야 생성이 시작 

--사용법 : 시퀀스이름.NEXTVAL 
SELECT SEQ_MEMBER_ID.NEXTVAL 
  FROM dual   
; 
/*
실행할때마다 값이 증가함
MAXVALUE 이상 생성하면다음의 오류가 발생 
*/ 

--(2) CURRVAL : 시퀀스에서 현재 생성된 번호를 확인 
--              시퀀스 생성후 최초 1번의 NEXTVAL 호출이 없으며 ㄴ
--              현재의 번호를 얻을 수 없음 
--              즉 , 시퀀스는 아직 비활성화 상태  

--사용법 : 시퀀스 이름.CURRVAL 
SELECT SEQ_MEMBER_ID.CURRVAL  
  FROM dual 
; 

/* NEXTVAL을 실행하지 않을경우 활성화가 되지 않아서 오류가 생긴다.*/

--(3) 시퀀스 수정 : ALTER SEQUECNE  
-- 생성한 SEQ_MEMBER_ID위 MAXVALUE 설정을 NOMAXVALUE 로 변경 
ALTER SEQUENCE SEQ_MEMBER_ID 
NOMAXVALUE 
; 

/* MAX_VALUE	9999999999999999999999999999 */ 

ALTER SEQUENCE SEQ_MEMBER_ID 
INCREMENT BY 10 
;
/* INCREMENT_BY	10*/ 

ALTER SEQUENCE SEQ_MEMBER_ID 
CYCLE
; 
/* CYCLE_FLAG	Y */

DROP SEQUENCE seq_member_id; 
/*Sequence SEQ_MEMBER_ID이(가) 삭제되었습니다.*/

SELECT SEQ_MEMBER_ID.CURRVAL  
  FROM dual 
; 
/* ORA-02289: 시퀀스가 존재하지 않습니다. */ 

----------------------------------------------- 
--new_member 테이블에 데이터 입력시 시퀀스 활용 

--new_member의 id 컬럼에 사용할 시퀀스 신규 생성 
/*
시퀀스 이름 : seq_new_member_id 
시작번호    : START WITH 1
증가 값     : INCREMENT BY 1
시작 번호   : 1 
최대 번호   : NOMAXVALUE 
사이클 여부 : NOCYCLE 
*/ 

CREATE SEQUENCE seq_new_member_id 
START WITH 1
INCREMENT BY 1
NOMAXVALUE 
NOCYCLE  
; 
/* Sequence SEQ_NEW_MEMBER_ID이(가) 생성되었습니다. */ 


-- 제작 목표 member_id를 M001,M002
SELECT 'M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL, 3, 0) AS member_id
  FROM dual
; 

INSERT INTO new_member(member_id, member_name) 
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL, 3, 0) 
             , '홍길동') 
; 
COMMIT;


----------------------------------------------------------------- 
--INDEX : 데이터의 조회,검색 (DQL)시 일정한 검색 속도 보장을 위해 
--        DBMS가 관리하는 객체 

--1.user_indexes 테이블에서 이미 존재하는 INDEX 조회 
SELECT i.index_name 
     , i.index_type 
     , i.table_name 
     , i.include_column
  FROM user_indexes i
;

/*
SYS_C007730	    NORMAL	CUSTOMER	
PK_DEPT	        NORMAL	DEPT	
PK_EMP	        NORMAL	EMP	
SYS_C007697	    NORMAL	MAIN_TABLE1	
SYS_C007698	    NORMAL	MAIN_TABLE1	
PK_MAIN3	    NORMAL	MAIN_TABLE3	
UQ_NICKNAME3	NORMAL	MAIN_TABLE3	
PK_MAIN4	    NORMAL	MAIN_TABLE4	
UQ_NICKNAME4	NORMAL	MAIN_TABLE4	
SYS_C007691	    NORMAL	MAIN_TALBLE1	
SYS_C007692	    NORMAL	MAIN_TALBLE1	
PK_MEMBER	    NORMAL	MEMBER	
PK_SUB4	        NORMAL	SUB_TABLE4	
*/

--2.테이블의 주키(PK)컬럼에 대해서는 DBMS가 
--자동으로 인덱스 생성함을 알 수 있음 
-- UNIQUE에 대해서도 인덱스를 자동으로 생성합
--한번 인덱스가 생성된 컬럼에 대해서는 중복 생성 불가능 

--EX) MEMBER 테이블의 MEMBER_ID 컬럼에 대해 인덱스 생성 시도 
CREATE INDEX idx_member_id
ON member (member_id) 
;
/* 열 목록에는 이미 인덱스가 작성되어 있습니다  
=> PK_member 라는 이름과 다른 IDX_MEMBER_ID로 생성 시도해도 
같은 커럼에 대해서는 인덱스가 두 개 생성되지 않음 */


--3.복사 테이블 new_member 에는  PK가 없기 때문에 인덱스도 없는 상태
--1) new_member 의 member_id 컬럼에 인덱스 생성
CREATE INDEX idx_new_member_id 
ON new_member (member_id) 
;
/* Index IDX_NEW_MEMBER_ID이(가) 생성되었습니다. */ 

--인덱스 생성 확인후 DROP 
DROP INDEX idx_new_member_id ; 
/*삭제*/

CREATE INDEX idx_new_member_id 
ON new_member (member_id DESC) 
;
/*ASC -> DESC */

SELECT i.index_name 
     , i.index_type 
     , i.table_name 
     , i.include_column
  FROM user_indexes i
; 

-- INDEX 가 SELECT 에 사용될 때 
-- 빠른 검색을 위해서 명시적으로 SELECT애 사용하는 경우가 존재 
-- ==> HINT절을 SELECT에 사용한다.


/*
관리자   형태                            오름차순(pk를 선택하면 자동 오름차순)
------------------------------------
SCOTT	PK_EMP	SCOTT	EMP	EMPNO	1	ASC
--오름차순(pk를 선택하면 자동 오름차순)
*/




