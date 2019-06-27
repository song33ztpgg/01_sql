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




--------------------------------------------------------
- ������ �ǽ�

-- 1. �Ŵ�����, ���������� ���� ���ϰ�, ���� ������ ����
--   : mgr �÷��� �׷�ȭ ���� �÷�
SELECT e.MGR     as "�Ŵ��� ���"
     , COUNT(*)  as "�������� ��"
  FROM emp e
 WHERE e.MGR IS NOT NULL
 GROUP BY e.MGR 
;

-- 2. �μ��� �ο��� ���ϰ�, �ο��� ���� ������ ����
--    : deptno �÷��� �׷�ȭ ���� �÷�
SELECT e.DEPTNO  as "�μ� ��ȣ"
     , COUNT(*)  as "�ο�(��)"
  FROM emp e
 WHERE e.DEPTNO IS NOT NULL
 GROUP BY e.DEPTNO
 ORDER BY "�ο�(��)" DESC
;
-- 2.2 deptno �� null �� �����ʹ� '�μ� �̹���' ���� ��µǵ��� ó��
SELECT nvl(e.DEPTNO || '', '�̹���') as "�μ� ��ȣ"
     , COUNT(*)  as "�ο�(��)"
  FROM emp e
 GROUP BY e.DEPTNO
 ORDER BY "�ο�(��)" DESC
;

-- 3. ������ �޿� ��� ���ϰ�, �޿���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�
SELECT e.JOB      as "����"
     , AVG(e.SAL) as "�޿� ���"
  FROM emp e
 GROUP BY e.JOB
 ORDER BY "�޿� ���" DESC
;

-- 3.2 job �� null �� �����ʹ� '���� �̹���' ���� ��µǵ��� ó��
SELECT nvl(e.JOB, '���� �̹���') as "����"
     , AVG(e.SAL)                as "�޿� ���"
  FROM emp e
 GROUP BY e.JOB
 ORDER BY "�޿� ���" DESC
;

-- 4. ������ �޿� ���� ���ϰ�, ���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�
SELECT e.JOB      as "����"
     , SUM(e.SAL) as "�޿� ����"
  FROM emp e
 GROUP BY e.JOB
 ORDER BY "�޿� ����" DESC
;  

-- 5. �޿��� �մ����� 1000�̸�, 1000, 2000, 3000, 5000 ���� �ο����� ���Ͻÿ�
--    �޿� ���� ������������ ����
-- a) �޿� ������ ��� ���� ���ΰ�? TRUNC() Ȱ��
SELECT e.EMPNO
     , e.ENAME
     , TRUNC(e.SAL, -3) as "�޿� ����"
  FROM emp e
;

-- b) TRUNC �� �� �޿������� COUNT �ϸ� �ο����� ���� �� �ְڴ�.
--    TRUNC(e.SAL, -3) �� �߶� ���� �׷�ȭ ���ذ����� ����
SELECT TRUNC(e.SAL, -3)       as "�޿� ����"
     , COUNT(TRUNC(e.SAL, -3))
  FROM emp e
 GROUP BY TRUNC(e.SAL, -3)
 ORDER BY "�޿� ����" 
;

-- c) �޿� ������ 1000 �̸��� ��� 0���� ��µǴ� ���� ����
--   : ���� ������ �ʿ��� ���� ===> CASE ���� ����
SELECT CASE WHEN TRUNC(e.SAL, -3) < 1000 THEN '1000 �̸�'
            ELSE TRUNC(e.SAL, -3) || ''            
        END as "�޿� ����"
     , COUNT(TRUNC(e.SAL, -3)) "�ο�(��)"
  FROM emp e
 GROUP BY TRUNC(e.SAL, -3)
 ORDER BY TRUNC(e.SAL, -3)
;

-------------------------------------------------------------------------------
--- 5���� �ٸ� �Լ��� Ǯ��
-- a) sal �÷��� �������� �е��� �ٿ��� 0�� ä��
SELECT e.EMPNO
     , e.ENAME
     , LPAD(e.SAL, 4, '0')
  FROM emp e
;
-- b) �� ���� ���ڸ� �߶󳽴�. ==> ������ ����
SELECT e.EMPNO
     , e.ENAME
     , SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1)
  FROM emp e
;

-- c) ������ ó�� + COUNT + �׷�ȭ
SELECT SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1) "�޿� ����"
     , COUNT(*) "�ο�(��)"
  FROM emp e
 GROUP BY SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1)
;  
  
-- d) 1000 ������ ��� ���� ����
SELECT CASE WHEN SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1) = 0 THEN '1000 �̸�'
            ELSE TO_CHAR(SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1) * 1000)
        END  "�޿� ����"
     , COUNT(*) "�ο�(��)"
  FROM emp e
 GROUP BY SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1)
 ORDER BY SUBSTR(LPAD(e.SAL, 4, '0'), 1, 1)
;



