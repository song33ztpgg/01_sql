-- day04 : 실습 4일차 

--(6) 연산자 2.비교연산자
--    비교 연산자는SELECT 절에 사용할수 없음 
--    WTERE, HAVING 절에만 사용할수 있음. 


-- 22) 급여가 2000이 넘는 직원의 사번 ,이름 ,급여를 조회 

SELECT e.empno 사번
    ,  e.ename 이름
    ,  e.sal 급여
  FROM emp e 
 WHERE e.sal > 2000
; 
/*
사번,    이름,   급여 
---------------------
7566	JONES	2975
7698	BLAKE	2850
7782	CLARK	2450
7839	KING	5000
7902	FORD	3000
*/

-- 급여가 1000 이상인 직원의 사번,이름 ,급여를 조회 

SELECT e.empno
    ,  e.ename 
    ,  e.sal
 FROM emp e 
WHERE e.sal >= 1000 
;
/*
EMPNO,  ENAME,  SAL
--------------------
7499	ALLEN	1600
7521	WARD	1250
7566	JONES	2975
7654	MARTIN	1250
7698	BLAKE	2850
7782	CLARK	2450
7839	KING	5000
7844	TURNER	1500
7902	FORD	3000
7934	MILLER	1300
*/

--급여가 1000이상이며 2000보다 작은  
--직원의 이름 급여 사원 조회 

SELECT e.empno
     , e.ename 
     , e.sal
  FROM emp e 
 WHERE e.sal >= 1000 
   AND e.sal <= 2000 
;
/* 
EMPNO,  ENAME,  SAL
--------------------
7499	ALLEN	1600
7521	WARD	1250
7654	MARTIN	1250
7844	TURNER	1500
7934	MILLER	1300
*/

-- comm(수당) 값이 0 보다 큰 직원의 사번, 이름 , 급여, 수당 조회
SELECT e.empno 
     , e.ename 
     , e.sal
     , e.comm
  FROM emp e  
 WHERE e.comm > 0 
;

/* 
EMPNO,  ENAME,  SAL,    COMM 
------------------------------
7499	ALLEN	1600	300
7521	WARD	1250	500
7654	MARTIN	1250	1400
*/ 

/*
==> 위의 comm > 0 조선의 실행 결과에서 알수있는것 
comm 컬럼의 값이 (null)인 사람들의 행은 처름부터 비교 대상에 들지 않음에 주의해야 한다. 
(null) 값은 비교연산자, 산술 연산자로 연산 할수 없는 값이다. 

단 정렬에서는 null값은 가장 큰 값으로 취급한다.

*/

-------------------------------------------------------------------------------------------- 

--23) null 데이터 관련 문제 
--    SALESMAN(영업 사원) 직무를 가진 사람의 실제 수령금을 계산하여 
--    사번, 아름, 직무, 실 수령금을 조회

SELECT e.empno 
     , e.ename  
     , e.job  
     , e.sal
     , e.comm
     , e.sal +e.comm "실 수령금" 
  FROM emp e 
 WHERE e.job ='SALESMAN'
;

-- ==> NULL 데이터는 산술 연산자로 연산 불가능 한 값

/*
EMPNO,  ENAME,  JOB,        SAL,    COMM, 실 수령금 
----------------------------------------------------
7499	ALLEN	SALESMAN	1600	300	    1900
7521	WARD	SALESMAN	1250	500	    1750
7654	MARTIN	SALESMAN	1250	1400	2650
7844	TURNER	SALESMAN	1500	0	    1500
*/

-------------------------------------------------------------------------------------------- 

--(6) 연산자 3. 논리 연산자 

--24) 급여가 2000보다 적지 않은 직원의 
--    사번, 이름, 급여를 조회 

SELECT e.empno 
     , e.ename 
     , sal
  FROM emp e 
 WHERE NOT e.sal < 2000 
;

SELECT e.empno 
     , e.ename 
     , sal
  FROM emp e 
 WHERE e.sal >= 2000 
;

/*
EMPNO, ENAME,    SAL 
---------------------
7566	JONES	2975
7698	BLAKE	2850
7782	CLARK	2450
7839	KING	5000
7902	FORD	3000
*/

-------------------------------------------------------------------------------------------- 

--(6) 연산자 4..SQL 연산자 
-- IN 연산자 : 비교하고자 하는 기준 값이 제시된 목록에 존재하면 참으로 판단

--25)급여가 800 , 300, 5000 중에 하나인 직원의 사번 이름 급여를 조회 

SELECT e.empno
     , e.ename
     , e,sal
  FROM emp e 
 WHERE e.sal IN (800,3000,5000)
; 

--OR 연산자와 3개의 조건으로 동일한 결과를 내는 쿼리

SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e 
 WHERE e.sal = 800 
    OR e.sal = 3000
    OR e.sal = 5000
; 

/*
EMPNO,  ENAME,  SAL 
--------------------
7369	SMITH	800
7839	KING	5000
7902	FORD	3000
*/

-------------------------------------------------------------------------------------------- 

--LIKE 연산자 : 유사값을 검색할때 사용
--              정확한 값을 알지 못할때 사용
--LIKE 연산자의 패턴 문자 : 유사 값 검색을 위해 연산자와 함께 사용하는 기호
-- % : 이 기호의 자리에 0자릿수 이상의 모든 문자가 올 수 있음 
-- _ : 이 기호의 자리에 1자리의 모든 문자가 올 수 있음

