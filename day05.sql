-- day05 
-- (6) ������ 7.������ �켱���� 
-- 1.��ȣ 2.�񱳿����� 3.NOT 4.AND 5.OR 

/*
�־��� ���� 3�� 
1.mgr = 7698 
2.job = 'CLERK' 
3.sal > 1300

�������� ���� ������ ���� ����� ��� �޶������� Ȯ���غ��� 
*/ 
 
--1) �Ŵ����� ����� 7698�̸� , ������ 'CLERAK'�̰ų�   
--   �޿��� 1300�� �Ѵ� ������ �����ϴ� ������ ������ ��ȸ 
--   ���, �̸�, ����,�޿� �Ŵ��� ��� 

SELECT e.empno 
     , e.ename
     , e.job 
     , e.sal 
     , e.mgr
  FROM emp e
 WHERE e.mgr =7698 
   AND e.job ='CLERK' 
    OR e.sal > 1300 
;
/*
EMPNO, ENAME,       JOB,     SAL,    MGR 
-----------------------------------------
7499	ALLEN	SALESMAN	1600	7698
7566	JONES	MANAGER	    2975	7839
7698	BLAKE	MANAGER	    2850	7839
7782	CLARK	MANAGER	    2450	7839
7839	KING	PRESIDENT	5000	
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	    950 	7698
7902	FORD	ANALYST	    3000	7566
*/
--  ��=> CLEARK + 7698 ��� 1�� 
-- 1300 > sal  ��� 7�� 

---------------------------------------------------------------------------------

--2) �Ŵ����� 7698�� �����߿���  
--  ������ 'CLEARK' �̰ų� �޿��� 1300�� �Ѵ� ���� ���� ��ȸ

SELECT e.empno 
     , e.ename
     , e.job 
     , e.sal 
     , e.mgr
  FROM emp e
 WHERE e.mgr =7698 
   AND (e.job ='CLERK' OR e.sal >1300)
;
/*
EMPNO, ENAME,    JOB,       SAL,    MGR 
----------------------------------------
7499	ALLEN	SALESMAN	1600	7698
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	    950 	7698
*/

---------------------------------------------------------------------------------



--3) ������ CLERK �̰ų� �޿��� 1300 �����鼭 
--    �Ŵ����� 7698�� ���� ���� ��ȸ 

SELECT e.empno 
     , e.ename 
     , e.job 
     , e.sal 
     , e.mgr 
  FROM emp e 
 WHERE e.job ='CLERK' 
    OR e.sal> 1300
   AND e.mgr = 7698 
;

/*
EMPNO, ENAME,   JOB,        SAL,    MGR 
----------------------------------------
9999	J_JAMES	CLERK		
8888	J%JAMES	CLERK		
7369	SMITH	CLERK	    800	    7902
7499	ALLEN	SALESMAN	1600	7698
7844	TURNER	SALESMAN	1500	7698
7900	JAMES	CLERK	    950	    7698
7934	MILLER	CLERK	    1300	7782
*/

-- ��=> AND �����ڴ� OR�����ں��� �켱������ ���� ������  
--    �ι�° ����ó�� ��ȣ�� ������� �ʾư� �������� �����ϰ� ���´�.

---------------------------------------------------------------------------------
---------------------------------6. �Լ�-----------------------------------------
---------------------------------------------------------------------------------

--(3) ������ �Լ�  
------1) �����Լ�: 
----------1.MOD(m,n) : m��n���� ���� ������ ��� �Լ�  
SELECT mod(10,3) 
  FROM emp 
; 

-- ��� 1�� emp���̺��� �� �� ��ŭ �ݺ� ��� 

SELECT mod(10,3) 
  FROM dept 
;
-- ������� ���� �ʾƼ� mod�� �빮�ڷ� �x��

--���� :�� ����� �޿��� 3���� ���� �������� ��ȸ 
SELECT mod(e.sal,3)
  FROM emp e 
; 

/*
MOD(E.SAL,3)
-------------
2
1
2
2
2
0
2
2
0
2
0
1
*/ 

--���� emp ���̺����� �� ����� �޿��� 4���� ���� �������� ����� �Բ� ��ȸ�Ͻÿ� 
SELECT  e.empno 
     , mod(e.sal,3)
  FROM emp e 
; 
--=> ������ �Լ��� ���̺��� 1��� 1���� ���� 

--------2.ROUND(m,n) : �Ǽ� m�� �Ҽ��� n + 1 �ڸ����� �ݿø� �� ��� ��� 
SELECT ROUND(1234.56,1) 
  FROM dual
;
--=>�� ���ڸ� �ø�
--1-1
SELECT ROUND(1234.56,0) 
  FROM dual
;
--1-2
SELECT ROUND(1234.56,0) 
  FROM dual
;
/*1235*/

--2-1
SELECT ROUND(1234.46,0) 
  FROM dual
;
/*1234*/
--ROUND(m) : n���� �����ϸ� n=0�ΰ����� ������ ����� ������




--------3.TRUNC(m,n) : �Ǽ� m�� n���� ������ �ڸ� ���� �Ҽ����� ���� 
SELECT TRUNC(1234.46,1) 
  FROM dual
;
/*1234.5*/
SELECT TRUNC(1234.46,0) 
  FROM dual
;
/*1234*/
--TRUNC(m): n�� ������ ��쿡�� n=0���� �����Ѵ�. �� �Ҽ��� ���� ��� ���� ����  
SELECT TRUNC(1234.46) 
  FROM dual
;

--------4.CEIL(n):�Էµ� �Ǽ� n���� ���ų� ���� ū ���� 
SELECT CEIL(1234.56) --1234 or 1235
FROM dual 
; 
/*1235*/
SELECT CEIL(1234.001) 
FROM dual 
; 
/*1235*/

-------5.FLOOR(n) :�Էµ� �Ǽ�n���� ���ų� ���� ����� ���� ���� 

SELECT FLOOR(1234.56) 
FROM dual 
; 
--1234
SELECT FLOOR(1234.001) 
FROM dual 
; 
--1234
SELECT FLOOR(1234.001) 
FROM dual 
; 
/*1235*/

------6.WIDTH_BYCKET(expr.min,nax,byckets) 
-- min ~ max �� ���̸� buckets������ŭ ���� ������ 
-- expr�� ����ϴ� ���� ��� buckets�� ��ġ�ϴ��� ���ڷ� �˷��� 

--�޿��� ������ 0~5000���� ��� , ��bucket�� 1000������ ������ 
--�� 5���� buket�� ������ �˼� �����Ƿ� 
--�� ������ �޿��� ��� bucket�� ��ġ�ϴ��� ���غ���

SELECT e.empno 
     , e.ename 
     , e.sal 
     , WIDTH_BUCKET(e.sal, 0, 5000, 5) as "�޿�����" 
  FROM emp e 
 ORDER BY "�޿�����"
;
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
 