-- day04 : �ǽ� 4���� 

--(6) ������ 2.�񱳿�����
--    �� �����ڴ�SELECT ���� ����Ҽ� ���� 
--    WTERE, HAVING ������ ����Ҽ� ����. 


-- 22) �޿��� 2000�� �Ѵ� ������ ��� ,�̸� ,�޿��� ��ȸ 

SELECT e.empno ���
    ,  e.ename �̸�
    ,  e.sal �޿�
  FROM emp e 
 WHERE e.sal > 2000
; 
/*
���,    �̸�,   �޿� 
---------------------
7566	JONES	2975
7698	BLAKE	2850
7782	CLARK	2450
7839	KING	5000
7902	FORD	3000
*/

-- �޿��� 1000 �̻��� ������ ���,�̸� ,�޿��� ��ȸ 

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

--�޿��� 1000�̻��̸� 2000���� ����  
--������ �̸� �޿� ��� ��ȸ 

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

-- comm(����) ���� 0 ���� ū ������ ���, �̸� , �޿�, ���� ��ȸ
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
==> ���� comm > 0 ������ ���� ������� �˼��ִ°� 
comm �÷��� ���� (null)�� ������� ���� ó������ �� ��� ���� ������ �����ؾ� �Ѵ�. 
(null) ���� �񱳿�����, ��� �����ڷ� ���� �Ҽ� ���� ���̴�. 

�� ���Ŀ����� null���� ���� ū ������ ����Ѵ�.

*/

-------------------------------------------------------------------------------------------- 

--23) null ������ ���� ���� 
--    SALESMAN(���� ���) ������ ���� ����� ���� ���ɱ��� ����Ͽ� 
--    ���, �Ƹ�, ����, �� ���ɱ��� ��ȸ

SELECT e.empno 
     , e.ename  
     , e.job  
     , e.sal
     , e.comm
     , e.sal +e.comm "�� ���ɱ�" 
  FROM emp e 
 WHERE e.job ='SALESMAN'
;

-- ==> NULL �����ʹ� ��� �����ڷ� ���� �Ұ��� �� ��

/*
EMPNO,  ENAME,  JOB,        SAL,    COMM, �� ���ɱ� 
----------------------------------------------------
7499	ALLEN	SALESMAN	1600	300	    1900
7521	WARD	SALESMAN	1250	500	    1750
7654	MARTIN	SALESMAN	1250	1400	2650
7844	TURNER	SALESMAN	1500	0	    1500
*/

-------------------------------------------------------------------------------------------- 

--(6) ������ 3. �� ������ 

--24) �޿��� 2000���� ���� ���� ������ 
--    ���, �̸�, �޿��� ��ȸ 

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

--(6) ������ 4..SQL ������ 
-- IN ������ : ���ϰ��� �ϴ� ���� ���� ���õ� ��Ͽ� �����ϸ� ������ �Ǵ�

--25)�޿��� 800 , 300, 5000 �߿� �ϳ��� ������ ��� �̸� �޿��� ��ȸ 

SELECT e.empno
     , e.ename
     , e,sal
  FROM emp e 
 WHERE e.sal IN (800,3000,5000)
; 

--OR �����ڿ� 3���� �������� ������ ����� ���� ����

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

--LIKE ������ : ���簪�� �˻��Ҷ� ���
--              ��Ȯ�� ���� ���� ���Ҷ� ���
--LIKE �������� ���� ���� : ���� �� �˻��� ���� �����ڿ� �Բ� ����ϴ� ��ȣ
-- % : �� ��ȣ�� �ڸ��� 0�ڸ��� �̻��� ��� ���ڰ� �� �� ���� 
-- _ : �� ��ȣ�� �ڸ��� 1�ڸ��� ��� ���ڰ� �� �� ����

--26) �̸��� J �� �����ϴ� ������ ���, �̸� ��ȸ 

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

--�̸��� M���� �����ϴ� ������ ��� �̸� ��ȸ 

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