--26) 이름이 J 로 시작하는 직원의 사번, 이름 조회 

SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.ename LIKE 'J%' 
;

/*
EMPNO,  ENAME 
---------------
7566	JONES
7900	JAMES
*/

--이름이 M으로 시작하는 직원의 사번 이름 조회 

SELECT e.empno 
     , e.ename
  FROM emp e 
 WHERE e.ename LIKE 'M%' 
;

/*
EMPNO,  ENAME 
-----------------
7654	MARTIN
7934	MILLER
*/


--이름이 M이 들어가는 직원의 사번 이름 조회 

SELECT e.empno 
     , e.ename
  FROM emp e  
 WHERE e.ename LIKE '%M%' 
;

/*
EMPNO,  ENAME 
---------------
7369	SMITH
7654	MARTIN
7900	JAMES
7934	MILLER
*/

-- 이름의 세번째 자리에 m이 들어가는 직원의 사번 이름 

SELECT e.empno 
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '__M%' --패턴 익식문자 _를 두번 사용하여 M 앞자리를 2글자로 제한
;

/*
EMPNO, ENAME
----------------
7900	JAMES
*/

--이름의 둘째자리부터 LA가 들어가는 이름을 가진 직원의 사번 이름 조회 

SELECT e.empno 
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '_LA%'
;

/*
EMPNO, ENAME
7698	BLAKE
7782	CLARK
*/

INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME ,JOB)
VALUES('9999','J_JAMES', 'CLERK')
; 

INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME ,JOB)
VALUES('8888','J%JAMES', 'CLERK')
; 
COMMIT; 

--이름이 J_로 시작하는 직원의 사번 이름을 죄회 
-- 조회하여는 패턴 인식 문자 (%, _) 가 들어 있는 데이터는 어떻게 조회할것인다

-- ==> 위처럼 LIKE 조건을 작성하면 J 뒤에 적어도 1글자가 있는 
--     이름을 가진 직원이 모두 검색됨 , 원하는 결과가 아니다 

--     패턴 인식 문자를 조회하려면 ESCAPE를 사용해야 한다 
--     패턴 인식 문자를 무효화하려면 ESCAPE를 사용해야 한다 

SELECT e.empno 
     , e.ename
  FROM emp e
 WHERE e.ename LIKE 'J\_%' ESCAPE '\'
;

/*
EMPNO,  ENAME
--------------------
9999	J_JAMES 
*/


SELECT e.empno 
     , e.ename
FROM emp e
WHERE e.ename LIKE 'J\%%' ESCAPE '\'
;

/*
EMPNO,  ENAME
------------------
8888	J%JAMES
*/


-------------------------------------------------------------------------------------------- 

--NULL에 관련된 SQL 연산자 : IS NULL, IS NOT NULL
--비교하려 하는 컬럼의 값이 NULL 일때 true  
--비교하려 하는 컬럼의 값이 NULL 이 아니면 false 
--IS NOT NULL 
--비교하려 하는 컬럼의 값이 NULL 이 아닐때 true  
--비교하려 하는 컬럼의 값이 NULL 일때 false   
--NULL 값을 가진 컬럼은 비교연산자 와 연산이 불가능하므로 
--NULL 값을 비교를 위한 연산자가 따로 존재함에 주의! 

--col = NULL => NULL에 대해서는 동일비교(=) 연산자 사용 못함
--col != NULL 
--col <> NULL => NULL에 대해서는 다름을 비교하는 연산자(<>,=!) 사용 못함

--27)상사(mgr)가 지정되지 않은 직원의 사번, 이름, 상사사번 조회 
SELECT e.empno
     , e.ename 
     , e.mgr
  FROM emp e 
 WHERE e.mgr IS NULL -- e.mgr = NULL로 하면 안된다.
;

/*
EMPNO,  ENAME,  MGR 
--------------------------
9999	J_JAMES	
8888	J%JAMES	
7839	KING	
*/
--상사(mgr)가 지정된 직원의 사번, 이름, 상사사번 조회 
SELECT e.empno
     , e.ename 
     , e.mgr
  FROM emp e 
 WHERE e.mgr IS NOT NULL -- e.mgr != NULL로 하면 안된다. , 실행에는 문제가 없다
;

-------------------------------------------------------------------------------------------- 
--BETWEEN a AND b :범위 포함 비교 연산자 
--a <= sal <= b 이러한범위 연산과 동일한 결과
-- a <= sal <= b 보다는  sal <= sal 

--28)급여가 500 ~ 1200사이인 직원의 
--사번, 이름, 급여 조회 

SELECT e.empno 
     , e.ename 
     , e.sal 
  FROM emp e 
 WHERE e.sal BETWEEN 500 AND 1200 
;


/*
EMPNO,  ENAME,  SAL 
---------------------
7369	SMITH	800
7900	JAMES	950
*/

--BETWEEN 500 AND 1200 같은 결과를 내는 비교 연산자로 변경 

SELECT e.empno 
     , e.ename 
     , e.sal
  FROM emp e 
 WHERE e.sal > 500 
   AND e.sal < 1200 
;


-------------------------------------------------------------------------------------------- 

-------------------------------------------------------------------------------------------- 

-------------------------------------------------------------------------------------------- 

-------------------------------------------------------------------------------------------- 

-------------------------------------------------------------------------------------------- 

-------------------------------------------------------------------------------------------- 

-------------------------------------------------------------------------------------------- 
