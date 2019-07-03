--day13 

--------------------------------------------- 
--오라클의 특별한 컬럼 2가지 
--사용자가 만든적이 없어도 자동으로 제공되는 컬럼 

--1.ROWID : 물리적으로 디스크에 저장된 위치를 가리키는 값ㅇ 
--          물리적 위치이므로 한 행당 반드시 유일한 값일 수 밖에 없음 
--          ORDER BY 절에 의해 변경되지 않는 값  

--2.ROWNUM : 조회된 결과의 첫번째 행부터 1로 증가하는 값 
-------------------------------------------- 

--EX) emp테이블의 SMITH 를 조회  
SELECT e.rowid
     , e.empno 
     , e.ename
  FROM emp e  
 WHERE e.ename = 'SMITH'
; 
--결과 : AAAR9ZAAHAAAACWAA/A	7369/	SMITH

--ROWID 를 같이 조회 
SELECT --e.rowid 
       rownum
     , e.empno 
     , e.ename 
  FROM emp e
 WHERE e.ename = 'SMITH'  
;
--결과 :1	7369	SMITH

----------------------------------------------------------------------

--ORDER BY 절에 의해 ROWNUM이 변경되는 결과 확이 ㄴ
SELECT rownum
     , e.empno 
     , e.ename 
  FROM emp e
 ORDER BY e.ename  
;

/*
1	7369	SMITH
2	7499	ALLEN
3	7521	WARD
4	7566	JONES
5	7654	MARTIN
6	7698	BLAKE
7	7782	CLARK
8	7839	KING
9	7844	TURNER
10	7900	JAMES
11	7902	FORD
12	7934	MILLER
13	7777	JJ
14	8888	J_JAMES
*/ 


-- ROWNUM이 ORDER BY결과에 영향을 받지 않는 것처럼 보일 수 있음 
-- SUB-QUERY 로 사용할때 영향을 받음 

SELECT rownum 
     , a.empno 
     , a.ename 
     , a.numrow
FROM ( SELECT rownum as numrow
            , e.empno 
            , e.ename 
         FROM emp e
        ORDER BY e.ename) a
;

/*
ROWNUM, EMPNO, ENAME, NUMROW 
--------------------------------
1	    7499	ALLEN	 2
2	    7698	BLAKE	 6
3	    7782	CLARK	 7
4	    7902	FORD	 11
5	    7900	JAMES	 10
6	    7777	JJ	     13
7	    7566	JONES	 4
8	    8888	J_JAMES	 14
9	    7839	KING	 8
10	    7654	MARTIN	 5
11	    7934	MILLER	 12
12	    7369	SMITH	 1
13	    7844	TURNER	 9
14	    7521	WARD	 3
*/


--이름에 A가 들어가는 사람들을 조회  
SELECT ROWNUM
     , e.ename 
  FROM emp e
 WHERE e.ename LIKE '%A%' 
;
/* 
ROWNUM, ENAME 
-----------------
1	    ALLEN
2	    WARD
3	    MARTIN
4	    BLAKE
5	    CLARK
6	    JAMES
7	    J_JAMES
*/ 

--이름에 A가 들어가는 사람들을 이름 
SELECT SELECT rownum 
     , a.empno 
     , a.ename 
     , a.numrow
  FROM (SELECT ROWNUM
             , e.ename 
          FROM emp e
         WHERE e.ename LIKE '%A%') 
; 

SELECT ROWNUM 
     , e.rowid 
     , e.ename 
 FROM emp e 
WHERE e.ename LIKE '%S%' 
ORDER BY e.ename 
;  


SELECT ROWNUM 
     , a.rowid 
     , a.ename
  FROM (SELECT e.rowid 
             , e.ename 
          FROM emp e 
         WHERE e.ename LIKE '%S%' 
         ORDER BY e.ename ) a
;

/* 
ROWNUM,     ROWID,      ENAME 
--------------------------------
1	AAAR9ZAAHAAAACWAAJ	JAMES
2	AAAR9ZAAHAAAACWAAD	JONES
3	AAAR9ZAAHAAAACXAAB	J_JAMES
4	AAAR9ZAAHAAAACWAAA	SMITH
*/ 

--ROWNUM 으로 할 수 있는 쿼리 
--emp 에서 급여를 많이 받는 상위 5명을 조회 하시오 
--해결법1. 급여가 많은 역순 정렬 
SELECT e.empno 
     , e.ename 
     , e.sal
  FROM emp e 
