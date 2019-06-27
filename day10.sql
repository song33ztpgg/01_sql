-- day 10 
----7.���ΰ� �������� 
--(1) ���� : JOIN 
-- �ϳ� �̻��� ���̺��� �������� ��� �ϳ��� ���̺��� �� ó�� �ٷ�� ���
-- ������ �߻���Ű���� FROM ���� ���ο� ����� ���̺��� ����


/*
������� 7777,8888,9999 ������ ����
DELETE FROM "SCOTT"."EMP" WHERE ROWID = 'AAAR9ZAAHAAAACUAAA' AND ORA_ROWSCN = '2489006' and ( "EMPNO" is null or "EMPNO" is not null )
DELETE FROM "SCOTT"."EMP" WHERE ROWID = 'AAAR9ZAAHAAAACUAAB' AND ORA_ROWSCN = '2489006' and ( "EMPNO" is null or "EMPNO" is not null )
DELETE FROM "SCOTT"."EMP" WHERE ROWID = 'AAAR9ZAAHAAAACVAAA' AND ORA_ROWSCN = '5594872' and ( "EMPNO" is null or "EMPNO" is not null )

COMMIT;
*/


-- ����) ������ �Ҽ� �μ� ��ȣ�� �ƴ� �μ� ���� ���� ��ȸ�ϰ� �ʹ� 
--a) FROM ���� ���̺��� ����
--   emp , dept �� ���̺��� ���� => ������ �߻� ==> �����̺��� ��� ���� 
SELECT e.empno
     , e.ename
     , e.deptno
     , '  |' "������"
     , d.deptno 
     , d.dname
  FROM emp e 
     , dept d
;

--12��(emp) * 4��(dept) = 48�� �����Ͱ� �������� ����

-- b) ���� ������ �߰��Ǿ�� ������ �Ҽ� �μ��� ��Ȯ�� ������ �� �ִ�.

SELECT e.empno
     , e.ename
     , e.deptno
     , '  |' "������"
     , d.deptno 
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno = d.deptno 
 ORDER BY d.deptno
;

-- ��� , �̸�, �μ��� �� ����� 
SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno = d.deptno 
 ORDER BY d.deptno
; 

-- ���� �����ڸ� ����Ͽ� ����(�ٸ� DBMS ���� �ַ� ���)

SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno )
 ORDER BY d.deptno
;


-- ���� ������� ACCOUNTING �μ� ������ �˰� �ʹ�. 
-- 10�μ� ������ ��ȸ�Ͽ��� 
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
 WHERE e.deptno = d.deptno     -- ��������
   AND d.dname = 'ACCOUNTING'  -- �Ϲ� ����
; 

--ACCOUNTING �μ� �Ҽ��� ���� ��ȸ�� 
--���� �����ڸ� ����� ������ �����غ����� 
 
SELECT e.empno 
     , e.ename 
FROM emp e JOIN dept d ON (e.deptno = d.deptno )
WHERE d.dname = 'ACCOUNTING'
;

--2) join: īƼ�� ��(īƼ�� ����) 
 --         ���� ��� ���̺��� �����͸� ������ ��� �������� ���� �� 
--          WHERE ���� ���� ���� ������ �߻�
--          CROSS JOIN �����ڷ� �߻���Ŵ(����Ŭ 9i ���� ���ķ� ��밡��)

--emp, deptm salgrade �� ���� ���̺�� īƼ�� �� �߻�
SELECT e.empno
     , d.dname
     , s.grade
  FROM emp e         --12��
     , dept d        -- 4�� 
     , salgrade s    -- 5��
; 
--��� 12 * 4 * 5

SELECT e.empno
     , d.dname
     , s.grade
  FROM emp e  CROSS JOIN dept d        
              CROSS JOIN salgrade s        
; 

--3)    EQUI JOIN : �����ǰ��� �⺻ ���� 
--                  ���� ��� ���̺� ������ ���� �÷� = �� ����
--                  ���� �÷��� join

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



--c) NATURAL JOIN Ű����� �ڵ� ���� 
--   : ON ���� ���� 
--     join -attribute�� ����Ŭ DBMS �� �ڵ����� �Ǵ� 

SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e NATURAL JOIN dept d --���� ���� �÷� ��ð� ����
;

--d) JOIN ~ USING
SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e JOIN dept d USING(deptno) --���� ���� �÷� ��ð� ����
;

