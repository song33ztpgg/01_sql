--07 day 
----(4) ������ Ÿ�Ժ�ȯ 
/*
���� �⺻���� Ÿ�� 
1.���� : �ݵ��  ''(����ǥ)���μ� ��� 
2.���� : ��� ������ �Ǵ� ��
3.��¥ : ����, �⵵, ��, ��, ��, ��, ��
-------------- 
TO_CHAR() : �ٸ� Ÿ�Կ��� ���� Ÿ������ ��ȯ ���ִ� �Լ� 
����, ��¥ ==> ���� 

TO_DATE() : �ٸ� Ÿ�Կ��� ��¥ Ÿ������ ��ȯ ���ִ� �Լ� 
            ��¥ ������ ����(��¥ ���Ͽ� �´� ����) => ��¥ 
            
TO_NUMBER() : �ٸ� Ÿ�Կ��� ���� Ÿ������ ��ȯ ���ִ� �Լ� 
              ���ڷθ� ������ ���ڵ����� => ����
*/ 

--- 1 to_char() : �������� ���� 
SELECT to_char(12345, '9999') 
  FROM dual 
; 
--=>12345�� ���� ��� 
--=>�Էµ� ������ ���ڰ� �� Ŀ�� #���� ǥ��  
--=>���ڴ� �� ���ķ� �� ����� �Ǿ��ִ�.
-- ���ڰ� ����ȭ�Ǿ� ��µǸ� ���� ���ķ� �ٲ��.

SELECT to_char(e.sal) "�޿�(����ȭ)" 
     , e.sal "�޿�(����)"
  FROM  emp e 
;

/*
�޿�(����ȭ), �޿�(����)	
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

--���ڸ� ����ȭ �ϵ� �� 8ĭ�� ä�쵵�� �Ѵ�.
SELECT to_char(12345, '99999999') "������" 
  FROM dual 
;
-0�տ� �� ������ 0���� ü���

SELECT to_char(12345,'099999999.99' as "������" 
 FROM dual 
;


���� ���Ͽ��� 3�ڸ��� ��� �ϱ� + �Ҽ��� ǥ�� 
SELECT to_char(12345, '9,999,999.99') 
  FROM dual 
 ; 
 
 ---(2) to_date ()  ��¥ ���Ͽ� �´� ���� ���� ��¥ ������ ������ ��¥ Ÿ������ ���� 
 SELECT to_date('2019 05-28','YYYY-MM-DD') "todaye(��¥)"
 '2019-05-28' "today ����)"
   FROM  dual 
;


SELECT to_date('2019 05��-28','YYYY-MM-DD') + 10 "todaye(��¥)+10��"
  FROM  dual 
; 

--��¥ ó�� ���� ���ڿʹ� ��¥ ������ �ȵ��� Ȯ���� ����
SELECT '2019 05��-28' + 10 "todaye(��¥) + 10��"
  FROM dual 
;

/*
ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid number"
*/ 


----3.to_number() : ����Ŭ�� �ڵ� �� ��ȯ�� ���ֹǷ� ���� ������ ���� 

SELECT '1000' + 10 ����� 
  FROM dual 
;

SELECT to_number('1000') + 10 ����� 
  FROM dual 
;

--��� : 1010

--to_char�������� ĸ���ؼ� ������

-----------------------------------------------------------------------------------------
--����Ŭ������ �����ϴ� �Լ�--
----- (5)DECODE(expr,search , result[,search,result] ... [,default]) 
--���� defauly ����x , expr�� ��ġ�ϴ� search X ��� ����� NULL 

               --expr   search   result1
SELECT DECODE('YES'  , 'YES', '�Է°��� YES�Դϴ�.'
                     , 'NO' , '�Է°��� NO�Դϴ�.' ) AS �Է°��
               --      search2   result2
  FROM dual 
;
--��� : �Է°��� YES�Դϴ�.

SELECT DECODE('NO'  , 'YES', '�Է°��� YES�Դϴ�.'
                    , 'NO' , '�Է°��� NO�Դϴ�.' ) AS �Է°��
  FROM dual 
;
--��� : �Է°��� NO�Դϴ�.

SELECT DECODE('O'  , 'YES', '�Է°��� YES�Դϴ�.'
                    , 'NO' , '�Է°��� NO�Դϴ�.' ) AS �Է°��
  FROM dual 
;
--��� : (null)

SELECT DECODE('O'  , 'YES', '�Է°��� YES�Դϴ�.'
                   , 'NO' , '�Է°��� NO�Դϴ�.' 
                          , '�̰� default��'    ) AS �Է°��
                        
  FROM dual 
;
--��� : �̰� default��

--emp ���̺��� job(����), ���� ������� �޿���� ���� ������ �����ϱ�� 
--�Ͽ���, ���ݺ����� ������ ���ٰ� �Ҷ�. �� �������� ������� �������� ���غ��� 
-- ��� , �̸� , ������ ���϶�
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
                     , 'PRESIDENT' , e.sal * 0.015 )  "������ ������"                        
  FROM emp e
;
/*
EMPNO, ENAME,   JOB,      ������ ������ 
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


--������ ������ ����� ���� ���� ($999.99) ������

SELECT e.empno 
     , e.ename 
     , e.job 
     , TO_CHAR(DECODE(e.job  , 'CLEAK'     , e.sal * 0.05
                             , 'SALESMAN'  , e.sal * 0.04
                             , 'MANAGER'   , e.sal * 0.037
                             , 'ANALYST'   , e.sal * 0.03 
                             , 'PRESIDENT' , e.sal * 0.015 ),'$999.99')  "������ ������"                        
  FROM emp e
;










