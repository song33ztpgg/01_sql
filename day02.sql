-- DAY 02 
-- SCOTT 계정 EMP 테이블 조회  
SELECT * 
    FROM emp
; 

------------------------------------------------------------

--1) SCOTT 계정 DEPT 테이블 조회  
SELECT * 
    FROM dept 
; 

------------------------------------------------------------

--2.DQL : SELECT 

--1)emp 테이블에서 job칼럼을 조회
SELECT job
    FROM EMP  
; 
/*
CLERK,
SALESMAN,
SALESMAN
MANAGER,
SALESMAN,
MANAGER
MANAGER,
PRESIDENT,
SALESMAN
CLERK,
ANALYST,
CLERK
*/

------------------------------------------------------------

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
*/
-->각job 이 한번씩만 조회된 결과를 얻을수 있다 
--이 결과로 회사에서는 다섯종류의job이 있음을 확인할수 있다.

------------------------------------------------------------

--3) job과 deptno를 검색
SELECT job
    , deptno  
 FROM emp
; 

/*  
JOB,    DEPTNO 
--------------
CLERK	    20
SALESMAN	30
SALESMAN	30
MANAGER	    20
SALESMAN	30
MANAGER	    30
MANAGER	    10
PRESIDENT	10
SALESMAN	30
CLERK	    30
ANALYST	    20
CLERK	    10
*/
-->  , 앞 쪽 콤마를 찍으면 콤마들이 정렬되어 있기에 실수한 것이 바로 눈에 보인다
 
------------------------------------------------------------ 

 --4)emp 테이블에서 중복을 제거하여  
 --  job,deptono를 조회 
 
SELECT DISTINCT job 
    , deptno
    FROM emp 
;

/* 
JOB,    DEPTNO
-----------
CLERK	    20
MANAGER	    20
MANAGER 	30
MANAGER 	10
SALESMAN	30
PRESIDENT	10
CLERK   	30
ANALYST	    20
CLERK	    10
*/    

--> &(and 개념으로 제거


------------------------------------------------------------

-- 5) emp테이블에서 중복을 제거 하여 
--  job을 조회하고  
-- 결과를 job의 오름차순으로 정렬하시오 

SELECT job 
    , deptno
FROM emp 
ORDER BY job /* 이부분이 옵션, 선택 안할경우 오름차순*/
;
-- 2)번 쿼리의 실행 결과와 정렬 순서가 다른것을 
-- 확인하고 넘어가자

/* 
JOB,    DEPTNO 
---------------
ANALYST	    20
CLERK	    10
CLERK	    30
CLERK	    20
MANAGER	    20
MANAGER	    30
MANAGER	    10
PRESIDENT	10
SALESMAN	30
SALESMAN	30
SALESMAN	30
SALESMAN	30
*/

------------------------------------------------------------

--6)emp테이블에서 중복을 제거하여  
-- job을 조회하고 내림차순으로 정렬
-- 5)번의 실행결과랑 비교 

SELECT DISTINCT job
  FROM  emp 
ORDER BY job DESC
; 
/* 
JOB 
----------
SALESMAN
PRESIDENT
MANAGER
CLERK
ANALYST
*/ 

------------------------------------------------------------
 
 --7)emp테이블에서 empmo(),ename(),job() 
 SELECT empno 
        ,ename
        ,job
 FROM emp 
 ;
  
  /* 
  EMPNO, ENAME, JOB 
  ----------------------
  7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7782	CLARK	MANAGER
7839	KING	PRESIDENT
7844	TURNER	SALESMAN
7900	JAMES	CLERK
7902	FORD	ANALYST
7934	MILLER	CLERK
  */


------------------------------------------------------------ 

--8)emp 테이블에서 empno, ename, job, hiredate  
--을 조회하시오 
SELECT empno 
    ,  ename 
    ,  job 
    ,  hiredate
  FROM emp 
;

/*  
EMPNO, ENAME,    JOB,       HIREDATE 
------------------------------------
7369	SMITH	CLERK	    80/12/17
7499	ALLEN	SALESMAN	81/02/20
7521	WARD	SALESMAN	81/02/22
7566	JONES	MANAGER	    81/04/02
7654	MARTIN	SALESMAN	81/09/28
7698	BLAKE	MANAGER	    81/05/01
7782	CLARK	MANAGER	    81/06/09
7839	KING	PRESIDENT	81/11/17
7844	TURNER	SALESMAN	81/09/08
7900	JAMES	CLERK	    81/12/03
7902	FORD	ANALYST	    81/12/03
7934	MILLER	CLERK	    82/01/23
*/

