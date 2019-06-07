--day09: 

--2. 복수행 함수(그룹 함수)
--1) COUNT(*) : FROM 절에 나열된 특정 테이블의 
--              행의 개수(데이터 개수)를 세어주는 함수
--              NULL을 처리하는 "유일"한 그룹 함수 

--   COUNT(expr) : expr 으로 등장한 NULL 제외하고 세어주는 함수  


-- 문제:  dept,salagrade 테이블의 전체 데이터 개수 조회
-- 1. dept 테이블 조회

SELECT d.* 
  FROM dept d
;
/*
DEPTNO,DNAME,    LOC 
-------------------------
10	ACCOUNTING	NEW YORK  ==>SUBSTR(dname,1,5) ==> ACCOU
20	RESEARCH	DALLAS    ==>SUBSTR(dname,1,5) ==> RESEA
30	SALES	    CHICAGO   ==>SUBSTR(dname,1,5) ==> SALES
40	OPERATIONS	BOSTON    ==>SUBSTR(dname,1,5) ==> OPERA
*/ 


/*
DEPTNO,DNAME,    LOC 
-------------------------
10	ACCOUNTING	NEW YORK  ==>
20	RESEARCH	DALLAS    ==>
30	SALES	    CHICAGO   ==> 4
40	OPERATIONS	BOSTON    ==>
*/ 


--2. dept테이블의 데이터 개수 죄회 : COUNT(*) 사용
SELECT COUNT(*) 부서개수
  FROM dept d
;
--결과: 4

SELECT COUNT(*) "급여 등급 개수" 
  FROM salgrade s 
; 
--결과 : 5 

-- COUNT(expr) 이  NULL 데이터를 처리하지 못하는 것 확인을 위한 데이터 추가 
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME) VALUES ('7777', 'JJ'); 
COMMIT; 

--emp테이블에서 job 컬럼의 데이터 개수를 카운트 
SELECT COUNT(*)  "전체"
     , COUNT(e.job) "job NULL값이 존재할때"
  FROM emp e
; 
/*
전체, job NULL값이 존재할때
---------------------------
15	        14
*/



/*
7369	SMITH    ==>
7900	JAMES    ==>
7654	MARTIN   ==>
7521	WARD     ==>
7934	MILLER   ==>
7844	TURNER   ==>
7499	ALLEN    ==>
7782	CLARK    ==> 개수를 세는 기준 컬럼인 job에 null인 
7698	BLAKE    ==> 행은 처리 하지 않는다. 
7566	JONES    ==>
7902	FORD     ==> COUNT(e.job) ==> 14
7839	KING     ==>
8888	J%JAMES  ==>
9999	J_JAMES  ==>
7777	JJ       ==>
*/


--문제)회사에 매니저가 배정된 직원이 몇명인가 
--    별칭 : 상사가 있는 직원의 수 
SELECT COUNT(e.mgr) "상사 존재 인원"
  FROM emp e 
; 
-- 결과 : 11

SELECT COUNT(e.mgr = 7698) "상사 존재 인원"
  FROM emp e 
; 

--문제) 매니저 직을 맡고 있는 직원이 몇명인가? 
-- 1. emp 테이블의 mgr 컬럼의 데이터 형태를 파학 
-- 2. mgr컬럼의 중복 데이터를 제거 

SELECT DISTINCT e.mgr  
  FROM emp e 
; 

/*
MGR 
-----
7782
7698
7902
7566
(null)
7839
*/
-- 3. 중복 데이터가 제거된 결과를 카운트

SELECT COUNT(DISTINCT e.mgr)  "매니저 수"
  FROM emp e 
;
-- 결과 : 5


-------------------------------------------------
--문제) 부서가 배정된 직원이 몇명이나 있는가? 
SELECT COUNT(e.deptno) 
  FROM emp e 
;

SELECT e.deptno 
  FROM emp e  
 WHERE e.deptno IS NOT NULL
;
---------------------------------------------------------------------------
--문제) 전체인원, 부서 배정인원, 부서 미배정 인원을 구하시오 
SELECT COUNT(*) 전체 
     , COUNT(e.deptno) 배정인원
     , COUNT(*) - COUNT(e.deptno) 미배정
  FROM emp e
