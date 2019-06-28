--day11
-----7.���ΰ� �������� 
--(2) �������� : Sub-Query
--��ɹ� ������ ������ �� ��� 

-- SELECT , FROM , WHERE ���� ���� �� �ִ�. 

--����) BLAKE�� ����(job)�� ������ ������ ������ ��ȸ
--1.balck �� ������ ��ȸ(��������)
SELECT e.job 
  FROM emp e 
 WHERE e.ename ='BLAKE' 
; 
/*
MANAGER
*/ 

--2.1�� ����� ����(��������) 
-- => ����(job)�� MANAGER�� ����� ��ȸ�Ͽ��� 

SELECT e.empno   
     , e.ename
  FROM emp e 
 WHERE e.job ='MANAGER' 
; 


--MANAGER �� �ڸ��� 1�� ������ ������ ����
SELECT e.empno   
     , e.ename
  FROM emp e 
 WHERE e.job =(SELECT e.job 
                 FROM emp e 
                WHERE e.ename ='BLAKE' ) -- �̰��� ��������
; 
-- ���������� WHERE�� ()��ȣ �ȿ� ���޵Ǵ� ���� 
-- 1�� ������ ����� MANAGER��� ���̴�.

/*
SELECT e.empno ��____  
     , e.ename ��   
  FROM emp e 
 WHERE e.job(��������) = (SELECT e.job(��������) 
                           FROM emp e 
                          WHERE e.ename ='BLAKE' ) -- �̰��� ��������
*/
------------------------------------------------------------------------------------------
/*
--�������� ������ �ǽ� 
--1.�� ȸ���� ��� �޿����� �޿��� ���� �޴� ������ ��� ��ȸ�Ͽ��� 
-- ���, �̸�, �޿��� ��ȸ 
--Ǫ�� ���� 

--a ȸ���� �޿� ��հ��� ���ϴ� ���� 
SELECT TO_CHAR((AVG(e.sal)),'9999.9')
  FROM emp e 
;

--b �� ��� ���� ���� �����Ͽ� �� ������ �޿��� ���� ������ ���ϴ� ����
SELECT e.ename
  FROM emp e 
 WHERE e.sal > 1933.9 
;


--c b�� �������� ��հ� �ڸ��� a ������ ��ü  
SELECT e.ename
  FROM emp e 
 WHERE e.sal > (SELECT TO_CHAR((AVG(e.sal)),'9999.9')
                  FROM emp e )
;


--2.�޿��� ��� �޿����� ũ�鼭 ����� 7700 ���� ���� ������ ��ȸ�Ͻÿ�
-- ���, �̸�, �޿��� ��ȸ  
-- �׷��Լ�, max 
SELECT e.empno 
     , e.ename 
     , e.sal
  FROM emp e 
 WHERE e.sal > (SELECT TO_CHAR((AVG(e.sal)),'9999.9')
                  FROM emp e ) 
   AND e.empno > 7700
;

--3.�� �������� �ִ� �޿��� �޴� ���� ����� ��ȸ�Ͽ���. 
-- ���, �̸�, ,����, �޿��� ��ȸ 

--a ���� ���� �ִ� �޿��� ���ϴ� ����: �׷��Լ�(MAX),�׷�ȭ �����÷�(job) 

SELECT e.job
     , MAX(e.sal)
  FROM emp e 
 GROUP BY e.job
;

--b a���� ������ �ִ� �޿��� job�� ��ġ�ϴ��� �����ϴ� ���� 

--c b���� ���� ���� a�� ������ ��ü

--4.�� ���� �Ի��ο��� ���η� ����Ͻÿ� 
SELECT 
    --e.hiredate 
    --, COUNT() 
    -- , COUNT(DECODE(TO_CHAR( SUBSTR(e.hiredate , 4, 2) )  
      COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '01' , 1)) "1��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '02' , 1)) "2��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '03' , 1)) "3��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '04' , 1)) "4��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '05' , 1)) "5��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '06' , 1)) "6��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '07' , 1)) "7��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '08' , 1)) "8��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '09' , 1)) "9��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '10' , 1)) "10��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '11' , 1)) "11��"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '12' , 1)) "12��"
  FROM emp e 
--ORDER BY e.hiredate
;

/*  ex)
   �Ի��, �ο�(��)
   --------------
    1��     3
    2��     2 
     ��      �� 
    12��    5

������ Ǯ���� ����


*/
------------------------------------------------------------------------------------------
--�������� ������ �ǽ� 
--1.�� ȸ���� ��� �޿����� �޿��� ���� �޴� ������ ��� ��ȸ�Ͽ��� 
-- ���, �̸�, �޿��� ��ȸ 
--Ǫ�� ���� 

