--day09: 

--2. ������ �Լ�(�׷� �Լ�)
--1) COUNT(*) : FROM ���� ������ Ư�� ���̺��� 
--              ���� ����(������ ����)�� �����ִ� �Լ�
--              NULL�� ó���ϴ� "����"�� �׷� �Լ� 

--   COUNT(expr) : expr ���� ������ NULL �����ϰ� �����ִ� �Լ�  


-- ����:  dept,salagrade ���̺��� ��ü ������ ���� ��ȸ
-- 1. dept ���̺� ��ȸ

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


--2. dept���̺��� ������ ���� ��ȸ : COUNT(*) ���
SELECT COUNT(*) �μ�����
  FROM dept d
;
--���: 4

SELECT COUNT(*) "�޿� ��� ����" 
  FROM salgrade s 
; 
--��� : 5 

-- COUNT(expr) ��  NULL �����͸� ó������ ���ϴ� �� Ȯ���� ���� ������ �߰� 
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME) VALUES ('7777', 'JJ'); 
COMMIT; 

--emp���̺��� job �÷��� ������ ������ ī��Ʈ 
SELECT COUNT(*)  "��ü"
     , COUNT(e.job) "job NULL���� �����Ҷ�"
  FROM emp e
; 
/*
��ü, job NULL���� �����Ҷ�
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
7782	CLARK    ==> ������ ���� ���� �÷��� job�� null�� 
7698	BLAKE    ==> ���� ó�� ���� �ʴ´�. 
7566	JONES    ==>
7902	FORD     ==> COUNT(e.job) ==> 14
7839	KING     ==>
8888	J%JAMES  ==>
9999	J_JAMES  ==>
7777	JJ       ==>
*/


--����)ȸ�翡 �Ŵ����� ������ ������ ����ΰ� 
--    ��Ī : ��簡 �ִ� ������ �� 
SELECT COUNT(e.mgr) "��� ���� �ο�"
  FROM emp e 
; 
-- ��� : 11

SELECT COUNT(e.mgr = 7698) "��� ���� �ο�"
  FROM emp e 
; 

--����) �Ŵ��� ���� �ð� �ִ� ������ ����ΰ�? 
-- 1. emp ���̺��� mgr �÷��� ������ ���¸� ���� 
-- 2. mgr�÷��� �ߺ� �����͸� ���� 

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
-- 3. �ߺ� �����Ͱ� ���ŵ� ����� ī��Ʈ

SELECT COUNT(DISTINCT e.mgr)  "�Ŵ��� ��"
  FROM emp e 
;
-- ��� : 5


-------------------------------------------------
--����) �μ��� ������ ������ ����̳� �ִ°�? 
SELECT COUNT(e.deptno) 
  FROM emp e 
;

SELECT e.deptno 
  FROM emp e  
 WHERE e.deptno IS NOT NULL
;
---------------------------------------------------------------------------
--����) ��ü�ο�, �μ� �����ο�, �μ� �̹��� �ο��� ���Ͻÿ� 
SELECT COUNT(*) ��ü 
     , COUNT(e.deptno) �����ο�
     , COUNT(*) - COUNT(e.deptno) �̹���
  FROM emp e
;
---------------------------------------------------------------------------- 
--SUM(expr) : NULL �׸� �����ϰ� �ջ� ������ ���� ��� ���� ����� ���  
-- SALESMAN ���� ���� ������ ���غ��� 

SELECT SUM(e.comm) "���� ����" 
  FROM emp e  
; 
--(null)�� ���ܽ�Ű�鼭 SUM�� ����

SELECT SUM(e.comm) "���� ����"  --���͸��� �� ����� �ް� ���������� ����
  FROM emp e 
 WHERE e.job = 'SALESMAN'   --���⼭ ���� ���͸� ����
;
-- ó������ NULL���� ���ܵ� ������� SUM�� ���� 
--��� : 2200 