-- 4) �� ���� EQUI - JOIN ���� �ۼ��� 
--a ����Ŭ ���� ���� ����
SELECT [��Ī1.]�÷���1, [��Ī2.]�÷���2,
  FROM ���̺�1 ��Ī1,���̺�2 ��Ī2[, ..] 
 WHERE ��Ī1.�����÷�1 = ��Ī2.�����÷�1 
 [AND  ��Ī1.�����÷�2 = ��Ī2.�����÷�2]  -- ���� ��� ���̺��� �������� ���
 [AND .. ]                                  --WHERE ���� �����Ǵ� �������� �þ� 
 [AND ..  �߰� ������ �Ϲ� ���ǵ�]
;
--b JOIN ~ ON
SELECT [��Ī1.]�÷���1, [��Ī2.]�÷���2,
  FROM ���̺�1 ��Ī1 JOIN ���̺�2 ��Ī2 ON (��Ī1.�����÷�1 = ��Ī2.�����÷�1) 
                    [JOIN ���̺�3 ��Ī3 ON (��Ī1.�����÷�2 = ��Ī3.�����÷�2)]
                    [JOIN ���̺�n ��Īn ON (��Īn-1.�����÷�n-1 = ��Īn.�����÷�n)]
[WHERE �Ϲ�����] 
  [AND �Ϲ�����]
;

--c NATURAL JOIN
SELECT [��Ī1.]�÷���1, [��Ī2.]�÷���2 [, ...]
  FROM ���̺�1 ��Ī1 NATURAL JOIN ���̺�2 ��Ī2 
                   [NATURAL JOIN ���̺�n ��Īn] 
;

--d JOIN ~ USING

SELECT [��Ī1.]�÷���1, [��Ī2.]�÷���2 [, ...]
  FROM ���̺�1 ��Ī1 JOIN ���̺�2 ��Ī2 USING (�����÷�) 
                    [JOIN ���̺�n ��Īn USING (�����÷�)] -- ��Ī ������
;

-------------------------------------------------------
5) NON-EQUI JOIN : WHERE �������� join -attribute ����ϴ� ��� 
                �ٸ� �� �����ڸ� ����Ͽ� ���� ���̺��� ���� ��� 
--���� ) emp, salgrade ���̺��� ����ؼ� ������ �޿���  �߼�����
SELECT e.empno
     , e.ename
     , e.sal 
     , s.grade
  FROM emp e
     , salgrade s
 WHERE e.sal BETWEEN s.losal AND s.hisal 
;

-- emp ���̺��� salgrade ���̺���� ���Ϻ��ؼ� 
-- ���� �Ҽ� �ִ� ���� ����, ���� EQUI-JOIN �Ұ��� 

--JOIN ON ���� ����
SELECT e.empno
     , e.ename
     , e.sal 
     , s.grade
  FROM emp e JOIN salgrade s ON (e.sal BETWEEN s.losal AND s.hisal) 
;


/*
--OUTER JOIN ���� ����� ���� �μ���ȣ�� NULL �� ������ ����
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL) VALUES ('7777', 'JJ', 'CLERK', '7902', TO_DATE('2019-06-27 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '900')
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM) VALUES ('8888', 'J_JAMES', 'SALESMAN', '7698', TO_DATE('2019-06-07 13:10:34', 'YYYY-MM-DD HH24:MI:SS'), '1250', '200')
COMMIT;
*/ 

--6) OUTER JOIN : ���� ��� ���̺��� ���� Į���� NULL���� �����͵� 
--                ����� ���Ҷ� ����ϴ� ���� ��� 

-- ������ : (+), LEFT OUTER JOIN, RIGHT OUTER JOIN 

---- 1.(+) ����Ŭ������ ����ϴ� OUTER JOIN ������
--          EQUI-JOIN ���ǿ� NULL �� ����� ���ϴ� �ʿ� �ٿ��� ��� 

--������ ������ �μ���� �Բ� ��ȸ
SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno = d.deptno 
; 
--JJ, J_HAMES �� e.deptno�� NULL�̹Ƿ� dept ���̺� ��ġ�ϴ� ���� �����Ƿ� ���� ����� 
--���� ����� �� ������ ��ȸ���� �ʴ´�. 
--���� ��ġ�� ���� �ʴ� ������ ��� ����� �ϰ� �ʹ�.
--�׷����� dept ���̺����� �����Ͱ� null �̾ ����� �ʿ� 
--�߰� ����� ���ϴ� �ʿ� (+) �����ڸ� ���δ�. 