;
---------------------------------------------------------------------------- 
--SUM(expr) : NULL 항목 제외하고 합산 가능한 행을 모두 더한 결과를 출력  
-- SALESMAN 들의 수당 총합을 구해보자 

SELECT SUM(e.comm) "수당 총합" 
  FROM emp e  
; 
--(null)을 제외시키면서 SUM을 수행

SELECT SUM(e.comm) "수당 총합"  --필터링이 된 결과를 받고 마지막으로 수행
  FROM emp e 
 WHERE e.job = 'SALESMAN'   --여기서 먼저 필터링 시작
;
-- 처음부터 NULL값이 제외된 결과에서 SUM을 수행 
--결과 : 2200 

--수당 총합 결과에 출력 패턴을 적용 $ , 세자리 끊어 읽기 적용 
SELECT TO_CHAR(SUM(e.comm),'$9,999') 
  FROM emp e 
;
--결과 :  $2,200 
---------------------------------------------------------------------------- 

--3) AVG(expr) NULL 값 제외하고 연산 가능한 항목의 산술 평균을 구함 
-- SALESMAN 의 수당 평균을 구해보자  
-- 수당 평균 결과에 숫자 출력 패턴  $ , 세자리 끊어 일기 적용 

SELECT TO_CHAR(AVG(e.comm),'$9,999') 
  FROM emp e 
;
----------------------------------------------------------------------------
-- 4) MAX(expr) : expr에 등장한 값 중 최댓값을 구함
--                expr이 문자 경우 알파벳순 뒤쪽에 위치한 글자를 최대값으로 계산  

--이름이 가장 나중인 직원 
SELECT MAX(e.ename) 
  FROM emp e 
;
-- 5) MIN(expr) : expr에 등장한 값 중 최소값을 구함
--                expr이 문자 경우 알파벳순 앞쪽에 위치한 글자를 최대값으로 계산  
SELECT MIN(e.ename) 
  FROM emp e 
;

-------------------------------------------------------------------------------
-- GROUP BY 절의 사용 

-- 문제) 각부서별로 급여의 총합을 조회 
-- 총합 SUM사용 , 급룹화 기준을 부서번호 사용 
-- GROUP BY 절이 등장해야 함 
-- 그룹화를 하려면 기준 컬럼이 GROUP BY절에 등장해야 함

--1. 
SELECT SUM(e.sal) 
  FROM emp e
;

SELECT e.deptno
     , SUM(e.deptno)
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno
;

/*
10	30
20	60
30	180
*/

-- GROUP BY 절에 등장하면 오류 , 실행 불가

SELECT e.deptno
     , e.job     -- 원인
     , SUM(e.deptno)
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno
;
-- 결과 : ORA-00979: GROUP BY 표현식이 아닙니다.

-- 문제) 각부서별로 급여의 총합 , 평균, 최대, 최소를 조회  
SELECT e.deptno
     , TO_CART(SUM(e.deptno) , '$999,999') 총합
     , TO_CART(AVG(e.deptno) , '$999,999') 평균
     , TO_CART(MAX(e.deptno) , $'999,999') 최대
     , TO_CART(MIN(e.deptno) , $9'99,999') 최소
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno
;


SELECT TO_CHAR(SUM(e.sal) , '$999,999') 총합
     , TO_CHAR(AVG(e.sal) , '$999,999') 평균
     , TO_CHAR(MAX(e.sal) , '$999,999') 최대
     , TO_CHAR(MIN(e.sal) , '$999,999') 최소
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno
;


--위의 쿼리는 수행은 되지만 정확하게 어느 부서의 결과인지 알수 없다는 단점이 존재 
-- 그래서 GROUP BY절에 등장하는 기준 컬럼은 SELECT 절에 똑같이 등장하는 편이 결과 해석에 편리하다 
-- SELECT 절에 나열된 컬럼중에서 그룹함수가 사용되지 않는 컬럼이 없기 때문에 위의 쿼리는 수행되는 것이다.

