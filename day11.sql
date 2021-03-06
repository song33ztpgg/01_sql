--day11
-----7.조인과 서브쿼리 
--(2) 서브쿼리 : Sub-Query
--명령문 문장을 연결할 때 사용 

-- SELECT , FROM , WHERE 절에 사용될 수 있다. 

--문제) BLAKE와 직무(job)가 동일한 직원의 정보를 조회
--1.balck 의 직무를 조회(서브쿼리)
SELECT e.job 
  FROM emp e 
 WHERE e.ename ='BLAKE' 
; 
/*
MANAGER
*/ 

--2.1의 결과를 적용(메인쿼리) 
-- => 직무(job)가 MANAGER인 사람을 조회하여라 

SELECT e.empno   
     , e.ename
  FROM emp e 
 WHERE e.job ='MANAGER' 
; 


--MANAGER 값 자리에 1의 쿼리가 통으로 들어간다
SELECT e.empno   
     , e.ename
  FROM emp e 
 WHERE e.job =(SELECT e.job 
                 FROM emp e 
                WHERE e.ename ='BLAKE' ) -- 이것이 서브쿼리
; 
-- 메인쿼리의 WHERE절 ()괄호 안에 전달되는 값은 
-- 1번 쿼리의 결과인 MANAGER라는 값이다.

/*
SELECT e.empno ┐____  
     , e.ename ┘   
  FROM emp e 
 WHERE e.job(문자형식) = (SELECT e.job(문자형식) 
                           FROM emp e 
                          WHERE e.ename ='BLAKE' ) -- 이것이 서브쿼리
*/
------------------------------------------------------------------------------------------
/*
--서브퀘리 수업중 실습 
--1.이 회사의 평균 급여보다 급여를 많이 받는 직원을 모두 조회하여라 
-- 사번, 이름, 급여를 조회 
--푸는 순서 

--a 회사의 급여 평균값을 구하는 쿼리 
SELECT TO_CHAR((AVG(e.sal)),'9999.9')
  FROM emp e 
;

--b 그 평균 값을 직접 적용하여 그 값보다 급여가 높은 직원을 구하는 쿼리
SELECT e.ename
  FROM emp e 
 WHERE e.sal > 1933.9 
;


--c b의 쿼리에서 평균값 자리에 a 쿼리를 대체  
SELECT e.ename
  FROM emp e 
 WHERE e.sal > (SELECT TO_CHAR((AVG(e.sal)),'9999.9')
                  FROM emp e )
;


--2.급여가 평균 급여보다 크면서 사번이 7700 보다 높은 직원을 조회하시오
-- 사번, 이름, 급여를 조회  
-- 그룹함수, max 
SELECT e.empno 
     , e.ename 
     , e.sal
  FROM emp e 
 WHERE e.sal > (SELECT TO_CHAR((AVG(e.sal)),'9999.9')
                  FROM emp e ) 
   AND e.empno > 7700
;

--3.각 직무별로 최대 급여를 받는 직원 목록을 조회하여라. 
-- 사번, 이름, ,직무, 급여를 조회 

--a 직무 별로 최대 급여를 구하는 쿼리: 그룹함수(MAX),그룹화 기준컬럼(job) 

SELECT e.job
     , MAX(e.sal)
  FROM emp e 
 GROUP BY e.job
;

--b a에서 구해진 최대 급여와 job이 일치하는지 적용하는 쿼리 

--c b에서 사용된 값을 a의 쿼리로 대체

--4.각 월별 입사인원을 세로로 출력하시오 
SELECT 
    --e.hiredate 
    --, COUNT() 
    -- , COUNT(DECODE(TO_CHAR( SUBSTR(e.hiredate , 4, 2) )  
      COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '01' , 1)) "1월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '02' , 1)) "2월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '03' , 1)) "3월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '04' , 1)) "4월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '05' , 1)) "5월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '06' , 1)) "6월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '07' , 1)) "7월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '08' , 1)) "8월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '09' , 1)) "9월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '10' , 1)) "10월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '11' , 1)) "11월"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '12' , 1)) "12월"
  FROM emp e 
--ORDER BY e.hiredate
;

/*  ex)
   입사월, 인원(명)
   --------------
    1월     3
    2월     2 
     │      │ 
    12월    5

개인적 풀었던 과정


*/
------------------------------------------------------------------------------------------
--서브퀘리 수업중 실습 
--1.이 회사의 평균 급여보다 급여를 많이 받는 직원을 모두 조회하여라 
-- 사번, 이름, 급여를 조회 
--푸는 순서 