--�̸��� M�� ���� ������ ��� �̸� ��ȸ 

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

-- �̸��� ����° �ڸ��� m�� ���� ������ ��� �̸� 

SELECT e.empno 
     , e.ename
  FROM emp e
 WHERE e.ename LIKE '__M%' --���� �ͽĹ��� _�� �ι� ����Ͽ� M ���ڸ��� 2���ڷ� ����
;

/*
EMPNO, ENAME
----------------
7900	JAMES
*/

--�̸��� ��°�ڸ����� LA�� ���� �̸��� ���� ������ ��� �̸� ��ȸ 

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

--�̸��� J_�� �����ϴ� ������ ��� �̸��� ��ȸ 
-- ��ȸ�Ͽ��� ���� �ν� ���� (%, _) �� ��� �ִ� �����ʹ� ��� ��ȸ�Ұ��δ�

-- ==> ��ó�� LIKE ������ �ۼ��ϸ� J �ڿ� ��� 1���ڰ� �ִ� 
--     �̸��� ���� ������ ��� �˻��� , ���ϴ� ����� �ƴϴ� 

--     ���� �ν� ���ڸ� ��ȸ�Ϸ��� ESCAPE�� ����ؾ� �Ѵ� 
--     ���� �ν� ���ڸ� ��ȿȭ�Ϸ��� ESCAPE�� ����ؾ� �Ѵ� 

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

--NULL�� ���õ� SQL ������ : IS NULL, IS NOT NULL
--���Ϸ� �ϴ� �÷��� ���� NULL �϶� true  
--���Ϸ� �ϴ� �÷��� ���� NULL �� �ƴϸ� false 
--IS NOT NULL 
--���Ϸ� �ϴ� �÷��� ���� NULL �� �ƴҶ� true  
--���Ϸ� �ϴ� �÷��� ���� NULL �϶� false   
--NULL ���� ���� �÷��� �񱳿����� �� ������ �Ұ����ϹǷ� 
--NULL ���� �񱳸� ���� �����ڰ� ���� �����Կ� ����! 

--col = NULL => NULL�� ���ؼ��� ���Ϻ�(=) ������ ��� ����
--col != NULL 
--col <> NULL => NULL�� ���ؼ��� �ٸ��� ���ϴ� ������(<>,=!) ��� ����

--27)���(mgr)�� �������� ���� ������ ���, �̸�, ����� ��ȸ 
SELECT e.empno
     , e.ename 
     , e.mgr
  FROM emp e 
 WHERE e.mgr IS NULL -- e.mgr = NULL�� �ϸ� �ȵȴ�.
;

/*
EMPNO,  ENAME,  MGR 
--------------------------
9999	J_JAMES	
8888	J%JAMES	
7839	KING	
*/
--���(mgr)�� ������ ������ ���, �̸�, ����� ��ȸ 
SELECT e.empno
     , e.ename 
     , e.mgr
  FROM emp e 
 WHERE e.mgr IS NOT NULL -- e.mgr != NULL�� �ϸ� �ȵȴ�. , ���࿡�� ������ ����
;

-------------------------------------------------------------------------------------------- 
--BETWEEN a AND b :���� ���� �� ������ 
--a <= sal <= b �̷��ѹ��� ����� ������ ���
-- a <= sal <= b ���ٴ�  sal <= sal 

--28)�޿��� 500 ~ 1200������ ������ 
--���, �̸�, �޿� ��ȸ 

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

--BETWEEN 500 AND 1200 ���� ����� ���� �� �����ڷ� ���� 

SELECT e.empno 
     , e.ename 
     , e.sal
  FROM emp e 
 WHERE e.sal > 500 
   AND e.sal < 1200 
;


-------------------------------------------------------------------------------------------- 

--EXISTS ������ : � ����(SELECT)�� ������ ����� 1�� �̻��϶� ������ �Ǵ�  
--                ����� ��� ��:0 �� ��� �������� �Ǵ� ���� ���������� �Ա� ����

--29) 
--  (1) �޿��� 3000�� �Ѵ� ������ ��ȸ 
SELECT e.sal
     , e.empno 
     , e.ename
  FROM emp e
 WHERE e.sal > 3000 
; 

--7839 KING 5000 
-- 29-(1) ������ ����� 1���� ����(EXISTS)
--    (2) �޿��� 3000�� �Ѵ� ������ 1���̶� ������ ȭ�鿡 '�޿��� 3000�� �Ѵ� ������ ������'
--        �޽����� ����ϰ� �ʹ�.
 
 SELECT '�޿��� 3000�� �Ѵ� ������ ������' AS "�ý��� �޽���" 
   FROM dual -- 1�ุ ������ �ִ� ���� ���̺�
  WHERE EXISTS (SELECT e.empno 
                     , e.ename
                     , e.sal
                    FROM emp e
                   WHERE e.sal > 3000)  -- �ڵ��� ���;� �Ѵ�. , 1���ٴ� Ŀ���Ѵ�
;
/*
�ý��� �޽���
-----------------------------------
 �޿��� 3000�� �Ѵ� ������ ������
 */
 
 --oracle ���� �����ϴ� dual ���̺� 
 --: 1�� 1���� �����Ͱ� ����ִ� �������̺� 
 -- 1)dual ���̺��� ���̺� ������ Ȯ�� 
 
DESC dual; 

/*
�̸�    ��? ����          
----- -- ----------- 
DUMMY    VARCHAR2(1) 
*/
-- ���� DESC�� ������ Ű���尡 �ƴ� ����Ŭ�� ��ɾ� 
-- ���̺��� ������ Ȯ���ϴ� ��� 
-- Describe �� ���� 

SELECT dummy
  FROM dual
; 

/*
DUMMY
-------
X
*/


--�޿��� 10000�� �Ѵ� ������ ������ 
--ȭ�鿡 "�ݿ��� 10000�� �Ѵ� ������ �������� ����" �̶�� ��� 
--(1) �޿��� 10000�� �Ѵ� ������ ���� 
SELECT e.sal
     , e.empno 
     , e.ename
  FROM emp e
 WHERE e.sal > 10000 
;  
--(2) �ý��� �޽����� ����Ҽ� �ֵ��� ���� ���� 
SELECT '�ݿ��� 10000�� �Ѵ� ������ �������� ����' as "�ý��� �޽���"
  FROM dual 
 WHERE NOT EXISTS(SELECT e.sal
                       , e.empno 
                       , e.ename
                    FROM emp e
                   WHERE e.sal > 10000) 
;


/*
�ý��� �޽���
--------------------------------------
�ݿ��� 10000�� �Ѵ� ������ �������� ����
*/

-------------------------------------------------------------------------------------------- 
--(6)������:���� ������(||) 
--   ����Ŭ���� ���� ,���ڿ� ����(����) 
--   �ٸ� ���α׷��� ���(JAVA, C , C++) ������ 
--   OR �����ڷ� ��� �ǹǷ� ȥ������ �ʱ�


SELECT 'Hello ~ SQL' || 'in Oracle' AS greeting 
  FROM dual
;


SELECT '�ȳ��ϼ��� ~ SQL' || '����Ŭ���� ���� �־��' AS greeting 
  FROM dual
;

--dual ���̺� Ȱ��, ������ ��¥�� �˷��ִ� ����  
--ex)������ ��¥�� 0000 �Դϴ�.

SELECT '������' || sysdate || '�Դϴ�' as "���ó�¥" 
  FROM dual
;
/*
���ó�¥
--------------------
������19/05/17�Դϴ�   
*/ 
--  ==>�ý��� ���� 00/00/00���� ǥ�õȴ� 

SELECT '������ ��¥��' 
       ||TO_CHAR(sysdate,'YYYY-MM-DD') 
       || '�Դϴ�' as "���ó�¥" 
  FROM dual
