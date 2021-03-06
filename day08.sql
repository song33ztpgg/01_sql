--day08 

--(3) 단일행 함수 
-- 6) CASE 
-- job별로 경조사비를 급여대비 일정비율로 지급 
/*
CLERK       : 5% 
SALESMAN    : 4% 
MANAGER     : 3.7% 
ANALYST     : 3% 
PRTSIDENT   : 1.5%
*/ 

--1.Simple CASE 구분으로 구현 
-- DECODE 와 거의 유사 , 동일비교만 가능 
-- DECODE 와 다른점 :괄호가 없음 
-- 콤마댄신 WHEN ,THEN, ELSE 등을 사용 

SELECT e.empno 
     , e.ename 
     , e.job 
     , CASE e.job WHEN 'CLERK'      THEN e.sal * 0.05 
                  WHEN 'SALEMAN'    THEN e.sal * 0.04 
                  WHEN 'MANAGER'    THEN e.sal * 0.037  
                  WHEN 'ANALYST'    THEN e.sal * 0.03 
                  WHEN 'PRESIDENT'  THEN e.sal * 0.015 
        END AS "경조사 지원금"
  FROM emp e 
;
/*
EMPNO,  ENAME,  JOB,    경조사 지원금
--------------------------------
9999	J_JAMES	CLERK	
8888	J%JAMES	CLERK	
7369	SMITH	CLERK	    40
7499	ALLEN	SALESMAN	
7521	WARD	SALESMAN	
7566	JONES	MANAGER	    110.075
7654	MARTIN	SALESMAN	
7698	BLAKE	MANAGER	    105.45
7782	CLARK	MANAGER	    90.65
7839	KING	PRESIDENT	75
7844	TURNER	SALESMAN	
7900	JAMES	CLERK	    47.5
7902	FORD	ANALYST	    90
7934	MILLER	CLERK	    65
*/

------------------------------------------------------------------------------------
--2.Searched CASE 구분으로 구현 

SELECT e.empno 
     , e.ename 
     , e.job 
     , CASE WHEN e.job = 'CLEARK'    THEN e.sal * 0.05 
            WHEN e.job = 'SALEMAN'   THEN e.sal * 0.04 
            WHEN e.job = 'MANAGER'   THEN e.sal * 0.037 
            WHEN e.job = 'ANALYST'   THEN e.sal * 0.03 
            WHEN e.job = 'PRESIDENT' THEN e.sal * 0.015 
            ELSE 10 
        END AS "경조사 지원금" 
  FROM emp e 
;

/*

*/


SELECT e.empno 
     , e.ename 
     , e.job 
     , to_char(CASE WHEN e.job = 'CLEARK'    THEN e.sal * 0.05 
                    WHEN e.job = 'SALEMAN'   THEN e.sal * 0.04 
                    WHEN e.job = 'MANAGER'   THEN e.sal * 0.037 
                    WHEN e.job = 'ANALYST'   THEN e.sal * 0.03 
                    WHEN e.job = 'PRESIDENT' THEN e.sal * 0.015 
                    ELSE 10
        END, '99,999$') "경조사 지원금" 
  FROM emp e 
;

/* SALGRADE (급여등급) 테이블 내용 
GRADE , LOSAL , HISAL 
--------------------
1	700	    1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999
*/



-- 문제  : 제공되는 급여 등급을 바탕으로 각 직원의 급여 등급을 CASE문으로 구해보자 
--         사번 이름, 급여, 급여 등극을 조회하시오

--ex) 관계연산자를 사용하는 방법
SELECT e.empno 
     , e.ename 
     , e.sal 
     , CASE WHEN e.sal >= 700   AND  e.sal < 1199 THEN 1
            WHEN e.sal >= 1200  AND  e.sal < 1399 THEN 2 
            WHEN e.sal >= 1400  AND  e.sal < 1999 THEN 3
            WHEN e.sal >= 2000  AND  e.sal < 2999 THEN 4
            WHEN e.sal >= 3000  AND  e.sal < 9999 THEN 5
            END, "급여등급" 
  FROM emp e         
  ORDER BY "급여등급" DESC 
;
--=> end를 먼져 사용 후 
--ex) between  

SELECT e.empno 
     , e.ename 
     , e.sal 
     , CASE WHEN e.saL BETWEEN 700  AND 1200 THEN 1  
            WHEN e.sal BETWEEN 1201 AND 1400 THEN 2  
            WHEN e.sal BETWEEN 1401 AND 2000 THEN 3  
            WHEN e.sal BETWEEN 2001 AND 3000 THEN 4  
            WHEN e.sal BETWEEN 3001 AND 9999 THEN 5  
        END 급여등급 
  FROM emp e        
ORDER BY 급여등급 DESC
; 

SELECT e.empno 
     , e.ename 
     , e.sal 
     , CASE WHEN e.sal IS NULL THEN 0  -- 상위에 존재할 경우 최적화가 좋다.
            WHEN e.saL BETWEEN 700  AND 1200 THEN 1  
            WHEN e.sal BETWEEN 1201 AND 1400 THEN 2  
            WHEN e.sal BETWEEN 1401 AND 2000 THEN 3  
            WHEN e.sal BETWEEN 2001 AND 3000 THEN 4  
            WHEN e.sal BETWEEN 3001 AND 9999 THEN 5 
            ELSE 0
        END 급여등급 
  FROM emp e        
ORDER BY 급여등급 DESC
; 




/* 
SALGRADE (급여등급) 테이블 내용 
GRADE , LOSAL , HISAL 
--------------------
1	700	    1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999
*/