/*
�μ��� NULL ���̱⿡ 7777,8888 �μ��� ���� ���� ������ �ʴ´� 
BUT ���ϴ� ��� : 7777 JJ (NULL) �������� ����� ����
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
 
 -- LEFT OUTER JOIN, RIGHT OUTER JOIN  � ���̺� ����� �� ���ϴ°� 
 -- (+) null �����͸� ���ϴ� ���̺�

-- (+) �����ڴ� �����ʿ� ���� �̴� NULL ���·� ��µ� ���̺��� ���� ���´�. 
-- ��ü ������ ���� ��� ���̺��� �����̱� ������ 
-- LEFT OUTER JOIN�� �߻���

-- 2.LEFT OUTER JOIN ~ ON

SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e LEFT OUTER JOIN dept d on (e.deptno = d.deptno)
; 

--emp e �� ���̺��� ��� ������ ����� �ϰ� �ȴ�. 
--ON ���� ���� ���� ������ EQUI-JOIN�� ���������� 
--LEFT OUTER JOIN �����ڿ� ���� 
--�� ������ ���ʿ� ��ġ�� ���̺��� ��� �����ʹ� ����� ���� �޴´�. 
--����� (+) �����ڸ� �����ʿ� ���� ����� ���� 

--����) ������ ���� �ƹ��� ��ġ���� ���� �μ��� �־ ��� �μ��� 
--      ��µǱ� �ٶ��ٸ�

--RIGHT OUTER JOIN�� �̿��Ͽ� �ذ�
SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e RIGHT OUTER JOIN dept d on (e.deptno = d.deptno)
; 

-- (+)�����ڷ� �ذ� : '=' �����ڸ� �����ʿ� ����Ѵ�.
SELECT e.empno
     , e.ename 
     , d.dname
  FROM emp e 
     , dept d
 WHERE e.deptno(+) = d.deptno  
; 


--4. FULL OUTER JOIN
--����) �μ���ġ�� �ȵ� ������ ��ȸ�ϰ� �͵� 
--      ������ �ƹ��� ���� �μ��� ��ȸ�ϰ� ������ 
--      ���� NULL ���� �ϴ� ���� �ѰŹ��� ��ȸ �Ϸ���
--      (+) �δ� ��ʦ��

--FULL OUTER JOIN ~ ON �����ڷ� ����

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

--����) ������ �ƹ��� ���� �μ��� ��� ��ȸ�ϰ� �ʹ� 
--      dept ���̺��� ���ʿ� ��ġ�ؼ� ������ �Ŵ� ���
--      LEFT OUTER JOIN���� �ذ��ϸ� �ȴ�. 
SELECT d.dname 
     , e.ename
  FROM emp e
     , dept d 
 WHERE d.deptno = e.deptno(+)
;

--5.SELF JOIN 
--   :  �����̺� ������ �ڱ� �ڽ��� �÷����� �����Ͽ� 
--      ������ �� ���� ����� ���  
--   �ϳ��� ���̺��� �Ȱ��� 2���� ����� ���Ͽ� �Ǵ��ϱ� ���� �۾� 

-- ����) emp ���̺� ���� ������ ��ȸ�Ҷ� 
--  �� ������ ���(�Ŵ���)�̸��� ���� ��ȸ�ϰ� �ʹ�.

SELECT e.empno  "���"
     , e.ename  "�̸�"
     , e.mgr    "��� ���"
     , e.ename  "��� �̸�"
  FROM emp e
     , emp e1 
WHERE e.mgr = e1.empno
;
-- ���� ����� SELF-JOIN �̸鼭 EQUI-JOIN�̱� ������ 
-- ��簡 ���� ������ ��ȸ���� �ʴ´� 
-- KING �� ��ȸ���� ���� 

--��簡 ���� ������ ��ȸ�ϰ� ������ 
--a) e���̺� �������� ��� �����Ͱ� ��ȸ�Ǿ�� �� 
--b) (+)��ȣ�� �����ʿ� ���̰Ť��� 
--c) LEFT OUTER JOIN ~ ON�� ���
SELECT e.empno  "���"
     , e.ename  "�̸�"
     , e.mgr    "��� ���"
     , e.ename  "��� �̸�"
  FROM emp e LEFT OUTER JOIN emp e1 ON e.mgr = e1.empno 
;

-- ex) JJ e.mgr(7902) = 7902 e.name(FORD)    

--���������� ���� ������ ��ȸ 
--

SELECT e.empno  "���"
     , e.ename  "�̸�"
     , e.mgr    "��� ���"
     , e1.ename  "��� �̸�"
  FROM emp e
     , emp e1 
 WHERE e.mgr(+) = e1.empno
 ORDER BY "���" DESC
; 

/*
���,     �̸�, ��� ���, ��� �̸�
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


--RIGHT OUTER JOIN ~ ON  ���� ����
SELECT e.empno  "���"
     , e.ename  "�̸�"
     , e.mgr    "��� ���"
     , e1.ename  "��� �̸�"
  FROM emp e RIGHT OUTER JOIN emp e1 ON (e.mgr = e1.empno)
 ORDER BY "���" DESC 
; 


--������ �ǽ� ���� 
-- 1. ���, �̸�, ����, ����̸�, �μ���, �μ���ġ�� ��ȸ�Ͻÿ� 
-- emp e, emp e1, dept d
-- ����̸� ���� �ҷ��� e,e1 ���� WHERE 
-- �μ��̸�,��ġ ���� e,d ���� AND

SELECT e.empno  ���
     , e.ename  �̸�
     , e.job    ����
     , e1.ename ����̸�
     , d.dname  �μ���
     , d.loc    �μ���ġ
  FROM emp e 
     , emp e1 
     , dept d 
 WHERE e.mgr = e1.empno 
   AND e.deptno = d.deptno 
 ORDER BY d.deptno
;


-- 2.���, �̸�, �޿�, �޿����, �μ���, �μ���ġ�� ��ȸ�Ͻÿ� 
-- emp e, dept d, salgrade s
-- �μ��� e,d AND 
-- �޿���� e,s WHERE

SELECT e.empno  ���
     , e.ename  �̸�
     , e.sal    �޿�
     , s.grade  �޿����
     , d.dname  �μ���
     , d.loc    �μ���ġ
  FROM emp e  
     , dept d
     , salgrade s
 WHERE e.sal BETWEEN s.losal AND s.hisal
   AND e.deptno = d.deptno 
; 

--���� ������ JOIN ~ ON���� ���� 

SELECT e.empno  ���
     , e.ename  �̸�
     , e.sal    �޿�
     , s.grade  �޿����
     , d.dname  �μ���
     , d.loc    �μ���ġ
  FROM emp e JOIN  emp e1 ON (e.mgr = e1.empno)
             JOIN  dept d ON (e.deptno = d.deptno)
; 

SELECT e.empno  ���
     , e.ename  �̸�
     , e.sal    �޿�
     , s.grade  �޿����
     , d.dname  �μ���
     , d.loc    �μ���ġ
  FROM emp e JOIN  dept d     ON (e.deptno = d.deptno)
             JOIN  salgrade s ON (e.sal = d.deptno)
; 

-- �μ��� �������� ���� ������ ��� ����Ͻÿ�
-- (+) �����ڷ� �ذ�
 --���, �̸�, �޿�, �޿����, �μ���, �μ���ġ�� ��ȸ�Ͻÿ� 

SELECT e.empno  ���
     , e.ename  �̸�
     , e.sal    �޿�
     , d.dname  �μ���
     , d.loc    �μ���ġ
     , e.deptno �μ�����
  FROM emp e
     , dept d
 WHERE e.deptno  = d.deptno (+)
;

-- LEFT OUTER JOIN ~ ON ���� �ذ�

SELECT e.empno  "���"
     , e.ename  "�̸�"
     , e.sal    "�޿�"
     , d.dname  "�μ���"
     , d.loc    "�μ���ġ"
     , e.deptno "�μ�����"
  FROM emp e LEFT OUTER JOIN dept d ON (e.deptno = d.deptno )
;


-- �μ��� �������� ���� ������ 
-- �μ���, �μ���ġ ��� '-' �� ��µǵ��� �Ͻÿ�.

SELECT e.empno  "���"
     , e.ename  "�̸�"
     , e.sal    "�޿�"
     , d.dname  "�μ���"
     --, d.loc    "�μ���ġ"
     --, e.deptno "�μ�����"
     --, NVL2(e.deptno, e.deptno, 1) �μ����� 
     , NVL2(e.loc, e.loc, 1) �μ���ġ
  FROM emp e LEFT OUTER JOIN dept d ON (e.deptno = d.deptno )
;