--a ȸ���� �޿� ��հ��� ���ϴ� ���� 
SELECT TO_CHAR((AVG(e.sal)),'9999.9')
  FROM emp e 
;

--b �� ��� ���� ���� �����Ͽ� �� ������ �޿��� ���� ������ ���ϴ� ����
SELECT e.ename
  FROM emp e 
 WHERE e.sal > 1933.9 
;


--c b�� �������� ��հ� �ڸ��� a ������ ��ü  
SELECT e.ename
  FROM emp e 
 WHERE e.sal > (SELECT TO_CHAR((AVG(e.sal)),'9999.9')
                  FROM emp e )
;


--2.�޿��� ��� �޿����� ũ�鼭 ����� 7700 ���� ���� ������ ��ȸ�Ͻÿ�
-- ���, �̸�, �޿��� ��ȸ  
-- �׷��Լ�, max 
SELECT e.empno 
     , e.ename 
     , e.sal
  FROM emp e 
 WHERE e.sal > (SELECT TO_CHAR((AVG(e.sal)),'9999.9')
                  FROM emp e ) 
   AND e.empno > 7700
;

--3.�� �������� �ִ� �޿��� �޴� ���� ����� ��ȸ�Ͽ���. 
-- ���, �̸�, ,����, �޿��� ��ȸ 

--a ���� ���� �ִ� �޿��� ���ϴ� ����: �׷��Լ�(MAX),�׷�ȭ �����÷�(job) 

SELECT e.job
     , MAX(e.sal)
  FROM emp e 
 GROUP BY e.job
;

--b a���� ������ �ִ� �޿��� job�� ��ġ�ϴ��� �����ϴ� ���� 
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

--c b���� ���� ���� a�� ������ ��ü

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
/* ORA-00913: ���� ���� �ʹ� �����ϴ�  
����: ���������� e.sal - 1�� , ����������[e.sal, MAX(e.sal)]-�� 2��) 
     ���ϴ� ���� �÷��� ������ ���� �ʾ� ����� ������ ����*/

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




--4.�� ���� �Ի��ο��� ���η� ����Ͻÿ� 
SELECT TO_CHAR(e.hiredate, 'FMMM') "�Ի��" 
  FROM emp e
;

-- �Ի� ���� ���ڰ����� �����ؾ� ������ �½��ϴ�.
SELECT TO_CHAR(e.hiredate, 'FMMM') "�Ի��" 
     , COUNT(*) "�ο���" 
  FROM emp e
 GROUP BY  TO_CHAR(e.hiredate, 'FMMM') 
 ORDER BY "�Ի��" 
; 

-- ���� ����� FROM ���� ������ ���� '��'�� �ٿ��� �� 
SELECT a.month || '��' "�Ի��" 
     , a.cnt "�ο�(��)"
  FROM (SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) month 
             , COUNT(*) cnt 
          FROM emp e
         GROUP BY  TO_CHAR(e.hiredate, 'FMMM') 
         ORDER BY month) a
; 
/*
SELECT a.month || '��' "�Ի��" 
     , a.cnt "�ο�(��)"
  FROM (SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) month 
             , COUNT(*) cnt 
          FROM emp e
         GROUP BY  TO_CHAR(e.hiredate, 'FMMM') 
         ORDER BY month) a
*/



------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------