--------------------------------------------------------------------------------
---------------------------------------------------------------------------------
-- 6. ������ �޿� ���� ������ ���ϰ�, �޿� ���� ������ ū ������ ����
-- a) job ���� �޿��� ���� ���� ==>  �׷�ȭ ���� �÷����� job �� ���
SELECT e.JOB
     , SUM(e.SAL)
  FROM emp e
 GROUP BY e.JOB
;

-- b) job �� �޿��� �տ��� ������ ����
SELECT e.JOB
     , TRUNC(SUM(e.SAL), -3) "�޿� ����"
  FROM emp e
 GROUP BY e.JOB
;

-- c) ����, NULL ó��
SELECT NVL(e.JOB, '�̹���')  "����"
     , TRUNC(SUM(e.SAL), -3) "�޿� ����"
  FROM emp e
 GROUP BY e.JOB
 ORDER BY "�޿� ����" DESC
;

-- 7. ������ �޿� ����� 2000������ ��츦 ���ϰ� ����� ���� ������ ����
-- a) �������� �޿� ����� ������ : �׷�ȭ ���� �÷� : job
SELECT e.JOB
     , AVG(e.SAL) "�޿� ���"
  FROM emp e
 GROUP BY e.JOB
;

-- b) a���� ������ ����� 2000 ���� ������ ����
SELECT e.JOB
     , AVG(e.SAL) "�޿� ���"
  FROM emp e
 GROUP BY e.JOB
HAVING AVG(e.SAL) <= 2000
 ORDER BY "�޿� ���" DESC
;


-- 8. �⵵�� �Ի� �ο��� ���Ͻÿ�
--   : hiredate �� Ȱ�� ==> �⵵�� �����Ͽ� �׷�ȭ �������� ���
-- a) hiredate ���� �⵵ ���� : TO_CHAR(hiredate, 'YYYY')
-- b) ���ذ����� �׷�ȭ �ۼ�
SELECT TO_CHAR(e.hiredate, 'YYYY') "�Ի� �⵵"
     , COUNT(*) "�ο�(��)"
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'YYYY')
 ORDER BY "�Ի� �⵵"
; 

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------- 

--9.�⵵�� ���� �Ի� �ο��� ���Ͻÿ�. 
-- : hiredate�� Ȱ�� 
--   hiredate ���� �⵵, ���� ���� 
--   ����� �� ���� �׷�ȭ �������� ��� 
--   �Ի��ο��� COUNT�׷��Լ� ���

-- a)�⵵ ���� : TO_CHAR(e.hiredate, 'YYYY') 
--   �� ����   : TO_CHAR(e.hiredate, 'MM') 

-- b) �ΰ��� �������� �׷�ȭ ����

SELECT TO_CHAR(e.hiredate, 'YYYY')  "�Ի� �⵵"
     , TO_CHAR(e.hiredate, 'MM')   "�Ի� ��"
     , COUNT(*)                     "�ο�(��)"
  FROM emp e 
 GROUP BY TO_CHAR(e.hiredate, 'YYYY') , TO_CHAR(e.hiredate, 'MM') 
 ORDER BY "�Ի� �⵵", "�Ի� ��"
; 

-- c) �⵵��, ���� �Ի� �ο��� ����� ���� ǥ ���·� ��ȯ 

-- a)�⵵ ���� : TO_CHAR(e.hiredate, 'YYYY') 
--   �� ����   : TO_CHAR(e.hiredate, 'MM') 

-- hiredate ���� ������ ���� ���� 01 ���ö� 
-- �׶��� ���� ������ 1������ ī��Ʈ COUNT() 
-- �� ������ 12�� ���� �ݺ� 

SELECT e.empno
     , e.ename
     , TO_CHAR(e.hiredate, 'YYYY') "�Ի� �⵵" 
     , TO_CHAR(e.hiredate, 'MM')   "�Ի� ��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '01' , 1) "1��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '02' , 1) "2��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '03' , 1) "3��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '04' , 1) "4��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '05' , 1) "5��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '06' , 1) "6��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '07' , 1) "7��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '08' , 1) "8��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '09' , 1) "9��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '10' , 1) "10��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '11' , 1) "11��"
     , DECODE(TO_CHAR(e.hiredate, 'MM'), '12' , 1) "12��"
  FROM emp e 
 ORDER BY "�Ի� �⵵"
;


/*
DECODE 12���� ����ؼ� 12���� �÷��� �����
*/

-- �׷�ȭ ���� �÷��� "�Ի� �⵵"�� ��´�. 
SELECT TO_CHAR(e.hiredate, 'YYYY') "�Ի� �⵵"
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '01' , 1)) "1��"
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
 GROUP BY TO_CHAR(e.hiredate, 'YYYY') 
 ORDER BY "�Ի� �⵵"
;

-- ���� �� �Ի� �ο��� ���� ���η� ���
-- �׷�ȭ ���� �÷��� �ʿ� ����
SELECT '�ο�(��)' AS "�Ի� ��"     
     , COUNT(DECODE(TO_CHAR(e.hiredate, 'MM'), '01' , 1)) "1��"
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
;














