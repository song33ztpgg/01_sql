-- DAY 02 
-- SCOTT ���� EMP ���̺� ��ȸ  
SELECT * 
    FROM emp
; 

-- SCOTT ���� DEPT ���̺� ��ȸ  
SELECT * 
    FROM dept 
; 

--2.DQL : SELECT 
--1)emp ���̺��� jobĮ���� ��ȸ
SELECT job
    FROM EMP  
; 
/*
CLERK,SALESMAN,SALESMAN
MANAGER,SALESMAN,MANAGER
MANAGER,PRESIDENT,SALESMAN
CLERK,ANALYST,CLERK
*/

--2)emp���̺��� �ߺ��� �����Ͽ� jobĮ���� ��ȸ 
SELECT DISTINCT job
    FROM emp
; 
/*
JOB 
------------ 
CLERK
SALESMAN
ANALYST
MANAGER
PRESIDENT 

��job �� �ѹ����� ��ȸ�� ����� ������ �ִ� 
�� ����� ȸ�翡���� �ټ�������job�� ������ Ȯ���Ҽ� �ִ�.

*/ 

SELECT job 
    FROM emp 
    ;