---------------------------------------------------------------- 

--ORDER BY: 정렬 
--9) emp 테이블에서 comm을 가장 많이 받는 순서대로  
--   empno,ename,job,hiredate,cimm 칼럼을 조회하시오 

SELECT empno 
    ,  ename 
    ,  job 
    ,  hiredate 
    ,  comm
 FROM emp 
 ORDER BY comm DESC 
; 

/* 
EMPNO, ENAME,    JOB,       HIREDATE,   COMM 
---------------------------------------------
7839	KING	PRESIDENT   81/11/17	
7566	JONES	MANAGER	    81/04/02	
7934	MILLER	CLERK	    82/01/23	
7782	CLARK	MANAGER 	81/06/09	
7654	MARTIN	SALESMAN	81/09/28	1400
7521	WARD	SALESMAN	81/02/22	500
7499	ALLEN	SALESMAN	81/02/20	300
7844	TURNER	SALESMAN	81/09/08	0
*/

--> null데이터는 항상 큰 값으로 취급 
--  따라서 DESC 정렬에서는 위쪽으로 정렬된다.
---------------------------------------------------------------- 

--10)emp테이블에서 comm은 적은 순서대로 
-- job은 오름차순 , ebane오름차순으로 정렬하여 
-- empno, ename, job, hiredate , comm을 조회하시오 

SELECT empno 
    ,  ename
    ,  job 
    ,  hiredate 
    ,  comm
  FROM emp 
ORDER BY comm, job, ename --, ebance DESC 
;

-- emp 테이블에서 
-- comm이 적은 순서대로 ,job은 오름차순 ename 내림차순 정렬하여 
-- empno, ename , job,hiredate , comm을 조회하시오 

SELECT empno 
    ,  ename 
    ,  job 
    ,  hiredate 
    ,  comm 
FROM emp 
ORDER BY comm , job, ename DESC 
;

/*  
EMPNO,  ENAME,      JOB,    HIREDATE,   COMM 
-----------------------------------------------
7844	TURNER	SALESMAN	81/09/08	0
7499	ALLEN	SALESMAN	81/02/20	300
7521	WARD	SALESMAN	81/02/22	500
7654	MARTIN	SALESMAN	81/09/28	1400
7902	FORD	ANALYST	    81/12/03	
7369	SMITH	CLERK	    80/12/17	
7934	MILLER	CLERK	    82/01/23	
7900	JAMES	CLERK	    81/12/03	
7566	JONES	MANAGER	    81/04/02	
7782	CLARK	MANAGER	    81/06/09	
7698	BLAKE	MANAGER	    81/05/01	
7839	KING	PRESIDENT	81/11/17	
*/
----------------------------------------------------------------
--Alias : 별칭
-- 11)emp테이블에서 
-- empno => Empoyee No. 
-- ename => Employee Name 
-- job   => Job Name 
-- 세 컬럼의 이름을 별칭으로 바꾸어서 조회 

SELECT empno AS "Employee NO."  --AS키워드 생략가능
    ,  ename "Employee Name"    --AS키워드 생략가능
    ,  job   "Job Name"         --AS키워드 생략가능
 FROM emp 
;
/* 
Employee NO.,    Employee Name,  Job Name 
---------------------------------------------------
        7369	    SMITH	        CLERK
        7499	    ALLEN	        SALESMAN
        7521	    WARD	        SALESMAN
        7566	    JONES	        MANAGER
        7654	    MARTIN	        SALESMAN
        7698	    BLAKE	        MANAGER
        7782	    CLARK	        MANAGER
        7839	    KING	        PRESIDENT
        7844	    TURNER	        SALESMAN
        7900	    JAMES	        CLERK
        7902	    FORD	        ANALYST
        7934    	MILLER  	    CLERK
*/
----------------------------------------------------------------
--12)한글 별칭을 사용 
--  emp 테이블에서 각 컬럼에 한글 별칭을 사용 
--  empno => 사번 
--  ename => 이 름
--  job   => 직무
-- 하여 조회하기
SELECT empno 사번 
    ,  ename "이 름" --특수문자 공백 등은 "" 가 필요
    ,  job AS 직무