;


--�������� ��� �˸��� ����ʹ�,. 
--������ ����� �˷��ִ� ||������ ����Ͽ� �ۼ�

SELECT '�ȳ��ϼ��� ' ||e.ename ||'�� ����� ����� '
                    ||e.empno || '�Դϴ�' AS �����ȣ
  FROM emp e
;
/*
�����ȣ
--------------------------------------------
�ȳ��ϼ��� J_JAMES�� ����� ����� 9999�Դϴ�
�ȳ��ϼ��� J%JAMES�� ����� ����� 8888�Դϴ�
�ȳ��ϼ��� SMITH�� ����� ����� 7369�Դϴ�
�ȳ��ϼ��� ALLEN�� ����� ����� 7499�Դϴ�
�ȳ��ϼ��� WARD�� ����� ����� 7521�Դϴ�
�ȳ��ϼ��� JONES�� ����� ����� 7566�Դϴ�
�ȳ��ϼ��� MARTIN�� ����� ����� 7654�Դϴ�
�ȳ��ϼ��� BLAKE�� ����� ����� 7698�Դϴ�
�ȳ��ϼ��� CLARK�� ����� ����� 7782�Դϴ�
�ȳ��ϼ��� KING�� ����� ����� 7839�Դϴ�
�ȳ��ϼ��� TURNER�� ����� ����� 7844�Դϴ�
�ȳ��ϼ��� JAMES�� ����� ����� 7900�Դϴ�
�ȳ��ϼ��� FORD�� ����� ����� 7902�Դϴ�
�ȳ��ϼ��� MILLER�� ����� ����� 7934�Դϴ�
*/

-------------------------------------------------------------------------------------------- 

--(6) ������ 6. ���տ����� 
-- ù��° ���� : �μ����̺��� ��� ���� ��ȸ
SELECT d.deptno
     , d.dname 
     , d.loc
FROM dept d
; 

-- �ι��� ���� : �μ���ȣ�� 10�� �μ��� ��� ���� ��ȸ
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

--2) UNION :�ߺ��� ������ ������ 
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

--3) INTERSECT :�ߺ��� ���� ����(������) 
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

--4) MINUS :ù��° ���� ���������� �ι�° ���� ���� ����� �� ������ 
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

-- ���� : �� ������ ��ȸ ����� �ķ��� ���� , ������ Ÿ���� ������ ��ġ
--1)������Ȳ ù���� �÷��� 3, �������� Į���� 2 


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
/*ORA-01789: ���� ����� ����Ȯ�� ���� ��� ���� ������ �ֽ��ϴ�.*/

--2)������Ȳ ù���� ����, ���� ���� �Ѷ� ���� �÷��� ����, ���� ����

SELECT d.dname     --����
     , d.deptno    --����
  FROM dept d 
 UNION ALL
SELECT d.deptno   --����
     , d.dname    --����
  FROM dept d
 WHERE d.deptno = 10
;
/*ORA-01790: �����ϴ� �İ� ���� ������ �����̾�� �մϴ�*/


--���տ����ڴ� ���� �ٸ� ���̺� ��ȸ ����� ���� ���� 
--ù��° ����: emp���̺��� ��ȸ 
SELECT e.empno 
     , e.ename 
     , e.job
FROM emp e 
;
--�ι��� ����:dept���̺��� ��ȸ 
SELECT d.deptno 
     , d.dname 
     , d.loc
FROM dept d
; 

--���� �ٸ� ���̺��� 
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
--==>������ ����� ���� ���� ���� ������ �ȴ�. 

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
-- =>���δٸ� ���̺��� ������ ��ȸ ������� ���� �����̹Ƿ� 
--   �ߺ��� �����Ͱ� �����Ƿ� ������ ����� 1�൵ ����

-------------------------------------------------------------------------------------------- 

-------------------------------------------------------------------------------------------- 

-------------------------------------------------------------------------------------------- 

-------------------------------------------------------------------------------------------- 
