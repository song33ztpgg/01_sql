-- DAY 02 
-- SCOTT 계정 EMP 테이블 조회  
SELECT * 
    FROM emp
; 

-- SCOTT 계정 DEPT 테이블 조회  
SELECT * 
    FROM dept 
; 

--2.DQL : SELECT 
--1)emp 테이블에서 job칼럼을 조회
SELECT job
    FROM EMP  
; 
/*
CLERK,SALESMAN,SALESMAN
MANAGER,SALESMAN,MANAGER
MANAGER,PRESIDENT,SALESMAN
CLERK,ANALYST,CLERK
*/

--2)emp테이블에서 중복을 제거하여 job칼럼을 조회 
SELECT DISTINCT job
    FROM emp
; 
/*
JOB 
------------ 
CLERK
SALESMAN
ANALYST
MANAGER
PRESIDENT 

각job 이 한번씩만 조회된 결과를 얻을수 있다 
이 결과로 회사에서는 다섯종류의job이 있음을 확인할수 있다.

*/ 

SELECT job 
    FROM emp 
    ;