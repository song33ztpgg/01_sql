-- SQL day 03 

-- * SQL SELECT 구문의 작동원리: 
-- >> 테이블 FROM 절에 나열된 의 한 행 기본단위로 실행한다.
-- >> 테이블 행의 개수만큼 반복 실행한다. 

-- 만약 다음과 같은 구문을 실행한다면 결과는 어떻게 될까? 
SELECT 'HELLO, SQL ' --컬럼명이 아닌 고정된 값을 조회하면 어떻게 될까? 
  FROM emp 
;
/* 
'HELLO,SQL'
----------------
HELLO, SQL 
HELLO, SQL 
HELLO, SQL 
HELLO, SQL 
HELLO, SQL 
HELLO, SQL 
HELLO, SQL 
HELLO, SQL 
HELLO, SQL 
HELLO, SQL 
HELLO, SQL 
HELLO, SQL 
*/

SELECT 'HELLO, SQL ' AS greeting--컬럼명이 아닌 고정된 값을 조회하면 어떻게 될까? 
    ,  empno --테이블에 존재하는 컬럼명을 섞어서 쓰면 어떻게 될까
    ,  ename
  FROM emp 
; 

/* 
GREETING,   EMPNO,  ENAME 
-------------------------
HELLO, SQL 	7369	SMITH
HELLO, SQL 	7499	ALLEN
HELLO, SQL 	7521	WARD
HELLO, SQL 	7566	JONES
HELLO, SQL 	7654	MARTIN
HELLO, SQL 	7698	BLAKE
HELLO, SQL 	7782	CLARK
HELLO, SQL 	7839	KING
HELLO, SQL 	7844	TURNER
HELLO, SQL 	7900	JAMES
HELLO, SQL 	7902	FORD
HELLO, SQL 	7934	MILLER
*/



-- WHERE 조건절
--16) emp 테이블에서empno가 7900인 사원의 
--    사번, 이름, 직무, 입사일, 급여, 부서번호를 조회하시오.
SELECT e.empno 
    ,  e.ename
    ,  e.job
    ,  e.hiredate
    ,  e.sal
    ,  e.deptno
  FROM  emp e 
 WHERE e.empno = 7900 --empno컬럼에서 7900과 동등한 결과값의 전체행을 복사 
;
/* 
  EMPNO, ENAME, JOB,     HIREDATE,  SAL, DEPTNO 
  ------------------------------------------
  7900	JAMES	CLERK	81/12/03	950 	30
*/ 
  
 ---------------------------------------------------------------------------- 
  -- 17) emp테이블에서 empno가 7900이거나 20인 직원의 
  -- 사번, 이름, 직무,입사일, 급여 ,부서번호 
  
SELECT e.empno 
     , e.ename 
     , e.job 
     , e.hiredate 
     , e.sal 
     , e.deptno
  FROM emp e 
 WHERE e.empno = 7900 
    OR e.deptno =20
;
/* 
EMPNO,  ENAME,   JOB,   HIREDATE,   SAL, DEPTNO 
-------------------------------------------
7369	SMITH	CLERK	80/12/17	800	20
7566	JONES	MANAGER	81/04/02	2975	20
7900	JAMES	CLERK	81/12/03	950	30
7902	FORD	ANALYST	81/12/03	3000	20
*/
  
---------------------------------------------------------------------------- 
--18)17번의 죄회 조건 (empno가 7900, deptno가 20)을 AND로 결함 
--   emp 테이블에서 enmpno가 7900이고 deptno가 20인 직원의 
--   사번, 이름 ,직무, 입사일,급여,부서번호를 조회하시오
SELECT e.empno
    ,  e.ename
    ,  e.job
    ,  e.hiredate
    ,  e.sal
    ,  e.deptno
  FROM emp e 
 WHERE e.empno = 7900 
   AND e.deptno = 20
; 
--인출된 모든 행 : 0 
-- >> WHERE 조건절을 만족하는 행이 emp테이블에 존재하지 않으므로 
--    조회된 행이 1건도 없음을 의미 오류결과가 나임에 주의  
--    또한 SELECT절에 나열된 컬럼명은 존재하는 결과를 확인

----------------------------------------------------------------------------

--19) job이 'CLERK' 이면서 deptno가 10인 직원의 
--    사번,이름,직무,부서번호를 조회하시오 
--    조선에 문자열 비교가 붙은 문제 

SELECT e.ename 
    ,  e.empno
    ,  e.job 
    ,  e.deptno
  FROM emp e 
 WHERE e.job ='CLERK' -- 문자열을 비교할때 '' 사용 , '' 안에서는 대소문자 구별함
   AND e.deptno =10  -- 숫자값 비교시에는 따옴표 사용안함
;

/*
ENAME,  EMPNO,  JOB,  DEPTNO 
----------------------------
MILLER	7934	CLERK	10
*/


SELECT e.ename 
    ,  e.empno
    ,  e.job 
    ,  e.deptno
  FROM emp e 
 WHERE e.job ='Clerk' -- 문자열을 비교할때 '' 사용 , '' 안에서는 대소문자 구별함
   AND e.deptno =10  -- 숫자값 비교시에는 따옴표 사용안함
;

-->>Clek이라는 값은 데이터에 존재하지 않으므로 
--  CLERK으로 존재하는 데이터와 대소문자가 일치 하지 않으면 다른값으로 처리한다.

---------------------------------------------------------------------------- 

--(6) 연산자 : 1.산술연산자 
-- 21) emp 테이블에서 
--     사번, 이름, 급여를 조회하고 
--     급여의 3.3%에 해당하는 원천징수 세금을 계산하여 조회하시오
SELECT e.empno 
    ,  e.ename 
    ,  e.sal 
    ,  e.sal * 0.033 tax
  FROM emp e
;

--실수령액 96.7%의 급여도 계산하여 조회
SELECT e.empno 
    ,  e.ename 
    ,  e.sal 
    ,  e.sal * 0.033 tax 
    ,  e.sal * 0.967 "REAL SAL"
  FROM emp e
;

/*  
EMPNO,  ENAME,  SAL,    TAX,    REAL SAL 
--------------------------------------
7369	SMITH	800	    26.4	773.6
7499	ALLEN	1600	52.8	1547.2
7521	WARD	1250	41.25	1208.75
7566	JONES	2975	98.175	2876.825
7654	MARTIN	1250	41.25	1208.75
7698	BLAKE	2850	94.05	2755.95
7782	CLARK	2450	80.85	2369.15
7839	KING	5000	165	    4835
7844	TURNER	1500	49.5	1450.5
7900	JAMES	950	    31.35	918.65
7902	FORD	3000	99	    2901
7934	MILLER	1300	42.9	1257.1
*/

SELECT e.empno 
    ,  e.ename 
    ,  e.sal 
    ,  e.sal * 0.033 tax 
    ,  e.sal * (1 - 0.033) "REAL SAL"
  FROM emp e
;


----------------------------------------------------------------------------  
/*
SELECT e.empno 
     , e.ename 
     , e.job 
     , e.hiredate 
     , e.sal 
     , e.deptno
  FROM emp 
  ------------
  SELECT e.empno 
     , e.ename 
     , e.job 
     , e.hiredate 
     , e.sal 
     , e.deptno
  FROM emp  
 WHERE e.job ='ALLEN'
  ;
  ------------
  SELECT e.empno 사번 
     , e.ename 이름
     , e.job 직업
     , e.hiredate 입사일
     , e.sal 급여
     , e.deptno 부서번호
  FROM emp  
 WHERE deptno = 20 
 ;

*/