--���� ���� ����� ��� ������ ���� $ , ���ڸ� ���� �б� ���� 
SELECT TO_CHAR(SUM(e.comm),'$9,999') 
  FROM emp e 
;
--��� :  $2,200 
---------------------------------------------------------------------------- 

--3) AVG(expr) NULL �� �����ϰ� ���� ������ �׸��� ��� ����� ���� 
-- SALESMAN �� ���� ����� ���غ���  
-- ���� ��� ����� ���� ��� ����  $ , ���ڸ� ���� �ϱ� ���� 

SELECT TO_CHAR(AVG(e.comm),'$9,999') 
  FROM emp e 
;
----------------------------------------------------------------------------
-- 4) MAX(expr) : expr�� ������ �� �� �ִ��� ����
--                expr�� ���� ��� ���ĺ��� ���ʿ� ��ġ�� ���ڸ� �ִ밪���� ���  

--�̸��� ���� ������ ���� 
SELECT MAX(e.ename) 
  FROM emp e 
;
-- 5) MIN(expr) : expr�� ������ �� �� �ּҰ��� ����
--                expr�� ���� ��� ���ĺ��� ���ʿ� ��ġ�� ���ڸ� �ִ밪���� ���  
SELECT MIN(e.ename) 
  FROM emp e 
;

-------------------------------------------------------------------------------
-- GROUP BY ���� ��� 

-- ����) ���μ����� �޿��� ������ ��ȸ 
-- ���� SUM��� , �޷�ȭ ������ �μ���ȣ ��� 
-- GROUP BY ���� �����ؾ� �� 
-- �׷�ȭ�� �Ϸ��� ���� �÷��� GROUP BY���� �����ؾ� ��

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

-- GROUP BY ���� �����ϸ� ���� , ���� �Ұ�

SELECT e.deptno
     , e.job     -- ����
     , SUM(e.deptno)
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno
;
-- ��� : ORA-00979: GROUP BY ǥ������ �ƴմϴ�.

-- ����) ���μ����� �޿��� ���� , ���, �ִ�, �ּҸ� ��ȸ  
SELECT e.deptno
     , TO_CART(SUM(e.deptno) , '$999,999') ����
     , TO_CART(AVG(e.deptno) , '$999,999') ���
     , TO_CART(MAX(e.deptno) , $'999,999') �ִ�
     , TO_CART(MIN(e.deptno) , $9'99,999') �ּ�
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno
;


SELECT TO_CHAR(SUM(e.sal) , '$999,999') ����
     , TO_CHAR(AVG(e.sal) , '$999,999') ���
     , TO_CHAR(MAX(e.sal) , '$999,999') �ִ�
     , TO_CHAR(MIN(e.sal) , '$999,999') �ּ�
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno
;


--���� ������ ������ ������ ��Ȯ�ϰ� ��� �μ��� ������� �˼� ���ٴ� ������ ���� 
-- �׷��� GROUP BY���� �����ϴ� ���� �÷��� SELECT ���� �Ȱ��� �����ϴ� ���� ��� �ؼ��� ���ϴ� 
-- SELECT ���� ������ �÷��߿��� �׷��Լ��� ������ �ʴ� �÷��� ���� ������ ���� ������ ����Ǵ� ���̴�.

SELECT e.deptno 
     , TO_CHAR(SUM(e.sal) , '$999,999') ����
     , TO_CHAR(AVG(e.sal) , '$999,999') ���
     , TO_CHAR(MAX(e.sal) , '$999,999') �ִ�
     , TO_CHAR(MIN(e.sal) , '$999,999') �ּ�
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno
;

--������Ȳ 
--a. GROUP BY ���� �׷�ȭ ������ ������ ���  


SELECT e.deptno 
     , e.job
     , SUM(e.sal) ����
     , AVG(e.sal) ���
     , MAX(e.sal) �ִ�
     , MIN(e.sal) �ּ�
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno
; 
--��� : RA-00979: GROUP BY ǥ������ �ƴմϴ�.

