--DAY14 view ��� 

----------------------------------------------------- 
--VIEW : �������θ� �����ϴ� ���� ���̺� 

--1.SYS
CONN sys as
--2.SCOTT ������ VIEW ���� ���� ����  
--(1)������ 
--(2)sys ������ �ٸ� ����� 
--(3)SCOTT���� ������ Ŭ�� 
--(4)����� ����
--(5)�ý��� ���� �� 
--(6)CREATE VIEW ������ �ο��� üũ�ڽ� ���� -> ����
--3.���� ����
GRANT CREATE VIEW TO SCOTT; 
--4.���� SCOTT���� ����
CONN SCOTT/TIGER;
--------------------------------------- 
--1.emp, dept ���̺� ���� 
DROP TABLE new_emp; 
CREATE TABLE new_emp 
AS 
SELECT e.* 
FROM   emp e 
WHERE ;

DROP TABLE new_emp; 
CREATE TABLE new_emp; 
AS 
SELECT d.* 
FROM   dept d 
WHERE 1 = 1  
;
--2.���� ���̺��� pk������ �����Ǿ� �����Ƿ� pk������ ALTER�� �߰� 
/* 
new_dept : PK_NEW_DEPT,deptno �÷��� PRIMARY KEY �� ����
new_emp : PK_NEW_EMP, empno �÷��� PRIMARY KEY�� ����  
          FK_NEW_DEPTNO, deptno Į���� FOREIGN KEY�� ���� 
             new_dept ���̺��� deptno �÷��� REFERENCES �ϵ��� ���� 
          FK_MGR     , mgr�÷��� FOREIGN KEY�� ���� 
             new_emp ���̺��� empno �÷��� REFERENCES �ϵ��� ���� 
*/

--3.���� ���̺��� �⺻ ���̺�� �ϴ� VIEW�� ���� 
-- : ������ �⺻���� + ����� �̸� + �μ��̸� +�μ���ġ ���� ��ȸ������ �� 
;
CREATE OR REPLACE VIEW v_emp_dept
AS 
SELECT e.empno 
     , e.ename 
     , e1.ename as mgr_name 
     , e.deptno 
     , e.dname 
     , d.loc 
 FROM new_emp e 
    , new_dept d 
    , new_emp e1
WHERE e.deptno = d.deptno(+) 
  AND e.mgr = e1.empno(+) 
WITH READ ONLY;




SELECT v.* 
  FROM v_emp_dept v 
;

SELECT v.empno 
     , v.ename 
     , v.dname 
     , v.loc
  FROM v_emp_dept v 
;

--4.VIEW �� �����Ǹ� user_view�� �����ȴ� ,
 SELECT v.vname 
      , v.read_only 
   FROM user_views v 
; 
/* ������ �ִ� ��*/ 

--5. ������ �信�� DQL ��ȸ 
--1)�μ����� SALES �� �μ� �Ҽ� ������ ��ȸ 
--2)�μ����� NULL �� ������ ��ȸ 
--3)���(�Ŵ���,mgr)�� null�� ������ ��ȸ 