ORDER BY e.sal DESC 
;
--해결법2. 1의 결과를SUB_QUERY 로  FROM 절에 사용하여  ROWNUM 을 같이 조회  
SELECT ROWNUM 
     , a.*
  FROM (SELECT e.empno 
             , e.ename 
             , e.sal
          FROM emp e 
         ORDER BY e.sal DESC ) a 
;

--해결법3. 
SELECT ROWNUM 
     , a.*
  FROM (SELECT e.empno 
             , e.ename 
             , e.sal
          FROM emp e 
         ORDER BY e.sal DESC ) a 
WHERE ROWNUM <=5
;
/*
1	7839	KING	5000
2	7902	FORD	3000
3	7566	JONES	2975
4	7698	BLAKE	2850
5	7782	CLARK	2450
*/
 
 
--레코드 : 문자, 날짜, 숫자 등 각자 다른 형식을 묶는 작업을 레코드라고 부른다. 
--ex) 달리기 기록  : 홍길동 9.99초 런던 올림픽  

----------------------- 
--DML : 데이터 조작어
----------------------
DROP TABLE member;

CREATE TABLE member 
( member_id    VARCHAR2(4)   
 ,member_name  VARCHAR2(15)     NOT NULL 
 ,phone        VARCHAR2(4)      --NULL 허용(제약조건 사용X)
 ,reg_date     DATE             DEFAULT sysdate 
 ,address      VARCHAR2(30) 
 ,major        VARCHAR2(50)
 ,birth_month  NUMBER(2) 
 ,gender       VARCHAR2(1)    
 ,CONSTRAINT   pk_member         PRIMARY KEY      (member_id) 
 ,CONSTRAINT   ck_member_gender  CHECK (gender IN ('F','M'))
 ,CONSTRAINT   CK_BIRTH          CHECK (birth_month BETWEEN 1 AND 12)
 );

--1.INTO 구문에 컬럼이름 생략시 데이터 추가 
--  VALUES 절에 반드시 전체 컬럼의 데이터를 순서대로 모두 나열  
INSERT INTO MEMBER VALUES ('M001', '박성협', '9155', sysdate , '수원시', '행정', 3, 'M');
INSERT INTO MEMBER VALUES ('M002', '오진오', '1418', sysdate , '군포시',  NULL, NULL, 'M');
INSERT INTO MEMBER VALUES ('M003', '이병현', '0186', sysdate ,    NULL ,  NULL, 3, 'M');
INSERT INTO MEMBER VALUES ('M004', '김문정',   NULL, sysdate , '청주시', '일어', 3, 'F');
INSERT INTO MEMBER VALUES ('M005', '송지환', '0322', sysdate , '안양시', '제약', 3, NULL);
COMMIT;

--오류 발생하는 현상 3가지 

--1.컬럼의 갯수와 데이터 갯수가 다른경우
INSERT INTO MEMBER VALUES ('M005', '0322', sysdate , '안양시', '제약'); 
COMMIT ;  
/*
요구하는 컬럼의 갯수는 8개인대 입력값이 5개여서 
일치하지 않아 실행이 되지 않음
*/

--2.컬럼에 1~12 외의 숫자값 입력시도 
INSERT INTO MEMBER VALUES ('M005', '송', '0001', sysdate , '율도국', '도술', 3, 'M'); 
/*M005(PK) 이미 존재하여서 
(무결성 제약 조건(SCOTT.PK_MEMBER)에 위배됩니다) 
라는 결과를 얻게 된다 
*/


--3.GENDER 컬럼에 'F','M'이외의 값을 넣을 때 
INSERT INTO MEMBER VALUES ('M006', '송', '0001', sysdate , '율도국', '도술', 3, 'G');  
INSERT INTO MEMBER VALUES ('M006', '송', '0001', sysdate , '율도국', '도술', 0, 'M');  
/* 
체크 제약조건(SCOTT.CK_MEMBER_GENDER)이 위배되었습니다 
*/ 

--4.MEMBER NAME에 NULL입력시도 
INSERT INTO MEMBER VALUES ('M006', NULL, '0001', sysdate , '율도국', '도술', 0, 'M');  
/*
NULL을 ("SCOTT"."MEMBER"."MEMBER_NAME") 안에 삽입할 수 없습니다
*/ 

--------------------------------------------------------INSERT INTO MEMBER VALUES ('M006', '홀길동', '0001', sysdate , '안양시', '도술', 3, 'M');


----- 2.INTO 절에 컬럼 이름을 명시한 경우의 데이터 추가 
--       VALUES 절에 INTO의 순서대로 값의 타입, 개수를 맞추어서 작성 
INSERT INTO MEMBER (member_id, member_name) 
VALUES ('M007','김지원');
COMMIT; 