--a 회사의 급여 평균값을 구하는 쿼리 
SELECT TO_CHAR((AVG(e.sal)),'9999.9')
  FROM emp e 
;

--b 그 평균 값을 직접 적용하여 그 값보다 급여가 높은 직원을 구하는 쿼리
SELECT e.ename
  FROM emp e 
 WHERE e.sal > 1933.9 
;


--c b의 쿼리에서 평균값 자리에 a 쿼리를 대체  
SELECT e.ename
  FROM emp e 
 WHERE e.sal > (SELECT TO_CHAR((AVG(e.sal)),'9999.9')
                  FROM emp e )
;


--2.급여가 평균 급여보다 크면서 사번이 7700 보다 높은 직원을 조회하시오
-- 사번, 이름, 급여를 조회  
-- 그룹함수, max 
SELECT e.empno 
     , e.ename 
     , e.sal
  FROM emp e 
 WHERE e.sal > (SELECT TO_CHAR((AVG(e.sal)),'9999.9')
                  FROM emp e ) 
   AND e.empno > 7700
;

--3.각 직무별로 최대 급여를 받는 직원 목록을 조회하여라. 
-- 사번, 이름, ,직무, 급여를 조회 

--a 직무 별로 최대 급여를 구하는 쿼리: 그룹함수(MAX),그룹화 기준컬럼(job) 

SELECT e.job
     , MAX(e.sal)
  FROM emp e 
 GROUP BY e.job
;

--b a에서 구해진 최대 급여와 job이 일치하는지 적용하는 쿼리 
SELECT e.empno 
     , e.ename 
     , e.job
     , e.sal
  FROM emp e 
 WHERE (e.job ='CLERK'      AND e.sal = 1300) 
    OR (e.job ='SALESMAN'   AND e.sal = 1600) 
    OR (e.job ='ANALYST'    AND e.sal = 3000) 
    OR (e.job ='MANAGER'    AND e.sal = 2975) 
    OR (e.job ='PRESIDENT'  AND e.sal = 5000) 
;

--c b에서 사용된 값을 a의 쿼리로 대체

SELECT e.empno 
     , e.ename 
     , e.job
     , e.sal
  FROM emp e  
WHERE e.sal IN (SELECT e.job
                     , MAX(e.sal)
                  FROM emp e 
                 GROUP BY e.job)
;
/* ORA-00913: 값의 수가 너무 많습니다  
이유: 매인쿼리는 e.sal - 1개 , 서브쿼리는[e.sal, MAX(e.sal)]-총 2개) 
     비교하는 값의 컬럼의 개수가 맞지 않아 결과를 얻을수 없음*/

SELECT e.empno 
     , e.ename 
     , e.job
     , e.sal
  FROM emp e  
 WHERE (e.job, e.sal) IN (SELECT e.job
                     , MAX(e.sal)
                  FROM emp e 
                 GROUP BY e.job)
;




--4.각 월별 입사인원을 세로로 출력하시오 
SELECT TO_CHAR(e.hiredate, 'FMMM') "입사월" 
  FROM emp e
;

-- 입사 월을 숫자값으로 변경해야 정렬이 맞습니다.
SELECT TO_CHAR(e.hiredate, 'FMMM') "입사월" 
     , COUNT(*) "인원명" 
  FROM emp e
 GROUP BY  TO_CHAR(e.hiredate, 'FMMM') 
 ORDER BY "입사월" 
; 

-- 위의 결과가 FROM 절에 통으로 들어간후 '월'을 붙여야 함 
SELECT a.month || '월' "입사월" 
     , a.cnt "인원(명)"
  FROM (SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) month 
             , COUNT(*) cnt 
          FROM emp e
         GROUP BY  TO_CHAR(e.hiredate, 'FMMM') 
         ORDER BY month) a
; 
/*
SELECT a.month || '월' "입사월" 
     , a.cnt "인원(명)"
  FROM (SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) month 
             , COUNT(*) cnt 
          FROM emp e
         GROUP BY  TO_CHAR(e.hiredate, 'FMMM') 
         ORDER BY month) a
*/



------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------