SELECT e.deptno 
     , TO_CHAR(SUM(e.sal) , '$999,999') 총합
     , TO_CHAR(AVG(e.sal) , '$999,999') 평균
     , TO_CHAR(MAX(e.sal) , '$999,999') 최대
     , TO_CHAR(MIN(e.sal) , '$999,999') 최소
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno
;

--오류상황 
--a. GROUP BY 절에 그룹화 기준이 누락된 경우  


SELECT e.deptno 
     , e.job
     , SUM(e.sal) 총합
     , AVG(e.sal) 평균
     , MAX(e.sal) 최대
     , MIN(e.sal) 최소
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno
; 
--결과 : RA-00979: GROUP BY 표현식이 아닙니다.

--b) SELECT 절에 그룹함수와 일반 컬럼이 섞여 등장 GROUP BY 절 전체가 누락된 경우 

SELECT e.deptno 
     , e.job
     , TO_CHAR(SUM(e.sal) , '$999,999') 총합
     , TO_CHAR(AVG(e.sal) , '$999,999') 평균
     , TO_CHAR(MAX(e.sal) , '$999,999') 최대
     , TO_CHAR(MIN(e.sal) , '$999,999') 최소
  FROM emp e 
-- GROUP BY e.deptno
 ORDER BY e.deptno 
;
--결과 : ORA-00937: 단일 그룹의 그룹 함수가 아닙니다 

---------------------------------
--문제) 직무 (job) 별 급여의 총합 ,평균, 최대, 최소 를 구해보자 
-- 별칭 :직무, 급여총합, 급여평균, 최대급여, 최소급여 

SELECT e.job
     , TO_CHAR( SUM(e.sal), '$99,999') 급여총합
     , TO_CHAR( AVG(e.sal), '$99,999.9') 급여평균
     , TO_CHAR( MAX(e.sal), '$99,999') 최대급여
     , TO_CHAR( MIN(e.sal), '$99,999') 최소급여
  FROM emp e 
 GROUP BY e.job  
 ORDER BY e.job 
;

/* 
JOB,    급여총합,    급여평균,     최대급여,   최소급여
ANALYST	  $3,000	  $3,000.00	  $3,000	  $3,000
CLERK	  $3,050	  $1,016.67	  $1,300	    $800
MANAGER	  $8,275	  $2,758.33	  $2,975	  $2,450
PRESIDENT $5,000	  $5,000.00	  $5,000	  $5,000
SALESMAN  $5,600	  $1,400.00	  $1,600	  $1,250
							
*/


SELECT NVL(e.job, '직무 미배정') 직무 
     , TO_CHAR( SUM(e.sal), '$99,999') 급여총합
     , TO_CHAR( AVG(e.sal), '$99,999.9') 급여평균
     , TO_CHAR( MAX(e.sal), '$99,999') 최대급여
     , TO_CHAR( MIN(e.sal), '$99,999') 최소급여
  FROM emp e 
 GROUP BY e.job  
 ORDER BY e.job 
; 

/* 
JOB,    급여총합,    급여평균,     최대급여,   최소급여
ANALYST	  $3,000	  $3,000.00	  $3,000	  $3,000
CLERK	  $3,050	  $1,016.67	  $1,300	    $800
MANAGER	  $8,275	  $2,758.33	  $2,975	  $2,450
PRESIDENT $5,000	  $5,000.00	  $5,000	  $5,000
SALESMAN  $5,600	  $1,400.00	  $1,600	  $1,250
직무 미배정								
*/ 

SELECT NVL(e.deptno , '직무 미배정') 직무 
     , TO_CHAR( SUM(e.sal), '$99,999') 급여총합
     , TO_CHAR( AVG(e.sal), '$99,999.9') 급여평균
     , TO_CHAR( MAX(e.sal), '$99,999') 최대급여
     , TO_CHAR( MIN(e.sal), '$99,999') 최소급여
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno 
;  
-- deptno 는 숫자이기때문에 오류가 발생 

