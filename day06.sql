--day06 
----2)문자함수  
----------1.INITCAP(str) : str의 첫 글자를 대문자화(영문) 
SELECT INITCAP('the watch')   
  FROM dual 
;
--==>컬럼  : 그냥, 이름 : '' 필요

SELECT initcap('안녕')
  FROM dual 
;
------------------------------------------------------------------------------------------

------------2.LOWER(str) : str의 모든 글자를 소문자화(영문) 
SELECT lower('MR,SCOOT') 
  FROM dual 
; 
------------------------------------------------------------------------------------------
------------3.UPPER(str):  str의 모든 글자를 대문자화(영문)
SELECT UPPER('lee') 
  FROM dual 
;  


-- smith를 찾는데 입력이 소문자로 된 경우에 
-- SMITH와 다른 글자로 인식되므로 찾을수 없다. 
SELECT e.empno 
     , e.ename 
  FROM emp e 
 WHERE e.ename = 'SMITH' 
;

-- ename 과 비교하는 값이 대문자 이므로 정보가 조회됨
SELECT e.empno 
     , e.ename 
  FROM emp e 
 WHERE e.ename = upper('smith') 
;  

------------------------------------------------------------------------------------------
-----4.LENGTH(str), LENGTHB(str): 
--str의 글자 길이 , 글자의 byte 를 계산하여 숫자로 춝력 

SELECT length('hello, sql') as "글자 길이" 
  FROM dual 
; 

--==> 특수기호, 공백도 계산 (결과:10)

SELECT 'hello, 글자 길이는' || length('hello, sql') 
                          || '입니다' "글자 길이" 
  FROM dual 
;

--결과:hello, 글자 길이는10입니다

--oracle에서 한글을 3byte로 계한 
SELECT lengthb('hello, sql') "글자 byte" 
  FROM dual 
;
--결과:10

SELECT lengthb('오라클') "글자 byte" 
  FROM dual 
; 
--결과:9 

------------------------------------------------------------------------------------------
----- 5.CONCAT(str1,str2) : str과 str과를 문자열 접합 연산자와 동일한 결과 

SELECT concat('안녕하세요,','SQL!') 인사
  FROM dual
;

SELECT '안녕하세요,' || 'SQL!' 인사
  FROM dual
;    -- 오라클에서만 사용가능

/*
인사 
---------------
안녕하세요,SQL!
*/

------------------------------------------------------------------------------------------
-----6 SUBSTR(str, i, n): 
--      str 에서 i번째 위치에부터 n개의 글자를 추출  
--      SQL에서 문자열의 인덱스(순서)는 1부터 시작
--      str에서 i번째 위치에서 끝까지 글자를 추출
SELECT substr('SQL is cooooooooooooooo', 3, 4) "이름짧게만들기" 
  FROM dual
;
/*
이름짧게만들기 
-----------
L is
*/
SELECT substr('SQL is cooooooooooooooo', 3, 4) "이름짧게만들기" 
  FROM dual
;


--문제 :SQL만 추출
SELECT substr('SQL is cooooooooooooooo', 1, 3) "이름짧게만들기" 
  FROM dual
;
--문제 :is만 추출
SELECT substr('SQL is cooooooooooooooo', 5, 2) "이름짧게만들기" 
  FROM dual
;
--문제: !!만 추출
SELECT substr('SQL is cooooooooooooooo!!', 24) "이름짧게만들기" 
  FROM dual
; 
-- ==> 마지막 글자 다 포함한다면 뒷 숫자를 입력하지 않아도 된다.

--문제 : emp 테이블에서 직원의 이름을 앞 두글자 까지만 추출하여 
--       사번과 함께 조회하시오 
SELECT substr(e.ename,1,2) 
     , e.empno
  FROM emp e
;
--------------------------------------------------------------------------------- 
-----7.INSTR(str1,str2) : 두번째 문자열인 str2가 
--                        첫번째 문자열인 str1의 어디에 위치하는지 
--                         등장하는 위치를 계산하여 숫자로 출력                        

SELECT instr('SQL is cooooooooooooooo!!', 'is') "is 위치" 
  FROM dual
; 

SELECT instr('SQL is cooooooooooooooo!!', 'io') "is 위치" 
  FROM dual
;   -- 결과 : 0


-- ==> 두번째 문자열이 첫번째 문자열에 없으면 0을 출력한다.

-------------------------------------------------------------------
-------8.LPAD ,RPAD(str, n ,c) 입력된str대해서 전체 글자가 차지할 자릿수를 n으로 잡고
--                             전체 글자수 대비 왼쪽/오른쪽에 남는 자릿수에 
--                              c의 문자를 채워넣는다

-- ==> L% : left의미 ,  R% : Right의미
-- ==> n:숫자 , c : 글자 1개 , str:1개 이상 글 


SELECT lpad('SQL is cool!',20,'*')
  FROM dual 
; 
--결과 : ********SQL is cool!
-- 글자는 총 12개 인대  20값을 지정하였기에 나머지 8값을  왼쪽에 *을 대입을 한다.

SELECT rpad('SQL is cool!',20,'*')
  FROM dual 
; 
--결과 : SQL is cool!********

-------------------------------------------------------------------- 
-------9.LTRIM, RTRIM,TRIM :입력된 문자열의  L,R,양쪽 공백을 제거 
SELECT '■' || '     sql is cool     ' || '■'
  FROM dual 
;
--결과 : ■     sql is cool     ■

SELECT '■' || ltrim('     sql is cool     ') || '■'
  FROM dual 
;
--결과 : ■sql is cool     ■

SELECT '■' || rtrim('     sql is cool     ') || '■'
  FROM dual 
;
--결과 : ■     sql is cool<

SELECT '■' || trim('     sql is cool     ') || '■'
  FROM dual 
;
--결과 : ■sql is cool■ 



SELECT e.empno 
     , e.ename 
  FROM emp e 
 WHERE e.ename =trim(' SMITH  ') 
;
 -- 'SMITH' 값에  trim 함수를 적용하여 조회성공 
 
 
--문제 : 비교값이 '     smith  ' 일때 SMITH의 정보를 조회하시오 
SELECT e.empno 
     , e.ename 
  FROM emp e 
 WHERE e.ename = upper(trim(' smith  ')) 
 ;
 
 ---------------------------------------------------------------------------
 ------10.NVL(expr1, expr2) 
 --       NVL2(expr1, expr2, expr3_ 
 --       NVLLI(expr1,expr2)
 
 
 --NVL(expr1, expr2) :첫번째 식의 값이 NULL이면 두번째 식으로 대체하여 출력 
 --매니저(mgr)가 배정되지 않은 직원의 경우 0으로 출력

SELECT e.empno 
     , e.ename
     , nvl(e.mgr, 0)
FROM emp e
;

/*
EMPNO, ENAME, NVL(E.MGR,0) 
---------------------------
9999	J_JAMES	0
8888	J%JAMES	0
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	0
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/
 
 
 --매니저(mgr)dl 배정되지 않은 직원은 '매지저 없음'라고 출력
SELECT e.empno 
     , e.ename
     , nvl(e.mgr, '매니저 없음')
 FROM emp e
;

/*
ORA-01722: 수치가 부적합합니다
01722. 00000 -  "invalid number"

==> nvl처리 대상 컬림인 e.mgr은 숫자타임의 데이터 인데 
    null 값을 대체할때 '매니저 없음'은 문자타입의 데이터 이므로 
    변환시 mgr컬럼의 타입과불일치 하기 때문에 
    실행시 구문 오류가 발생
*/
 
SELECT e.empno 
     , e.ename
     , nvl(e.mgr || '','매니저 없음')
 FROM emp e
;
 
/*
EMPNO, ENAME, NVL(E.MGR||'','매니저없음') 
--------------------------------------------
9999	J_JAMES	매니저 없음
8888	J%JAMES	매니저 없음
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	매니저 없음
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/
 
-- ==> || 결합연산자로 mgr에 빈문자를 붙여서 문자타입으로 변경 
 
--문제 : || 연산자 대신 concar()함수를 사용하여 같은 결과를 내시오  
 
SELECT e.empno 
     , e.ename
     --, nvl(e.mgr,'매니저 없음')
     , nvl(concat(e.mgr,''),'매니저 없음')
 FROM emp e
; 
--==> '' 오라클에서는 null값으로 인식

 
--NVL2(expr1, expr2, expr3) 
--     첫번째 식의 값이 NOT NULL이면 두번째 식의 값으로 출력 
--                         NULL이면 세번째 식의 값으로 출력 
  
--mgr가 배정된 경우레는 '매니저 있음'으로 
--매니저가 배정되지 않은 경우에는 '매니저 없음'으로 출력


SELECT e.empno 
     , e.ename
     , nvl2(e.mgr, '매니저 있음','매니저 없음') "유/무"
 FROM emp e
;
/*
EMPNO, ENAME, 유/무
---------------------------
9999	J_JAMES	매니저 없음
8888	J%JAMES	매니저 없음
7369	SMITH	매니저 있음
7499	ALLEN	매니저 있음
7521	WARD	매니저 있음
7566	JONES	매니저 있음
7654	MARTIN	매니저 있음
7698	BLAKE	매니저 있음
7782	CLARK	매니저 있음
7839	KING	매니저 없음
7844	TURNER	매니저 있음
7900	JAMES	매니저 있음
7902	FORD	매니저 있음
7934	MILLER	매니저 있음
*/
-- ==>str2, str3 형식(숫자, 문자)이 형식이 같아야 한다.



--오라클에서 빈문자열('')을 NULL로 취급하는 것을 
-- 확인하기 위한 구문 
SELECT NVl2('','IS NOT NULL','IS NULL') 
  FROM dual 
;
--결과 : IS NULL

SELECT nvl2(' ','IS NOT NULL','IS NULL') 
  FROM dual 
; 
--결과 : IS NOT NULL
 
 
 --NULLIF(EXPR1,EXPR2) : 
 --첫번째 식, 두번째 식의 값이 동일하면 NULL을 출력 
 --두 값이 다르면 첫번째 식의 값을 출력 
 
 SELECT NULLIF('AAA','BBB')  
   FROM dual
;
-- 결과 : AAA 


 SELECT NULLIF('AAA','AAA')  
   FROM dual
;
-- 결과 : (null)  ,  (null)값도 1행이 존재한다 (인출된 모든 행:0) 과 다르다

----------------------------------------------------------------------------------------

------3) 날짜 함수 : 날짜와 관련된 출력/날짜의 더하기 빼기 등의 연산을 할수있는 기능 제공

--현재의 시스템 시간을 얻는 sysdata함수 
SELECT sysdate 
  FROM dual 
;
-- 결과 : 19/05/24 (yy/mm/dd)

--TO_CHAR(arg) : arg는 숫자나 날짜 타입의 데어터가 될수있다.
--               입력된 arg를 문자타입으로 변경해주는 함수 
--               to 보내다 , arg를  char문자로 바꾸어라
SELECT to_char(sysdate, 'YYYY') "년도" 
  FROM dual 
;
--결과 : 2019

SELECT to_char(sysdate, 'YY') "년도" 
  FROM dual 
;
--결과 :19

SELECT to_char(sysdate, 'MM') "월" 
  FROM dual 
;
--결과 :05

SELECT to_char(sysdate, 'MON') "월" 
  FROM dual 
;
--결과 :5월 

SELECT to_char(sysdate, 'DD') "일" 
  FROM dual 
; 
--결과 :5월 

SELECT to_char(sysdate, 'D') "일" 
  FROM dual 
; 
--결과 : 6 -- 금요일 의미 


SELECT to_char(sysdate, 'Day') "일" 
  FROM dual 
; 
--결과 : 금요일


SELECT to_char(sysdate, 'Dy') "일" 
  FROM dual 
; 
--결과 : 금


SELECT to_char(sysdate, 'YYYY-MM-DD') "오늘날짜" 
  FROM dual 
; 
--결과 : 2019-05-24


