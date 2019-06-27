-- day 10 
----7.조인과 서브쿼리 
--(1) 조인 : JOIN 
-- 하나 이사의 테이블을 논리적으로 묶어서 하나의 테이블인 것 처럼 다루는 기술
-- 조인을 발생시키려면 FROM 절에 조인에 사용할 테이블을 나열


/*
만들었던 7777,8888,9999 데이터 삭제
DELETE FROM "SCOTT"."EMP" WHERE ROWID = 'AAAR9ZAAHAAAACUAAA' AND ORA_ROWSCN = '2489006' and ( "EMPNO" is null or "EMPNO" is not null )
DELETE FROM "SCOTT"."EMP" WHERE ROWID = 'AAAR9ZAAHAAAACUAAB' AND ORA_ROWSCN = '2489006' and ( "EMPNO" is null or "EMPNO" is not null )
DELETE FROM "SCOTT"."EMP" WHERE ROWID = 'AAAR9ZAAHAAAACVAAA' AND ORA_ROWSCN = '5594872' and ( "EMPNO" is null or "EMPNO" is not null )

COMMIT;
*/


-- 문제) 직원의 소속 부서 번호가 아닌 부서 명을 같이 조회하고 싶다 
--a) FROM 절에 테이블을 나열
--   emp , dept 두 테이블을 나열 => 조인이 발생 ==> 두테이블의 모든 조합 
SELECT e.empno
     , e.ename
     , e.deptno
     , '  |' "구분자"
     , d.deptno 
     , d.dname
  FROM emp e 
     , dept d
;

--12줄(emp) * 4줄(dept) = 48개 데이터가 조인으로 생성

-- b) 조인 조건이 추가되어야 직원의 소속 부서만 정확히 연결할 수 있다.

SELECT e.empno
     , e.ename
     , e.deptno
     , '  |' "구분자"
     , d.deptno 
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno = d.deptno 
 ORDER BY d.deptno
;

-- 사번 , 이름, 부서명 만 남기면 
SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno = d.deptno 
 ORDER BY d.deptno
; 

-- 조인 연산자를 사용하여 조인(다른 DBMS 에서 주로 사용)

SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno )
 ORDER BY d.deptno
;


-- 위의 결과에서 ACCOUNTING 부서 직원만 알고 싶다. 
-- 10부서 직원을 조회하여라 
SELECT e.empno 
     , e,ename
  FROM emp e
WHERE e.deptno = 10 
;

SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno = d.deptno     -- 조인조선
   AND d.dname = 'ACCOUNTING'  -- 일반 조건
; 

--ACCOUNTING 부서 소속인 직원 조회를 
--조인 연산자를 사용한 쿼리로 변경해보세요 
 
SELECT e.empno 
     , e.ename 
FROM emp e JOIN dept d ON (e.deptno = d.deptno )
WHERE d.dname = 'ACCOUNTING'
;

--2) join: 카티션 곱(카티션 조인) 
 --         조인 대상 테이블의 데이터를 가능한 모든 조합으로 엮는 것 
--          WHERE 절에 조인 조건 누락시 발생
--          CROSS JOIN 연산자로 발생시킴(오라클 9i 버전 이후로 사용가능)

--emp, deptm salgrade 세 개의 테이블로 카티션 곱 발생
SELECT e.empno
     , d.dname
     , s.grade
  FROM emp e         --12개
     , dept d        -- 4개 
     , salgrade s    -- 5개
; 
--결과 12 * 4 * 5

SELECT e.empno
     , d.dname
     , s.grade
  FROM emp e  CROSS JOIN dept d        
              CROSS JOIN salgrade s        
; 

--3)    EQUI JOIN : 조인의가장 기본 형태 
--                  조인 대상 테이블 사이의 공통 컬럼 = 로 연결
--                  공통 컬럼을 join

SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno = d.deptno 
; 

SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno )
;



--c) NATURAL JOIN 키워드로 자동 조인 
--   : ON 절이 없음 
--     join -attribute를 오라클 DBMS 가 자동으로 판단 

SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e NATURAL JOIN dept d --조인 공통 컬럼 명시가 없음
;

--d) JOIN ~ USING
SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e JOIN dept d USING(deptno) --조인 공통 컬럼 명시가 없음
;

