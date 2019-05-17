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

--EXISTS 연산자 : 어떤 쿼리(SELECT)을 실행한 결과가 1행 이상일때 참으로 판단  
--                인출된 모든 행:0 인 경우 거짓으로 판단 따라서 서브쿼리와 함깨 사용됨

--29) 
--  (1) 급여가 3000이 넘는 직원을 조회 
SELECT e.sal
     , e.empno 
     , e.ename
  FROM emp e
 WHERE e.sal > 3000 
; 

--7839 KING 5000 
-- 29-(1) 문제의 결과는 1행이 존재(EXISTS)
--    (2) 급여가 3000이 넘는 직원이 1명이라도 있으면 화면에 '급여가 3000이 넘는 직원이 존재함'
--        메시지를 출력하고 싶다.
 
 SELECT '급여가 3000이 넘는 직원이 존재함' AS "시스템 메시지" 
   FROM dual -- 1행만 데이터 있는 공용 테이블
  WHERE EXISTS (SELECT e.empno 
                     , e.ename
                     , e.sal
                    FROM emp e
                   WHERE e.sal > 3000)  -- 코딩이 들어와야 한다. , 1보다는 커야한다
;
/*
시스템 메시지
-----------------------------------
 급여가 3000이 넘는 직원이 존재함
 */
 
 --oracle 에만 존재하는 dual 테이블 
 --: 1행 1열의 데이터가 드어있는 공용테이블 
 -- 1)dual 테이블의 테이블 구조를 확인 
 
DESC dual; 

/*
이름    널? 유형          
----- -- ----------- 
DUMMY    VARCHAR2(1) 
*/
-- 위의 DESC는 정렬의 키워드가 아닌 오라클의 명령어 
-- 테이블의 구조를 확인하는 명령 
-- Describe 의 약자 

SELECT dummy
  FROM dual
; 

/*
DUMMY
-------
X
*/


--급여가 10000이 넘는 직원이 없으면 
--화면에 "금여가 10000이 넘는 직원이 존재하지 않음" 이라고 출력 
--(1) 급여가 10000이 넘는 직원의 정보 
SELECT e.sal
     , e.empno 
     , e.ename
  FROM emp e
 WHERE e.sal > 10000 
;  
--(2) 시스템 메시지를 출력할수 있도록 쿼리 조합 
SELECT '금여가 10000이 넘는 직원이 존재하지 않음' as "시스템 메시지"
  FROM dual 
 WHERE NOT EXISTS(SELECT e.sal
                       , e.empno 
                       , e.ename
                    FROM emp e
                   WHERE e.sal > 10000) 
;


/*
시스템 메시지
--------------------------------------
금여가 10000이 넘는 직원이 존재하지 않음
*/

-------------------------------------------------------------------------------------------- 
--(6)연산자:결합 연산자(||) 
--   오라클에만 존재 ,문자열 결합(접합) 
--   다른 프로그래밍 언어(JAVA, C , C++) 에서는 
--   OR 연산자로 사용 되므로 혼동하지 않기


SELECT 'Hello ~ SQL' || 'in Oracle' AS greeting 
  FROM dual
;


SELECT '안녕하세요 ~ SQL' || '오라클에서 배우고 있어요' AS greeting 
  FROM dual
;

--dual 테이블 활용, 오늘의 날짜를 알려주는 문장  
--ex)오늘의 날짜는 0000 입니다.

SELECT '오늘은' || sysdate || '입니다' as "오늘날짜" 
  FROM dual
;
/*
오늘날짜
--------------------
오늘은19/05/17입니다   
*/ 
--  ==>시스템 날자 00/00/00으로 표시된다 

SELECT '오늘의 날짜는' 
       ||TO_CHAR(sysdate,'YYYY-MM-DD') 
       || '입니다' as "오늘날짜" 
  FROM dual
;


--직워느이 사번 알림을 만들싶다,. 
--직원의 사번을 알려주는 ||구문을 사용하여 작성

SELECT '안녕하세요 ' ||e.ename ||'씨 당신의 사번은 '
                    ||e.empno || '입니다' AS 사번번호
  FROM emp e
;
/*
사번번호
--------------------------------------------
안녕하세요 J_JAMES씨 당신의 사번은 9999입니다
안녕하세요 J%JAMES씨 당신의 사번은 8888입니다
안녕하세요 SMITH씨 당신의 사번은 7369입니다
안녕하세요 ALLEN씨 당신의 사번은 7499입니다
안녕하세요 WARD씨 당신의 사번은 7521입니다
안녕하세요 JONES씨 당신의 사번은 7566입니다
안녕하세요 MARTIN씨 당신의 사번은 7654입니다
안녕하세요 BLAKE씨 당신의 사번은 7698입니다
안녕하세요 CLARK씨 당신의 사번은 7782입니다
안녕하세요 KING씨 당신의 사번은 7839입니다
안녕하세요 TURNER씨 당신의 사번은 7844입니다
안녕하세요 JAMES씨 당신의 사번은 7900입니다
안녕하세요 FORD씨 당신의 사번은 7902입니다
안녕하세요 MILLER씨 당신의 사번은 7934입니다
*/

-------------------------------------------------------------------------------------------- 

--(6) 연산자 6. 집합연산자 
-- 첫번째 쿼리 : 부서테이블의 모든 정보 조회
SELECT d.deptno
     , d.dname 
     , d.loc