INSERT INTO MEMBER (member_id, member_name,gender) 
VALUES('M008','김지우','M');
COMMIT; 

--테이블 정의 순서와 상관없이 INTO절에 컬럼을 나열할 수 있다.
INSERT INTO MEMBER (birth_month, member_name, member_id) 
VALUES(7,'유현동','M009');
COMMIT; 

--INTO절의 컬럼 갯수와 VALUES 절의 값의 개수 불일치  
INSERT INTO MEMBER (member_id, member_name, birth_month ) 
VALUES('M010','유현동', 'M', '행정');
COMMIT;  
/* 결과 : 값의 수가 너무 많습니다 */

INSERT INTO MEMBER (member_id, member_name, birth_month ) 
VALUES('M010');
COMMIT;  
/*결과  : 값의 수가 충분하지 않습니다*/

--INTO 절과 VALUES 절의 갯수는 같으나 값의 타입이 일치 하지 않을 때 
INSERT INTO MEMBER (member_id, member_name, birth_month) 
VALUES('M010', '허균', '한양');
COMMIT;  
/*결과 : 수치가 부적합합니다*/ 

INSERT INTO MEMBER (adress, reg_date) 
VALUES( 7, '2019-07-02');
COMMIT;   
/* 알아서 변환이 되는 작업들*/ 

--필수 입력 컬럼을 나열하지 않을때 
INSERT INTO MEMBER (birth_month, address , gender)  
VALUES( 12, '서귀포' ,'한양');
COMMIT;    
/* NULL을 ("SCOTT"."MEMBER"."MEMBER_ID") 안에 삽입할 수 없습니다 */


------------------------------------- 

--다중행 입력 : SUB-QUERY를 사용하여 가능 

--구문구조  
INSERT INTO 테이블이름
SELECT 문장; -- 서브쿼리 
/*
--서브 쿠리의 데이터를 복사하면서 새 테이블 생서 
CREATE TABLE 태이블 이름
AS 
SELECT  

--이미 만들어진 테이블에 데이터만 복사해서 추가  
INSERT INTO 테이블 이름 
SELECT 문장 
*/ 

--new_member 삭제 
DROP TABLE new_member;  

--member 복사해서 테이블 생성 
CREATE TABLE new_member 
AS 
SELECT m.* 
  FROM member m 
 WHERE 1=2 
;  
 
INSERT INTO new_member 
SELECT m.*
 FROM member m 
WHERE m.member_name LIKE '_지_' 
; 

--컬럼을 명시한 다중행 입력 
INSERT INTO new_member(member_id, member_name, phone) 
SELECT  m.member_id 
     , m.member_name
     , m.phone
  FROM member m 
  WHERE m.member_id <'M004' 
; 
COMMIT; 

--new_member 에 추가된 행 모두 삭제
DELETE new_member; 
COMMIT;
 
--멤버 데데이터 수정 
UPDATE "SCOTT"."MEMBER" 
SET BIRTH_MONTH = '1' 
WHERE MEMBER_ID ='M007'
; 
UPDATE "SCOTT"."MEMBER" 
SET BIRTH_MONTH = '2' 
WHERE MEMBER_ID ='M008'
; 

--문제) new_member 테이블에 
-- member 테이블로부터 데이터를 복사하여 다중행을 입력하시오
-- 단, member 테이블 데이터에서 birth_month 가 
-- 홀수달인 사람들만 조회하여 입력하시오 
INSERT INTO new_member 
SELECT m.* 
  FROM member m 
WHERE mod(m.birth_month, 2) = 1 
; 
COMMIT; 
-------------------------------------------------- 

--레코드 변경 
--테이블에 저장된 데이터 수정하는 작업 


--2) UPDATE : 테이블의 행(레코드)을 수정 
--            WHERE 조건절의 조합에 따라서 
--            1행만 수정하거나 다중 행 수정이 가능 
--            다중 행이 수정되는 경우는 매우 주의가 필요!! 

--구조  
/*
UPDATE 테이블 이름 
   SET 컬럼1 = 값1 
    [,  컬럼2 = 깂2]  
[WHERE 조건]
*/
--EX) 홍길동의 이름을 수정시도 
UPDATE member m  --update구문은 여기서 별칭 한다. 
   SET m.member_name = '길동이' 
 WHERE m.member_id = 'M006' 
;  


UPDATE member m 
   SET m.phone = '1392' 
 WHERE m.member_id = 'M004' 
;
COMMIT; 


--ex) 유현동(M009)전공을 수정 
UPDATE member m
   SET m.major = '역문컨'; 
/*
 결과 : 모든 major 행이 역문컨이 되어버린다. 
*/ 

--COMMIT 전의 작업까지 되돌리는 작업 명령 ROLLBACK;
ROLLBACK;


UPDATE member m
   SET m.major = '역문컨'
 WHERE m.member_id = 'M009'; 
COMMIT;


------------------------------- 
-- 다중 컬럼 업데이트(2개 이상의 컬럼에 한번에 업데이트) 
-- EX) M008 맴버의 전화번호, 주소 ,전공을 한번에 업데이트 

UPDATE member m 
   SET m.phone = '4119' 
     , m.address = '아산시'
     , m.major = '일어'
 WHERE m.member_id = 'M008' 
 ; 
 
 --EX) 아양시 에서 사는 송지환 맴버의 GENDER 값을 수정 
 --    WHERE 조건에 주소를 비교하는 구문을 쓰는 경우 
 
UPDATE member m
   SET m.gender = 'M' 
 WHERE m.address = '안양시' 
 ; 
 /*
 실행은 되지만 안양시가 고유의 값이 아니여서 동일한 
 지역에 거주하는 사람까지 될수가 있다 
 
 PK는 고유한 값에 NOT NULL이 보장되는 컬럼이기 때문에 
 구별하기 유용하다
 */
 
 --UPDATE 구문에 SELECT 서브퀘리를 사용 
 --EX) M002 자료의 major 값을  M008 맴버 major로 수정  
 
 
--1) M008 자료 구한다 
SELECT m.major
  FROM member m 
 WHERE m.member_id = 'M008'
;  
--2) M002 자료를 구한다. 
SELECT m.major
  FROM member m = ?
 WHERE m.member_id = 'M002'
;  

--3) 1,2 결과를 UPDATE 구문에 적용 
UPDATE member m 
   SET m.major = ( SELECT m.major
                     FROM member m
                    WHERE m.member_id = 'M008') 
 WHERE m.member_id = 'M002' 
 ; 
 COMMIT;
 
 
 --------------------------------------------------------
 
 --만약 SET 절에 사용하는 서브쿼리의 결과가 정확하게 1행1열의 1개의 값이
 --아닌경우 구문 오류 
 
UPDATE member m 
   SET m.major = ( SELECT m.major
                     FROM member m) 
 WHERE m.member_id = 'M002' 
 ; 
 /* 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다. */
 
 UPDATE member m 
    SET m.major = ( SELECT m.member_if
                         , m.major
                     FROM member m 
                     WHERE m.member_id = 'M008') 
 WHERE m.member_id = 'M002' 
 ; 
/* 값의 수가 너무 많습니다 */

--UPDATE 시 제약조건 위반하는 경우 
--EX)M001의 member_id 수정을 시도 
-- : PK 컬럼값을 중복 값을 수정하는 경우 
UPDATE member m
   SET m.member_id = 'M002' 
 WHERE m.member_id = 'M001'
;  
/*무결성 제약 조건(SCOTT.PK_MEMBER)에 위배됩니다 */

--EX) NOT NULL 인 number_name 에 NULL 데이터로 업데이트 시도하는 경우
UPDATE member m
   SET m.member_id =  NULL 
 WHERE m.member_id = 'M001'
;  

/* NULL로 ("SCOTT"."MEMBER"."MEMBER_ID")을 업데이트할 수 없습니다 */


--EX) M001 데이터 대해서 bitrh_month 를 -1로 수정시고 
UPDATE member m
   SET m.birth_month =  -1 
 WHERE m.member_id = 'M001'
;  
/* 체크 제약조건(SCOTT.CK_BIRTH)이 위배되었습니다 */

------------------------------------------------ 
--수업중 실습
--1.PHONE 컬럼이 NULL인 사람은 모두 0000 으로 업데이트 
-- PK걸 필요가 없다. 
UPDATE member m 
   SET m.phone = '0000'  
 WHERE m.phone IS NULL
;
COMMIT;


--2.M001 맴버의 전공을 NULL 값으로 업데이트 
-- PK사용  
UPDATE member m 
   SET m.major = NULL  
 WHERE m.member_id = 'M001'
;

--3.ADDRESS 컬럼이 NULL인 사람은 
--일괄적으로 '아산시'로 업데이트
UPDATE member m 
   SET m.address = '아산시'  
 WHERE m.address IS NULL
; 
ROLLBACK;

--4.MOO9 맴버의 NULL데이터를 
-- PHONE : 3581 , ADDRESS : 천안시, GENDER : M
UPDATE member m 
   SET m.phone = 3581
     , m.address = '천안시'
     , m.gender = 'M' 
 WHERE m.member_id = 'M009' 
;