-- 4) 네 가지 EQUI - JOIN 구문 작성법 
--a 오라클 전통 조인 구조
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2,
  FROM 테이블1 별칭1,테이블2 별칭2[, ..] 
 WHERE 별칭1.공통컬럼1 = 별칭2.공통컬럼1 
 [AND  별칭1.공통컬럼2 = 별칭2.공통컬럼2]  -- 조인 대상 테이블이 여러개일 경우
 [AND .. ]                                  --WHERE 절에 나열되는 조인조건 늘어 
 [AND ..  추가 가능한 일반 조건들]
;
--b JOIN ~ ON
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2,
  FROM 테이블1 별칭1 JOIN 테이블2 별칭2 ON (별칭1.공통컬럼1 = 별칭2.공통컬럼1) 
                    [JOIN 테이블3 별칭3 ON (별칭1.공통컬럼2 = 별칭3.공통컬럼2)]
                    [JOIN 테이블n 별칭n ON (별칭n-1.공통컬럼n-1 = 별칭n.공통컬럼n)]
[WHERE 일반조건] 
  [AND 일반조건]
;

--c NATURAL JOIN
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2 [, ...]
  FROM 테이블1 별칭1 NATURAL JOIN 테이블2 별칭2 
                   [NATURAL JOIN 테이블n 별칭n] 
;

--d JOIN ~ USING

SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2 [, ...]
  FROM 테이블1 별칭1 JOIN 테이블2 별칭2 USING (공통컬럼) 
                    [JOIN 테이블n 별칭n USING (공통컬럼)] -- 별칭 사용없음
;

-------------------------------------------------------
5) NON-EQUI JOIN : WHERE 조건절에 join -attribute 사용하는 대신 
                다른 비교 연산자를 사용하여 여러 테이블을 엮는 기법 
--문제 ) emp, salgrade 테이블을 사용해서 직원의 급여에  ◆수정◆
SELECT e.empno
     , e.ename
     , e.sal 
     , s.grade
  FROM emp e
     , salgrade s
 WHERE e.sal BETWEEN s.losal AND s.hisal 
;

-- emp 테이블에는 salgrade 테이블과ㅑ 동일비교해서 
-- 연결 할수 있는 값이 없음, 따라서 EQUI-JOIN 불가능 

--JOIN ON 으로 변경
SELECT e.empno
     , e.ename
     , e.sal 
     , s.grade
  FROM emp e JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal) 
;


/*
--OUTER JOIN 예를 만들기 위해 부서번호가 NULL 인 데이터 생성
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL) VALUES ('7777', 'JJ', 'CLERK', '7902', TO_DATE('2019-06-27 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '900')
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM) VALUES ('8888', 'J_JAMES', 'SALESMAN', '7698', TO_DATE('2019-06-07 13:10:34', 'YYYY-MM-DD HH24:MI:SS'), '1250', '200')
COMMIT;
*/ 

--6) OUTER JOIN : 조인 대상 테이블에서 공통 칼럼에 NULL값인 데이터도 
--                출력을 원할때 사용하는 조인 기법 

-- 연산자 : (+), LEFT OUTER JOIN, RIGHT OUTER JOIN 

---- 1.(+) 오라클에서만 사용하는 OUTER JOIN 연산자
--          EQUI-JOIN 조건에 NULL 값 출력을 원하는 쪽에 붙여서 사용 

--직원의 정보를 부서명과 함께 조회
SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno = d.deptno 
; 
--JJ, J_HAMES 의 e.deptno는 NULL이므로 dept 테이블에 일치하는 값이 없으므로 조인 결과로 
--조인 결과로 두 직원이 조회되지 않는다. 
--버서 배치가 되지 않는 직원도 모두 출력은 하고 싶다.
--그러려면 dept 테이블쪽의 데이터가 null 이어도 출력이 필요 
--추가 출력을 원하는 쪽에 (+) 연산자를 붙인다. 

/*
부서가 NULL 값이기에 7777,8888 부서가 없는 값은 나오지 않는다 
BUT 원하는 결과 : 7777 JJ (NULL) 나오도록 결과를 원함
*/

SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno = d.deptno(+) 
; 
/*
EMPNO,  ENAME,    DNAME
--------------------------
7782	CLARK	ACCOUNTING
7839	KING	ACCOUNTING
7934	MILLER	ACCOUNTING
7369	SMITH	RESEARCH
7566	JONES	RESEARCH
7902	FORD	RESEARCH
7499	ALLEN	SALES
7521	WARD	SALES
7654	MARTIN	SALES
7698	BLAKE	SALES
7844	TURNER	SALES
7900	JAMES	SALES
7777	JJ	
8888	J_JAMES	
*/
 
 -- LEFT OUTER JOIN, RIGHT OUTER JOIN  어떤 테이블 출력을 다 원하는가 
 -- (+) null 데이터를 원하는 테이블

-- (+) 연산자는 오른쪽에 붙이 이는 NULL 상태로 출력될 테이블을 결정 짓는다. 
-- 전체 데이터 기준 삼는 테이블이 왼쪽이기 때문에 
-- LEFT OUTER JOIN이 발생함

-- 2.LEFT OUTER JOIN ~ ON

SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e LEFT OUTER JOIN dept d on (e.deptno = d.deptno)
; 

--emp e 의 테이블은 모든 조건을 출력을 하게 된다. 
--ON 절에 쓰는 조인 조건은 EQUI-JOIN과 동일하지만 
--LEFT OUTER JOIN 연산자에 의해 
--이 연산자 왼쪽에 위치한 테이블의 모든 데이터는 출력을 보장 받는다. 
--결과는 (+) 연산자를 오른쪽에 붙인 결과와 동일 

--문제) 직원이 아직 아무도 배치되지 않은 부서가 있어도 모든 부서가 
--      출력되길 바란다면

--RIGHT OUTER JOIN을 이용하여 해결
SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e RIGHT OUTER JOIN dept d on (e.deptno = d.deptno)
; 

-- (+)연산자로 해결 : '=' 연산자를 오른쪽에 사용한다.
SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno(+) = d.deptno  
; 


--4. FULL OUTER JOIN
--문제) 부서배치가 안된 직원도 조회하고 싶도 
--      직원이 아무도 없는 부서도 조회하고 싶을때 
--      양쪽 NULL 존재 하는 값을 한거번에 조회 하려면
--      (+) 로는 不可能

--FULL OUTER JOIN ~ ON 연산자로 지원

SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e FULL OUTER JOIN dept d ON e.deptno = d.deptno  
;  
/*
7369	SMITH	    RESEARCH
7499	ALLEN	    SALES
7521	WARD	    SALES
7566	JONES	    RESEARCH
7654	MARTIN	    SALES
7698	BLAKE	    SALES
7782	CLARK	    ACCOUNTING
7839	KING	    ACCOUNTING
7844	TURNER	    SALES
7900	JAMES	    SALES
7902	FORD	    RESEARCH
7934	MILLER	    ACCOUNTING
7777	JJ	        (NULL)
8888	J_JAMES	    (NULL)
(NULL)  (NULL)      OPERATIONS
*/ 

--문제) 직원이 아무도 없는 부서를 모두 조회하고 싶다 
--      dept 테이블을 왼쪽에 배치해서 조인을 거는 경우
--      LEFT OUTER JOIN으로 해결하면 된다. 
SELECT d.dname 
     , e.ename
  FROM emp e
     , dept d 
 WHERE d.deptno = e.deptno(+)
;

--5.SELF JOIN 
--   :  한태이블 내에서 자기 자신의 컬럼끼리 연결하여 
--      논리적인 새 행을 만드는 기법  
--   하나의 테이블을 똑같은 2개로 나누어서 비교하여 판단하기 휘한 작업 

-- 문제) emp 테이블에 직원 정보를 조회할때 
--  그 직원의 상사(매니저)이름을 같이 조회하고 싶다.

SELECT e.empno  "사번"
     , e.ename  "이름"
     , e.mgr    "상사 사번"
     , e.ename  "상사 이름"
  FROM emp e
     , emp e1 
WHERE e.mgr = e1.empno
;
-- 위의 결과는 SELF-JOIN 이면서 EQUI-JOIN이기 때문에 
-- 상사가 없는 직원은 조회되지 않는다 
-- KING 은 조회되지 않음 

--상사가 없는 직원도 조회하고 싶으면 
--a) e테이블 기준으로 모든 데이터가 조회되어야 함 
--b) (+)기호를 오른쪽에 붙이거ㅏㄴ 
--c) LEFT OUTER JOIN ~ ON을 사용
SELECT e.empno  "사번"
     , e.ename  "이름"
     , e.mgr    "상사 사번"
     , e.ename  "상사 이름"
  FROM emp e LEFT OUTER JOIN emp e1 ON e.mgr = e1.empno 
;

-- ex) JJ e.mgr(7902) = 7902 e.name(FORD)    

--부하직원이 없는 직원들 조회 
--

SELECT e.empno  "사번"
     , e.ename  "이름"
     , e.mgr    "상사 사번"
     , e1.ename  "상사 이름"
  FROM emp e
     , emp e1 
 WHERE e.mgr(+) = e1.empno
 ORDER BY "사번" DESC
; 

/*
사번,     이름, 상사 사번, 상사 이름
------------------------------
                            MARTIN
                            MILLER
                            SMITH
                            JAMES
                			TURNER
                			WARD
                            JJ
                            J_JAMES
                            ALLEN
8888	J_JAMES	    7698	BLAKE
7934	MILLER	    7782	CLARK
7902	FORD	    7566	JONES
7900	JAMES	    7698	BLAKE
7844	TURNER	    7698	BLAKE
7782	CLARK	    7839	KING
7777	JJ	        7902	FORD
7698	BLAKE	    7839	KING
7654	MARTIN	    7698	BLAKE
7566	JONES	    7839	KING
7521	WARD	    7698	BLAKE
7499	ALLEN	    7698	BLAKE
7369	SMITH	    7902	FORD
*/


--RIGHT OUTER JOIN ~ ON  으로 변경
SELECT e.empno  "사번"
     , e.ename  "이름"
     , e.mgr    "상사 사번"
     , e1.ename  "상사 이름"
  FROM emp e RIGHT OUTER JOIN emp e1 ON (e.mgr = e1.empno)
 ORDER BY "사번" DESC 
; 


--수업중 실습 문제 
-- 1. 사번, 이름, 직무, 상사이름, 부서명, 부서위치를 조회하시오 
-- emp e, emp e1, dept d
-- 상사이름 같이 할려면 e,e1 조인 WHERE 
-- 부서이름,위치 같이 e,d 조인 AND

SELECT e.empno  사번
     , e.ename  이름
     , e.job    직무
     , e1.ename 상사이름
     , d.dname  부서명
     , d.loc    부서위치
  FROM emp e 
     , emp e1 
     , dept d 
 WHERE e.mgr = e1.empno 
   AND e.deptno = d.deptno 
 ORDER BY d.deptno
;


-- 2.사번, 이름, 급여, 급여등급, 부서명, 부서위치를 조회하시오 
-- emp e, dept d, salgrade s
-- 부서명 e,d AND 
-- 급여등급 e,s WHERE

SELECT e.empno  사번
     , e.ename  이름
     , e.sal    급여
     , s.grade  급여등급
     , d.dname  부서명
     , d.loc    부서위치
  FROM emp e  
     , dept d
     , salgrade s
 WHERE e.sal BETWEEN s.losal AND s.hisal
   AND e.deptno = d.deptno 
; 

--위의 구문을 JOIN ~ ON으로 변경 

SELECT e.empno  사번
     , e.ename  이름
     , e.sal    급여
     , s.grade  급여등급
     , d.dname  부서명
     , d.loc    부서위치
  FROM emp e JOIN  emp e1 ON (e.mgr = e1.empno)
             JOIN  dept d ON (e.deptno = d.deptno)
; 

SELECT e.empno  사번
     , e.ename  이름
     , e.sal    급여
     , s.grade  급여등급
     , d.dname  부서명
     , d.loc    부서위치
  FROM emp e JOIN  dept d     ON (e.deptno = d.deptno)
             JOIN  salgrade s ON (e.sal = d.deptno)
; 

-- 부서가 배정되지 않은 직원도 모두 출력하시오
-- (+) 연산자로 해결
 --사번, 이름, 급여, 급여등급, 부서명, 부서위치를 조회하시오 

SELECT e.empno  사번
     , e.ename  이름
     , e.sal    급여
     , d.dname  부서명
     , d.loc    부서위치
     , e.deptno 부서배정
  FROM emp e
     , dept d
 WHERE e.deptno  = d.deptno (+)
;

-- LEFT OUTER JOIN ~ ON 으로 해결

SELECT e.empno  "사번"
     , e.ename  "이름"
     , e.sal    "급여"
     , d.dname  "부서명"
     , d.loc    "부서위치"
     , e.deptno "부서배정"
  FROM emp e LEFT OUTER JOIN dept d ON (e.deptno = d.deptno )
;


-- 부서가 배정되지 않은 직원은 
-- 부서명, 부서위치 대신 '-' 이 출력되도록 하시오.

SELECT e.empno  "사번"
     , e.ename  "이름"
     , e.sal    "급여"
     , d.dname  "부서명"
     --, d.loc    "부서위치"
     --, e.deptno "부서배정"
     --, NVL2(e.deptno, e.deptno, 1) 부서배정 
     , NVL2(e.loc, e.loc, 1) 부서위치
  FROM emp e LEFT OUTER JOIN dept d ON (e.deptno = d.deptno )
;