--b) SELECT ���� �׷��Լ��� �Ϲ� �÷��� ���� ���� GROUP BY �� ��ü�� ������ ��� 

SELECT e.deptno 
     , e.job
     , TO_CHAR(SUM(e.sal) , '$999,999') ����
     , TO_CHAR(AVG(e.sal) , '$999,999') ���
     , TO_CHAR(MAX(e.sal) , '$999,999') �ִ�
     , TO_CHAR(MIN(e.sal) , '$999,999') �ּ�
  FROM emp e 
-- GROUP BY e.deptno
 ORDER BY e.deptno 
;
--��� : ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ� 

---------------------------------
--����) ���� (job) �� �޿��� ���� ,���, �ִ�, �ּ� �� ���غ��� 
-- ��Ī :����, �޿�����, �޿����, �ִ�޿�, �ּұ޿� 

SELECT e.job
     , TO_CHAR( SUM(e.sal), '$99,999') �޿�����
     , TO_CHAR( AVG(e.sal), '$99,999.9') �޿����
     , TO_CHAR( MAX(e.sal), '$99,999') �ִ�޿�
     , TO_CHAR( MIN(e.sal), '$99,999') �ּұ޿�
  FROM emp e 
 GROUP BY e.job  
 ORDER BY e.job 
;

/* 
JOB,    �޿�����,    �޿����,     �ִ�޿�,   �ּұ޿�
ANALYST	  $3,000	  $3,000.00	  $3,000	  $3,000
CLERK	  $3,050	  $1,016.67	  $1,300	    $800
MANAGER	  $8,275	  $2,758.33	  $2,975	  $2,450
PRESIDENT $5,000	  $5,000.00	  $5,000	  $5,000
SALESMAN  $5,600	  $1,400.00	  $1,600	  $1,250
							
*/


SELECT NVL(e.job, '���� �̹���') ���� 
     , TO_CHAR( SUM(e.sal), '$99,999') �޿�����
     , TO_CHAR( AVG(e.sal), '$99,999.9') �޿����
     , TO_CHAR( MAX(e.sal), '$99,999') �ִ�޿�
     , TO_CHAR( MIN(e.sal), '$99,999') �ּұ޿�
  FROM emp e 
 GROUP BY e.job  
 ORDER BY e.job 
; 

/* 
JOB,    �޿�����,    �޿����,     �ִ�޿�,   �ּұ޿�
ANALYST	  $3,000	  $3,000.00	  $3,000	  $3,000
CLERK	  $3,050	  $1,016.67	  $1,300	    $800
MANAGER	  $8,275	  $2,758.33	  $2,975	  $2,450
PRESIDENT $5,000	  $5,000.00	  $5,000	  $5,000
SALESMAN  $5,600	  $1,400.00	  $1,600	  $1,250
���� �̹���								
*/ 

SELECT NVL(e.deptno , '���� �̹���') ���� 
     , TO_CHAR( SUM(e.sal), '$99,999') �޿�����
     , TO_CHAR( AVG(e.sal), '$99,999.9') �޿����
     , TO_CHAR( MAX(e.sal), '$99,999') �ִ�޿�
     , TO_CHAR( MIN(e.sal), '$99,999') �ּұ޿�
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno 
;  
-- deptno �� �����̱⶧���� ������ �߻� 

--�ذ���1
SELECT NVL(TO_CHAR(e.deptno), '���� �̹���') ���� 
     , TO_CHAR( SUM(e.sal), '$99,999') �޿�����
     , TO_CHAR( AVG(e.sal), '$99,999.9') �޿����
     , TO_CHAR( MAX(e.sal), '$99,999') �ִ�޿�
     , TO_CHAR( MIN(e.sal), '$99,999') �ּұ޿�
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno 
;  
--�ذ���2
SELECT NVL( e.deptno || '���� �̹���') ���� 
     , TO_CHAR( SUM(e.sal), '$99,999') �޿�����
     , TO_CHAR( AVG(e.sal), '$99,999.9') �޿����
     , TO_CHAR( MAX(e.sal), '$99,999') �ִ�޿�
     , TO_CHAR( MIN(e.sal), '$99,999') �ּұ޿�
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno 
;  