SELECT to_char(sysdate, 'FMYYYY-MM-DD') "오늘날짜" 
  FROM dual 
; 
--결과 : 2019-5-24 
--=>fm 유효하지 않은 날짜 제거

SELECT to_char(sysdate, 'YYYY-MON-DD DAY') "오늘날짜" 
  FROM dual 
; 
--결과 : 2019-5월 -24 금요일



/*
시간패턴: 
HH:시간을 2자리 표시
HI:분을 두자리로 표시 
SS:초를 두자리소 표시
HH24:시간을 24시간으로 표기 
AM:오전인지 오후 인지 표기
*/ 
SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') "오늘날짜 시분초" 
  FROM dual 
;
--결과 : 2019-05-24 15:32:45
-- ==> 24까지 표기됨  

SELECT to_char(sysdate, 'YYYY-MM-DD AM HH:MI:SS') "오늘날짜 시분초" 
  FROM dual 
;
--결과 : 2019-05-24 오후 03:43:02
-- ==> AM 오전/오후 구별굄 


SELECT sysdate + 10  "10일후"
    ,  sysdate - 10  "10일전"
    ,  sysdate + 10/24 "10시간뒤"
  FROM dual 
;
--결과 : 19/06/03	19/05/14	19/05/25

SELECT to_char(sysdate +10/24,'YYYY-MM-DD AM HH:MI:SS') "10시간뒤"
  FROM dual 
;
--결과 : 2019-05-25 오전 01:49:18


-----------------1.MONTHS_BETWEEN(날짜1, 날짜2)  
-------            두 날짜 사이의 달의 차이
SELECT e.empno 
     , e.ename
     , MONTHS_BETWEEN(sysdate, e.hiredate) "근속 개월 수" 
FROM emp e 
;

-- 각 직원의 근속 개월수를 구하되 소수점 1의 자리까지만 구하기 

SELECT e.empno 
     , e.ename
     , ROUND((MONTHS_BETWEEN(sysdate, e.hiredate)),2) "근속 개월 수"
  FROM emp e 
;

-----------------------------------------------------------------------------
---------------2.ADD_MONTHS(날짜, 숫자) : 
--                날짜에 숫ㅅ자를 더한 만큼 휘의 날짜를 구함 
SELECT add_months(sysdate, 3)
  FROM dual 
;
--결과 : 19/08/24

-- 날짜 + 숫자 : 숫자 만큼의 날 수를 더하여 날짜를 구함 
-- 날짜 + 숫자/24 : 숫자 만큼의 시간을 더하여 날짜를 구함
-- ADD_MONTHS(날짜,숫자) 숫자 만큼의 달을 더하여 날짜를 구함

---------------------------------------------------------------------------------- 
-----------3.NEXT_DAY, LAST_DAY 
-- 다음 요일에 해당하는 날짜를 구함 
-- 이달의 마지막 날짜를 구함

--현재 날짜에서 돌아오는 수(4)요일의 날짜를 구함
SELECT next_day(sysdate,4) "돌아오는 수요일"
     , next_day(sysdate,'수요일') "돌아오는 수요일2" 
     , last_day(sysdate) "이달의 마지막 날"
  FROM dual 
;
/*
돌아오는 수요일, 돌아오는 수요일2, 이달의 마지막 날 
------------------------------------
19/05/29	19/05/29	19/05/31
*/
-- ==> DAY개념은 요일이다

---------------------------------------------------------------------------------- 
-----------4.ROUND, TRUNC :날짜에 대한 반올림, 버림 연산 
SELECT round(sysdate) "현재 시간에서 반올림" 
  FROM dual 
; 

--문제 : 현재 시간에서 반올림 된 날자를 시/분/초 까지 출력 
SELECT to_char(round(sysdate),'DD HH:MI:SS') "현재 시간에서 반올림" 
  FROM dual 
; 
-- 결과 : 하루뒤 00시 결과

SELECT to_char(trunc(sysdate),'DD HH:MI:SS') "현재 시간에서 반올림" 
  FROM dual 
; 
-- 결과 : 오늘 00시 결과