FROM emp
;
/*
사번,    이 름,    직무
------------------------
7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7782	CLARK	MANAGER
7839	KING	PRESIDENT
7844	TURNER	SALESMAN
7900	JAMES	CLERK
7902	FORD	ANALYST
7934	MILLER	CLERK
*/

-----------------------------------------------------------------

--13)테이블에 별칭 설정 
-- emp 테이블에서empno, ename 을 조회하시오 

-- 1. 별칭없이 구문 작성 
SELECT empno
    ,  ename 
FROM emp 
; 

-- 2. SELECT절에 컬럼 나열할때 ,앞에 테이블 이름을 붙일수 있음
-- 테이블 이름을 붙여서 컬럼을 조회 

SELECT emp.empno 
    ,  emp.ename 
FROM emp 
; 

-- 3. FROM절에 emp테이블에 e라는 별칭을 주고  
-- SELECT 절의 컬럼앞에 테이블 별칭 E를 붙여서 조회 
SELECT e.empno -- 테이블 별칭이 사용되는 위치 : 칼럼 이름 앞
    ,  e.ename 
FROM emp e --테이블 별칭 사용위치
; 


-----------------------------------------------------------------

--14)영문 별칭을 사용할때 쌍따옴표를 사용하지 않으면 
-- => 결과 출력시 별칭이 모두 대문자화 되어 조화됨.
-- empno => Empoyee No. 
-- ename => "Employee Name" 
-- job   => "Job Name" 
SELECT e.empno AS EmpoyeeNO   -- 모두 대문자로 표기됨 
    ,  e.ename " Employee Name" 
    ,  e.job  "Job Name"
FROM emp e
;
/* 
EMPOYEENO,  Employee Name, Job Name
----------------------------------
    7369	SMITH	    CLERK
    7499	ALLEN	    SALESMAN
    7521	WARD	    SALESMAN
    7566	JONES	    MANAGER
    7654	MARTIN	    SALESMAN
    7698	BLAKE	    MANAGER
    7782	CLARK	    MANAGER
    7839	KING	    PRESIDENT
    7844	TURNER  	SALESMAN
    7900	JAMES	    CLERK
    7902	FORD	    ANALYST
    7934	MILLER  	CLERK
*/

-----------------------------------------------------------------

--15)별칭과 정렬의 조합: 
-- 컬럼에 별칭을 준 경우 ORDER BY 절에 별칭을 사용 할 수 있다. 
-- emp 테이블에서 
--  empno => 사번 
--  ename => 이름
--  job   => 직무 
--  hiredate => 입사일 
--  comm => 수당
-- 위와 같이 각 컬럼에 별칭을 주어 조회하고 
-- 수당 직무 ename 를 모두 오름차순 정렬

SELECT e.empno 사번 
    ,  e.ename 이름 
    ,  e.job 직무
    ,  e.hiredate 입사일 
    ,  e.comm 수당
 FROM emp e 
ORDER BY 수당, 직무 , e.ename
;
-- (10) 과 동일하나 별치 앗용부분만 다름 
-- =>결과 : ORDER BY 절에는 별칭과 원래 컬럼명을 섞어 쓸 수 있다.
/* 
사번,     이름,     직무,         입사일, 수당
---------------------------------------------
7844	TURNER	SALESMAN	81/09/08	0
7499	ALLEN	SALESMAN	81/02/20	300
7521	WARD	SALESMAN	81/02/22	500
7654	MARTIN	SALESMAN	81/09/28	1400
7902	FORD	ANALYST	    81/12/03	
7900	JAMES	CLERK	    81/12/03	
7934	MILLER	CLERK	    82/01/23	
7369	SMITH	CLERK	    80/12/17	
7698	BLAKE	MANAGER	    81/05/01	
7782	CLARK	MANAGER	    81/06/09	
7566	JONES	MANAGER	    81/04/02	
7839	KING	PRESIDENT	81/11/17	
*/

-----------------------------------------------------------------

-----------------------------------------------------------------