--�ذ���3 
SELECT DECODE(NVL(e.deptno, 0), e.deptno, TO_CHAR(e.deptno)
                                      ,0,'�μ� �̹���') "�μ� �̹���"
     , TO_CHAR( SUM(e.sal), '$99,999') �޿�����
     , TO_CHAR( AVG(e.sal), '$99,999.9') �޿����
     , TO_CHAR( MAX(e.sal), '$99,999') �ִ�޿�
     , TO_CHAR( MIN(e.sal), '$99,999') �ּұ޿�
  FROM emp e 
 GROUP BY e.deptno
 ORDER BY e.deptno 
;  




----------------------------------------------------------------------------------

---4.HAVING 
-- GROUP BY ����� ������ �ɾ ����� ������ �������� ���Ǵ� �� 
-- WHERE �� �� ����� , ������ ��������� WHERE�� ���� �Ǳ� ������ GROUP  
-- GROUP BY�� ������ �� ����. 
-- ���� GROUP BY ���� ��������� ������ HAVING���� �����Ѵ�
 
-- ����) �μ��� �޿� ����� 2000�̻��� �μ��� ��ȭ�Ͽ��� 

--a. �켱 �μ��� �޿� ����� ���Ѵ�.
SELECT e.deptno 
     , AVG(e.sal) 
  FROM emp e
 GROUP BY e.deptno
;
--b. a����� �޿� ����� 2000 �̻��� ���� �����. 
SELECT e.deptno 
     , TO_CHAR(AVG(e.sal), '$99,999.99') ��� 
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000  
/*
HAVING ��� >= 2000  
�ȵȴ�. ����� ��� �ܵ�
*/
;

/*
1.FROM       ���� ���̺� �� �� ��θ� ������� 
2.WHERE      ���� ������ �´� �ุ �����ϰ� 
3.GROUP BY   ���� ���� �÷�, ��(�Լ� ��), ���� �׷�ȭ ���� 
4.HAVING     ���� ������ ������Ű�� �׷��ุ ����
             4���� ���õ� �׷� ������ �����࿡ ���ؼ� 
5. SELECT    SELECT���� ��õ� �÷�, ��(�Լ� ��)�� ���
6. ORDER BY  ORDER BY�� �ִٸ� ���� ���ǿ� ���߾� ���� �����Ͽ� ��� ���
*/

-----------------------------------------------------------------------------------

-- ������ �ǽ�

-- 1. �Ŵ�����, ���������� ���� ���ϰ�, ���� ������ ����
--   : mgr �÷��� �׷�ȭ ���� �÷�
SELECT e.mgr 
     , COUNT(mgr)
  FROM emp e
 GROUP BY e.mgr  
;

-- 2.1 �μ��� �ο��� ���ϰ�, �ο��� ���� ������ ����
--    : deptno �÷��� �׷�ȭ ���� �÷�

-- 2.2 �μ� ��ġ �̹��� �ο� ó��


-- 3.1 ������ �޿� ��� ���ϰ�, �޿���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�
SELECT e.job 
     , ORDER BY(AVG(e.sal))
  FROM emp e
 GROUP BY e.job 
 --ORDER BY e.sal
;

-- 3.2 job �� null �� ������ ó��


-- 4. ������ �޿� ���� ���ϰ�, ���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�


-- 5. �޿��� �մ����� 1000�̸�, 1000, 2000, 3000, 5000 ���� �ο����� ���Ͻÿ�
--    �޿� ���� ������������ ����


-- 6. ������ �޿� ���� ������ ���ϰ�, �޿� ���� ������ ū ������ ����



-- 7. ������ �޿� ����� 2000������ ��츦 ���ϰ� ����� ���� ������ ����



-- 8. �⵵�� �Ի� �ο��� ���Ͻÿ�

