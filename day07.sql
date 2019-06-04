--07 day 
----(4) 데이터 타입변환 
/*
가장 기본적인 타입 
1.문자 : 반드시  ''(따옴표)감싸서 사용 
2.숫자 : 산술 연산이 되는 값
3.날짜 : 세기, 년도, 달, 일, 시, 분, 초
-------------- 
TO_CHAR() : 다른 타입에서 문자 타입으로 변환 해주는 함수 
숫가, 날짜 ==> 문자 

TO_DATE() : 다른 타입에서 날짜 타입으로 변환 해주는 함수 
            날짜 형식의 문자(날짜 패턴에 맞는 문자) => 날짜 
            
TO_NUMBER() : 다른 타입에서 숫자 타입으로 변환 해주는 함수 
              숫자로만 구성된 문자데이터 => 숫자
*/ 

--- 1 to_char() : 숫자패턴 적용 
SELECT to_char(12345, '9999') 
  FROM dual 
; 
--=>12345를 문자 취급 
--=>입력된 값보다 숫자가 더 커서 #으로 표시  
--=>문자는 앞 정렬로 된 결과로 되어있다.
-- 숫자가 문자화되어 출력되면 왼쪽 정렬로 바뀐다.

SELECT to_char(e.sal) "급여(문자화)" 
     , e.sal "급여(숫자)"
  FROM  emp e 
;

/*
급여(문자화), 급여(숫자)	
------------------------
800	     800
1600	1600
1250	1250
2975	2975
1250	1250
2850	2850
2450	2450
5000	5000
1500	1500
950	     950
3000	3000
1300	1300
*/

--숫자를 문자화 하되 총 8칸을 채우도록 한다.
SELECT to_char(12345, '99999999') "데이터" 
  FROM dual 
;
-0앞에 빈 공간을 0으로 체우기

SELECT to_char(12345,'099999999.99' as "데이터" 
 FROM dual 
;


숫자 패턴에서 3자리씩 끊어서 일기 + 소수점 표현 
SELECT to_char(12345, '9,999,999.99') 
  FROM dual 
 ; 
 
 ---(2) to_date ()  날짜 패턴에 맞는 문자 값을 날짜 연산이 가능한 날짜 타입으로 변경 
 SELECT to_date('2019 05-28','YYYY-MM-DD') "todaye(날짜)"
 '2019-05-28' "today 문자)"
   FROM  dual 
;


SELECT to_date('2019 05월-28','YYYY-MM-DD') + 10 "todaye(날짜)+10일"
  FROM  dual 
; 

--날짜 처럼 생긴 문자와는 날짜 연산이 안됨을 확인해 보자
SELECT '2019 05월-28' + 10 "todaye(날짜) + 10일"
  FROM dual 
;

/*
ORA-01722: 수치가 부적합합니다
01722. 00000 -  "invalid number"
*/ 


----3.to_number() : 오라클이 자동 형 변환을 해주므로 자주 사용되지 않음 

SELECT '1000' + 10 계산결과 
  FROM dual 
;

SELECT to_number('1000') + 10 계산결과 
  FROM dual 
;

--결과 : 1010

--to_char형식으로 캡쳐해서 보내기

-----------------------------------------------------------------------------------------
--오라클에서만 제공하는 함수--
----- (5)DECODE(expr,search , result[,search,result] ... [,default]) 
--만약 defauly 설정x , expr과 일치하는 search X 경우 결과는 NULL 

               --expr   search   result1
SELECT DECODE('YES'  , 'YES', '입력값이 YES입니다.'
                     , 'NO' , '입력값이 NO입니다.' ) AS 입력결과
               --      search2   result2
  FROM dual 
;
--결과 : 입력값이 YES입니다.

SELECT DECODE('NO'  , 'YES', '입력값이 YES입니다.'
                    , 'NO' , '입력값이 NO입니다.' ) AS 입력결과
  FROM dual 
;
--결과 : 입력값이 NO입니다.

SELECT DECODE('O'  , 'YES', '입력값이 YES입니다.'
                    , 'NO' , '입력값이 NO입니다.' ) AS 입력결과
  FROM dual 
;
--결과 : (null)

SELECT DECODE('O'  , 'YES', '입력값이 YES입니다.'
                   , 'NO' , '입력값이 NO입니다.' 
                          , '이게 default다'    ) AS 입력결과
                        
  FROM dual 
;
--결과 : 이게 default다

--emp 테이블에서 job(직무), 별로 경조사비 급여대비 일정 비율로 지급하기로 
--하였다, 지금비율이 다음과 같다고 할때. 각 지원들의 경조사비 지원금을 구해보자 
-- 사번 , 이름 , 직무를 구하라
-- CLEAK:   : 5% 
-- SALESMAN : 4% 
-- MANAGER  : 3.7%
-- ANALYST   : 3% 
-- PRESIDENT : 1.5% 

SELECT e.empno 
     , e.ename 
     , e.job 
     , DECODE(e.job  , 'CLEAK'     , e.sal * 0.05
                     , 'SALESMAN'  , e.sal * 0.04
                     , 'MANAGER'   , e.sal * 0.037
                     , 'ANALYST'   , e.sal * 0.03 
                     , 'PRESIDENT' , e.sal * 0.015 )  "경조사 지원금"                        
  FROM emp e
;
/*
EMPNO, ENAME,   JOB,      경조사 지원금 
--------------------------------------
9999	J_JAMES	CLERK	
8888	J%JAMES	CLERK	
7369	SMITH	CLERK	
7499	ALLEN	SALESMAN    	64
7521	WARD	SALESMAN	    50
7566	JONES	MANAGER	      110.075
7654	MARTIN	SALESMAN	    50
7698	BLAKE	MANAGER	       105.45
7782	CLARK	MANAGER	       90.65
7839	KING	PRESIDENT	    75
7844	TURNER	SALESMAN	    60
7900	JAMES	CLERK	
7902	FORD	ANALYST	        90
7934	MILLER	CLERK	
*/


--경조사 지원비 결과에 숫자 패턴 ($999.99) 입히기

SELECT e.empno 
     , e.ename 
     , e.job 
     , TO_CHAR(DECODE(e.job  , 'CLEAK'     , e.sal * 0.05
                             , 'SALESMAN'  , e.sal * 0.04
                             , 'MANAGER'   , e.sal * 0.037
                             , 'ANALYST'   , e.sal * 0.03 
                             , 'PRESIDENT' , e.sal * 0.015 ),'$999.99')  "경조사 지원금"                        
  FROM emp e
;