FROM dept d
; 

-- 두번쩨 쿼리 : 부서번호가 10인 부서의 모든 정보 조회
SELECT d.deptno
     , d.dname 
     , d.loc
  FROM dept d
 WHERE d.deptno = 10
; 

--1)dept
SELECT d.deptno
     , d.dname 
     , d.loc
  FROM dept d 
 UNION ALL
SELECT d.deptno
     , d.dname 
     , d.loc
  FROM dept d
 WHERE d.deptno = 10
;

/*
DEPTNO, DNAME,    LOC
-------------------------
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
10	ACCOUNTING	NEW YORK
*/

--2) UNION :중복을 제거한 합집합 
SELECT d.deptno
     , d.dname 
     , d.loc
  FROM dept d 
 UNION 
SELECT d.deptno
     , d.dname 
     , d.loc
  FROM dept d
 WHERE d.deptno = 10
;

/*
DEPTNO, DNAME,    LOC
-------------------------
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/

--3) INTERSECT :중복된 값만 남김(교집합) 
SELECT d.deptno
     , d.dname 
     , d.loc
  FROM dept d 
INTERSECT 
SELECT d.deptno
     , d.dname 
     , d.loc
  FROM dept d
 WHERE d.deptno = 10
;

/*
DEPTNO, DNAME,    LOC
-------------------------
10	ACCOUNTING	NEW YORK
*/

--4) MINUS :첫번째 쿼리 실행결과에서 두번째 쿼리 실행 결과를 뺀 차집합 
SELECT d.deptno
     , d.dname 
     , d.loc
  FROM dept d 
MINUS
SELECT d.deptno
     , d.dname 
     , d.loc
  FROM dept d
 WHERE d.deptno = 10
;

/*
DEPTNO, DNAME,    LOC
-------------------------
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/ 

-- 주의 : 두 쿼리의 조회 결과의 컴럼의 갯수 , 데이터 타입의 순서가 일치
--1)오류상황 첫쿼리 컬럼수 3, 둘쩨쿼리 칼럼수 2 


SELECT d.deptno   --1
     , d.dname    --2
     , d.loc      --3 
  FROM dept d 
 UNION ALL
SELECT d.deptno   --1
     , d.dname    --2
  FROM dept d
 WHERE d.deptno = 10
;
/*ORA-01789: 질의 블록은 부정확한 수의 결과 열을 가지고 있습니다.*/

--2)오류상황 첫쿼리 문자, 숫자 순서 둘때 쿼리 컬럼이 숫자, 문자 순서

SELECT d.dname     --문자
     , d.deptno    --숫자
  FROM dept d 
 UNION ALL
SELECT d.deptno   --숫자
     , d.dname    --문자
  FROM dept d
 WHERE d.deptno = 10
;
/*ORA-01790: 대응하는 식과 같은 데이터 유형이어야 합니다*/


--집합연산자는 서로 다른 테이블 조회 결과도 연산 가능 
--첫번째 쿼리: emp테이블에서 조회 
SELECT e.empno 
     , e.ename 
     , e.job
FROM emp e 
;
--두번쩨 쿼리:dept테이블에서 조회 
SELECT d.deptno 
     , d.dname 
     , d.loc
FROM dept d
; 

--서로 다른 테이블에서 
--(1)UNION

SELECT e.empno 
     , e.ename 
     , e.job
FROM emp e 
UNION
SELECT d.deptno 
     , d.dname 
     , d.loc
FROM dept d
; 

/* 
EMPNO, ENAME,   JOB 
-------------------------
10	    ACCOUNTING	NEW YORK
20	    RESEARCH	DALLAS
30	    SALES	    CHICAGO
40	    OPERATIONS	BOSTON
7369	SMITH	    CLERK
7499	ALLEN	    SALESMAN
7521	WARD	    SALESMAN
7566	JONES	    MANAGER
7654	MARTIN	    SALESMAN
7698	BLAKE	    MANAGER
7782	CLARK	    MANAGER
7839	KING	    PRESIDENT
7844	TURNER	    SALESMAN
7900	JAMES	    CLERK
7902	FORD	    ANALYST
7934	MILLER	    CLERK
8888	J%JAMES	    CLERK
9999	J_JAMES 	CLERK
*/
--==>합집합 결과는 위의 값이 먼져 나오게 된다. 

--(2) MINUS

SELECT e.empno 
     , e.ename 
     , e.job
FROM emp e 
MINUS
SELECT d.deptno 
     , d.dname 
     , d.loc
FROM dept d
; 
/*
EMPNO, ENAME,   JOB 
-------------------------
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
8888	J%JAMES	CLERK
9999	J_JAMES	CLERK
*/
--(3) INTERSECT 

SELECT e.empno 
     , e.ename 
     , e.job
FROM emp e 
INTERSECT
SELECT d.deptno 
     , d.dname 
     , d.loc
FROM dept d
; 
-- =>서로다른 테이블의 데이터 조회 결과들을 가진 쿼리이므로 
--   중복된 데이터가 없으므로 교집합 결과가 1행도 없음

-------------------------------------------------------------------------------------------- 

-------------------------------------------------------------------------------------------- 

-------------------------------------------------------------------------------------------- 

-------------------------------------------------------------------------------------------- 