--해결방법1
SELECT NVL(TO_CHAR(e.deptno), '직무 미배정') 직무 
     , TO_CHAR( SUM(e.sal), '$99,999') 급여총합
     , TO_CHAR( AVG(e.sal), '$99,999.9') 급여평균
     , TO_CHAR( MAX(e.sal), '$99,999') 최대급여
     , TO_CHAR( MIN(e.sal), '$99,999') 최소급여
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno 
;  
--해결방법2
SELECT NVL( e.deptno || '직무 미배정') 직무 
     , TO_CHAR( SUM(e.sal), '$99,999') 급여총합
     , TO_CHAR( AVG(e.sal), '$99,999.9') 급여평균
     , TO_CHAR( MAX(e.sal), '$99,999') 최대급여
     , TO_CHAR( MIN(e.sal), '$99,999') 최소급여
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno 
;  

--해결방법3 
SELECT DECODE(NVL(e.deptno, 0), e.deptno, TO_CHAR(e.deptno)
                                      ,0,'부서 미배정') "부서 미배정"
     , TO_CHAR( SUM(e.sal), '$99,999') 급여총합
     , TO_CHAR( AVG(e.sal), '$99,999.9') 급여평균
     , TO_CHAR( MAX(e.sal), '$99,999') 최대급여
     , TO_CHAR( MIN(e.sal), '$99,999') 최소급여
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno 
;  




----------------------------------------------------------------------------------

---4.HAVING 
-- GROUP BY 결과에 조건을 걸어서 결과를 제한할 목적으로 사용되는 절 
-- WHERE 절 과 비슷함 , 하지만 실행순서가 WHERE이 먼져 되기 때문에 GROUP  
-- GROUP BY를 제한할 수 없다. 
-- 따라서 GROUP BY 다음 수행순서를 가지는 HAVING에서 제한한다
 
-- 문제) 부서별 급여 평균이 2000이상인 부서를 조화하여라 

--a. 우선 부서별 급여 평균을 구한다.
SELECT e.deptno 
     , AVG(e.sal) 
  FROM emp e
 GROUP BY e.deptno
;
--b. a결과에 급여 평균이 2000 이상인 값만 남긴다. 
SELECT e.deptno 
     , TO_CHAR(AVG(e.sal), '$99,999.99') 평균 
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000  
/*
HAVING 평균 >= 2000  
안된다. 엘리어스 사용 단됨
*/
;

/*
1.FROM       절의 테이블 각 행 모두를 대상으로 
2.WHERE      절의 조선에 맞는 행만 선택하고 
3.GROUP BY   절에 나온 컬럼, 식(함수 식), 으로 그룹화 진행 
4.HAVING     절에 조건을 만족시키는 그룹행만 선택
             4까지 선택된 그룹 정보를 가진행에 대해서 
5. SELECT    SELECT절에 명시된 컬럼, 식(함수 식)만 출력
6. ORDER BY  ORDER BY가 있다면 정렬 조건에 맞추어 최종 정렬하여 결과 출력
*/

-----------------------------------------------------------------------------------

-- 수업중 실습

-- 1. 매니저별, 부하직원의 수를 구하고, 많은 순으로 정렬
--   : mgr 컬럼이 그룹화 기준 컬럼
SELECT e.mgr 
     , COUNT(mgr)
  FROM emp e
 GROUP BY e.mgr  
;

-- 2.1 부서별 인원을 구하고, 인원수 많은 순으로 정렬
--    : deptno 컬럼이 그룹화 기준 컬럼

-- 2.2 부서 배치 미배정 인원 처리


-- 3.1 직무별 급여 평균 구하고, 급여평균 높은 순으로 정렬
--   : job 이 그룹화 기준 컬럼
SELECT e.job 
     , ORDER BY(AVG(e.sal))
  FROM emp e
 GROUP BY e.job 
 --ORDER BY e.sal
;

-- 3.2 job 이 null 인 데이터 처리


-- 4. 직무별 급여 총합 구하고, 총합 높은 순으로 정렬
--   : job 이 그룹화 기준 컬럼


-- 5. 급여의 앞단위가 1000미만, 1000, 2000, 3000, 5000 별로 인원수를 구하시오
--    급여 단위 오름차순으로 정렬


-- 6. 직무별 급여 합의 단위를 구하고, 급여 합의 단위가 큰 순으로 정렬



-- 7. 직무별 급여 평균이 2000이하인 경우를 구하고 평균이 높은 순으로 정렬



-- 8. 년도별 입사 인원을 구하시오

