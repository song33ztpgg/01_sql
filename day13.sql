--day13 

--------------------------------------------- 
--����Ŭ�� Ư���� �÷� 2���� 
--����ڰ� �������� ��� �ڵ����� �����Ǵ� �÷� 

--1.ROWID : ���������� ��ũ�� ����� ��ġ�� ����Ű�� ���� 
--          ������ ��ġ�̹Ƿ� �� ��� �ݵ�� ������ ���� �� �ۿ� ���� 
--          ORDER BY ���� ���� ������� �ʴ� ��  

--2.ROWNUM : ��ȸ�� ����� ù��° ����� 1�� �����ϴ� �� 
-------------------------------------------- 

--EX) emp���̺��� SMITH �� ��ȸ  
SELECT e.rowid
     , e.empno 
     , e.ename
  FROM emp e  
 WHERE e.ename = 'SMITH'
; 
--��� : AAAR9ZAAHAAAACWAA/A	7369/	SMITH

--ROWID �� ���� ��ȸ 
SELECT --e.rowid 
       rownum
     , e.empno 
     , e.ename 
  FROM emp e
 WHERE e.ename = 'SMITH'  
;
--��� :1	7369	SMITH

----------------------------------------------------------------------

--ORDER BY ���� ���� ROWNUM�� ����Ǵ� ��� Ȯ�� ��
SELECT rownum
     , e.empno 
     , e.ename 
  FROM emp e
 ORDER BY e.ename  
;

/*
1	7369	SMITH
2	7499	ALLEN
3	7521	WARD
4	7566	JONES
5	7654	MARTIN
6	7698	BLAKE
7	7782	CLARK
8	7839	KING
9	7844	TURNER
10	7900	JAMES
11	7902	FORD
12	7934	MILLER
13	7777	JJ
14	8888	J_JAMES
*/ 


-- ROWNUM�� ORDER BY����� ������ ���� �ʴ� ��ó�� ���� �� ���� 
-- SUB-QUERY �� ����Ҷ� ������ ���� 

SELECT rownum 
     , a.empno 
     , a.ename 
     , a.numrow
FROM ( SELECT rownum as numrow
            , e.empno 
            , e.ename 
         FROM emp e
        ORDER BY e.ename) a
;

/*
ROWNUM, EMPNO, ENAME, NUMROW 
--------------------------------
1	    7499	ALLEN	 2
2	    7698	BLAKE	 6
3	    7782	CLARK	 7
4	    7902	FORD	 11
5	    7900	JAMES	 10
6	    7777	JJ	     13
7	    7566	JONES	 4
8	    8888	J_JAMES	 14
9	    7839	KING	 8
10	    7654	MARTIN	 5
11	    7934	MILLER	 12
12	    7369	SMITH	 1
13	    7844	TURNER	 9
14	    7521	WARD	 3
*/


--�̸��� A�� ���� ������� ��ȸ  
SELECT ROWNUM
     , e.ename 
  FROM emp e
 WHERE e.ename LIKE '%A%' 
;
/* 
ROWNUM, ENAME 
-----------------
1	    ALLEN
2	    WARD
3	    MARTIN
4	    BLAKE
5	    CLARK
6	    JAMES
7	    J_JAMES
*/ 

--�̸��� A�� ���� ������� �̸� 
SELECT SELECT rownum 
     , a.empno 
     , a.ename 
     , a.numrow
  FROM (SELECT ROWNUM
             , e.ename 
          FROM emp e
         WHERE e.ename LIKE '%A%') 
; 

SELECT ROWNUM 
     , e.rowid 
     , e.ename 
 FROM emp e 
WHERE e.ename LIKE '%S%' 
ORDER BY e.ename 
;  


SELECT ROWNUM 
     , a.rowid 
     , a.ename
  FROM (SELECT e.rowid 
             , e.ename 
          FROM emp e 
         WHERE e.ename LIKE '%S%' 
         ORDER BY e.ename ) a
;

/* 
ROWNUM,     ROWID,      ENAME 
--------------------------------
1	AAAR9ZAAHAAAACWAAJ	JAMES
2	AAAR9ZAAHAAAACWAAD	JONES
3	AAAR9ZAAHAAAACXAAB	J_JAMES
4	AAAR9ZAAHAAAACWAAA	SMITH
*/ 

--ROWNUM ���� �� �� �ִ� ���� 
--emp ���� �޿��� ���� �޴� ���� 5���� ��ȸ �Ͻÿ� 
--�ذ��1. �޿��� ���� ���� ���� 
SELECT e.empno 
     , e.ename 
     , e.sal
  FROM emp e 
ORDER BY e.sal DESC 
;
--�ذ��2. 1�� �����SUB_QUERY ��  FROM ���� ����Ͽ�  ROWNUM �� ���� ��ȸ  
SELECT ROWNUM 
     , a.*
  FROM (SELECT e.empno 
             , e.ename 
             , e.sal
          FROM emp e 
         ORDER BY e.sal DESC ) a 
;

--�ذ��3. 
SELECT ROWNUM 
     , a.*
  FROM (SELECT e.empno 
             , e.ename 
             , e.sal
          FROM emp e 
         ORDER BY e.sal DESC ) a 
WHERE ROWNUM <=5
;
/*
1	7839	KING	5000
2	7902	FORD	3000
3	7566	JONES	2975
4	7698	BLAKE	2850
5	7782	CLARK	2450
*/
 
 
--���ڵ� : ����, ��¥, ���� �� ���� �ٸ� ������ ���� �۾��� ���ڵ��� �θ���. 
--ex) �޸��� ���  : ȫ�浿 9.99�� ���� �ø���  

----------------------- 
--DML : ������ ���۾�
----------------------
DROP TABLE member;

CREATE TABLE member 
( member_id    VARCHAR2(4)   
 ,member_name  VARCHAR2(15)     NOT NULL 
 ,phone        VARCHAR2(4)      --NULL ���(�������� ���X)
 ,reg_date     DATE             DEFAULT sysdate 
 ,address      VARCHAR2(30) 
 ,major        VARCHAR2(50)
 ,birth_month  NUMBER(2) 
 ,gender       VARCHAR2(1)    
 ,CONSTRAINT   pk_member         PRIMARY KEY      (member_id) 
 ,CONSTRAINT   ck_member_gender  CHECK (gender IN ('F','M'))
 ,CONSTRAINT   CK_BIRTH          CHECK (birth_month BETWEEN 1 AND 12)
 );

--1.INTO ������ �÷��̸� ������ ������ �߰� 
--  VALUES ���� �ݵ�� ��ü �÷��� �����͸� ������� ��� ����  
INSERT INTO MEMBER VALUES ('M001', '�ڼ���', '9155', sysdate , '������', '����', 3, 'M');
INSERT INTO MEMBER VALUES ('M002', '������', '1418', sysdate , '������',  NULL, NULL, 'M');
INSERT INTO MEMBER VALUES ('M003', '�̺���', '0186', sysdate ,    NULL ,  NULL, 3, 'M');
INSERT INTO MEMBER VALUES ('M004', '�蹮��',   NULL, sysdate , 'û�ֽ�', '�Ͼ�', 3, 'F');
INSERT INTO MEMBER VALUES ('M005', '����ȯ', '0322', sysdate , '�Ⱦ��', '����', 3, NULL);
COMMIT;

--���� �߻��ϴ� ���� 3���� 

--1.�÷��� ������ ������ ������ �ٸ����
INSERT INTO MEMBER VALUES ('M005', '0322', sysdate , '�Ⱦ��', '����'); 
COMMIT ;  
/*
�䱸�ϴ� �÷��� ������ 8���δ� �Է°��� 5������ 
��ġ���� �ʾ� ������ ���� ����
*/

--2.�÷��� 1~12 ���� ���ڰ� �Է½õ� 
INSERT INTO MEMBER VALUES ('M005', '��', '0001', sysdate , '������', '����', 3, 'M'); 
/*M005(PK) �̹� �����Ͽ��� 
(���Ἲ ���� ����(SCOTT.PK_MEMBER)�� ����˴ϴ�) 
��� ����� ��� �ȴ� 
*/


--3.GENDER �÷��� 'F','M'�̿��� ���� ���� �� 
INSERT INTO MEMBER VALUES ('M006', '��', '0001', sysdate , '������', '����', 3, 'G');  
INSERT INTO MEMBER VALUES ('M006', '��', '0001', sysdate , '������', '����', 0, 'M');  
/* 
üũ ��������(SCOTT.CK_MEMBER_GENDER)�� ����Ǿ����ϴ� 
*/ 

--4.MEMBER NAME�� NULL�Է½õ� 
INSERT INTO MEMBER VALUES ('M006', NULL, '0001', sysdate , '������', '����', 0, 'M');  
/*
NULL�� ("SCOTT"."MEMBER"."MEMBER_NAME") �ȿ� ������ �� �����ϴ�
*/ 

--------------------------------------------------------INSERT INTO MEMBER VALUES ('M006', 'Ȧ�浿', '0001', sysdate , '�Ⱦ��', '����', 3, 'M');


----- 2.INTO ���� �÷� �̸��� ����� ����� ������ �߰� 
--       VALUES ���� INTO�� ������� ���� Ÿ��, ������ ���߾ �ۼ� 
INSERT INTO MEMBER (member_id, member_name) 
VALUES ('M007','������');
COMMIT; 

INSERT INTO MEMBER (member_id, member_name,gender) 
VALUES('M008','������','M');
COMMIT; 

--���̺� ���� ������ ������� INTO���� �÷��� ������ �� �ִ�.
INSERT INTO MEMBER (birth_month, member_name, member_id) 
VALUES(7,'������','M009');
COMMIT; 

--INTO���� �÷� ������ VALUES ���� ���� ���� ����ġ  
INSERT INTO MEMBER (member_id, member_name, birth_month ) 
VALUES('M010','������', 'M', '����');
COMMIT;  
/* ��� : ���� ���� �ʹ� �����ϴ� */

INSERT INTO MEMBER (member_id, member_name, birth_month ) 
VALUES('M010');
COMMIT;  
/*���  : ���� ���� ������� �ʽ��ϴ�*/

--INTO ���� VALUES ���� ������ ������ ���� Ÿ���� ��ġ ���� ���� �� 
INSERT INTO MEMBER (member_id, member_name, birth_month) 
VALUES('M010', '���', '�Ѿ�');
COMMIT;  
/*��� : ��ġ�� �������մϴ�*/ 

INSERT INTO MEMBER (adress, reg_date) 
VALUES( 7, '2019-07-02');
COMMIT;   
/* �˾Ƽ� ��ȯ�� �Ǵ� �۾���*/ 

--�ʼ� �Է� �÷��� �������� ������ 
INSERT INTO MEMBER (birth_month, address , gender)  
VALUES( 12, '������' ,'�Ѿ�');
COMMIT;    
/* NULL�� ("SCOTT"."MEMBER"."MEMBER_ID") �ȿ� ������ �� �����ϴ� */


------------------------------------- 

--������ �Է� : SUB-QUERY�� ����Ͽ� ���� 

--��������  
INSERT INTO ���̺��̸�
SELECT ����; -- �������� 
/*
--���� ���� �����͸� �����ϸ鼭 �� ���̺� ���� 
CREATE TABLE ���̺� �̸�
AS 
SELECT  

--�̹� ������� ���̺� �����͸� �����ؼ� �߰�  
INSERT INTO ���̺� �̸� 
SELECT ���� 
*/ 

--new_member ���� 
DROP TABLE new_member;  

--member �����ؼ� ���̺� ���� 
CREATE TABLE new_member 
AS 
SELECT m.* 
  FROM member m 
 WHERE 1=2 
;  
 
INSERT INTO new_member 
SELECT m.*
 FROM member m 
WHERE m.member_name LIKE '_��_' 
; 

--�÷��� ����� ������ �Է� 
INSERT INTO new_member(member_id, member_name, phone) 
SELECT  m.member_id 
     , m.member_name
     , m.phone
  FROM member m 
  WHERE m.member_id <'M004' 
; 
COMMIT; 

--new_member �� �߰��� �� ��� ����
DELETE new_member; 
COMMIT;
 
--��� �������� ���� 
UPDATE "SCOTT"."MEMBER" 
SET BIRTH_MONTH = '1' 
WHERE MEMBER_ID ='M007'
; 
UPDATE "SCOTT"."MEMBER" 
SET BIRTH_MONTH = '2' 
WHERE MEMBER_ID ='M008'
; 

--����) new_member ���̺� 
-- member ���̺�κ��� �����͸� �����Ͽ� �������� �Է��Ͻÿ�
-- ��, member ���̺� �����Ϳ��� birth_month �� 
-- Ȧ������ ����鸸 ��ȸ�Ͽ� �Է��Ͻÿ� 
INSERT INTO new_member 
SELECT m.* 
  FROM member m 
WHERE mod(m.birth_month, 2) = 1 
; 
COMMIT; 
-------------------------------------------------- 

--���ڵ� ���� 
--���̺� ����� ������ �����ϴ� �۾� 


--2) UPDATE : ���̺��� ��(���ڵ�)�� ���� 
--            WHERE �������� ���տ� ���� 
--            1�ุ �����ϰų� ���� �� ������ ���� 
--            ���� ���� �����Ǵ� ���� �ſ� ���ǰ� �ʿ�!! 

--����  
/*
UPDATE ���̺� �̸� 
   SET �÷�1 = ��1 
    [,  �÷�2 = ��2]  
[WHERE ����]
*/
--EX) ȫ�浿�� �̸��� �����õ� 
UPDATE member m  --update������ ���⼭ ��Ī �Ѵ�. 
   SET m.member_name = '�浿��' 
 WHERE m.member_id = 'M006' 
;  


UPDATE member m 
   SET m.phone = '1392' 
 WHERE m.member_id = 'M004' 
;
COMMIT; 


--ex) ������(M009)������ ���� 
UPDATE member m
   SET m.major = '������'; 
/*
 ��� : ��� major ���� �������� �Ǿ������. 
*/ 

--COMMIT ���� �۾����� �ǵ����� �۾� ��� ROLLBACK;
ROLLBACK;


UPDATE member m
   SET m.major = '������'
 WHERE m.member_id = 'M009'; 
COMMIT;


------------------------------- 
-- ���� �÷� ������Ʈ(2�� �̻��� �÷��� �ѹ��� ������Ʈ) 
-- EX) M008 �ɹ��� ��ȭ��ȣ, �ּ� ,������ �ѹ��� ������Ʈ 

UPDATE member m 
   SET m.phone = '4119' 
     , m.address = '�ƻ��'
     , m.major = '�Ͼ�'
 WHERE m.member_id = 'M008' 
 ; 
 
 --EX) �ƾ�� ���� ��� ����ȯ �ɹ��� GENDER ���� ���� 
 --    WHERE ���ǿ� �ּҸ� ���ϴ� ������ ���� ��� 
 
UPDATE member m
   SET m.gender = 'M' 
 WHERE m.address = '�Ⱦ��' 
 ; 
 /*
 ������ ������ �Ⱦ�ð� ������ ���� �ƴϿ��� ������ 
 ������ �����ϴ� ������� �ɼ��� �ִ� 
 
 PK�� ������ ���� NOT NULL�� ����Ǵ� �÷��̱� ������ 
 �����ϱ� �����ϴ�
 */
 
 --UPDATE ������ SELECT ���������� ��� 
 --EX) M002 �ڷ��� major ����  M008 �ɹ� major�� ����  
 
 
--1) M008 �ڷ� ���Ѵ� 
SELECT m.major
  FROM member m 
 WHERE m.member_id = 'M008'
;  
--2) M002 �ڷḦ ���Ѵ�. 
SELECT m.major
  FROM member m = ?
 WHERE m.member_id = 'M002'
;  

--3) 1,2 ����� UPDATE ������ ���� 
UPDATE member m 
   SET m.major = ( SELECT m.major
                     FROM member m
                    WHERE m.member_id = 'M008') 
 WHERE m.member_id = 'M002' 
 ; 
 COMMIT;
 
 
 --------------------------------------------------------
 
 --���� SET ���� ����ϴ� ���������� ����� ��Ȯ�ϰ� 1��1���� 1���� ����
 --�ƴѰ�� ���� ���� 
 
UPDATE member m 
   SET m.major = ( SELECT m.major
                     FROM member m) 
 WHERE m.member_id = 'M002' 
 ; 
 /* ���� �� ���� ���ǿ� 2�� �̻��� ���� ���ϵǾ����ϴ�. */
 
 UPDATE member m 
    SET m.major = ( SELECT m.member_if
                         , m.major
                     FROM member m 
                     WHERE m.member_id = 'M008') 
 WHERE m.member_id = 'M002' 
 ; 
/* ���� ���� �ʹ� �����ϴ� */

--UPDATE �� �������� �����ϴ� ��� 
--EX)M001�� member_id ������ �õ� 
-- : PK �÷����� �ߺ� ���� �����ϴ� ��� 
UPDATE member m
   SET m.member_id = 'M002' 
 WHERE m.member_id = 'M001'
;  
/*���Ἲ ���� ����(SCOTT.PK_MEMBER)�� ����˴ϴ� */

--EX) NOT NULL �� number_name �� NULL �����ͷ� ������Ʈ �õ��ϴ� ���
UPDATE member m
   SET m.member_id =  NULL 
 WHERE m.member_id = 'M001'
;  

/* NULL�� ("SCOTT"."MEMBER"."MEMBER_ID")�� ������Ʈ�� �� �����ϴ� */


--EX) M001 ������ ���ؼ� bitrh_month �� -1�� �����ð� 
UPDATE member m
   SET m.birth_month =  -1 
 WHERE m.member_id = 'M001'
;  
/* üũ ��������(SCOTT.CK_BIRTH)�� ����Ǿ����ϴ� */

------------------------------------------------ 
--������ �ǽ�
--1.PHONE �÷��� NULL�� ����� ��� 0000 ���� ������Ʈ 
-- PK�� �ʿ䰡 ����. 
UPDATE member m 
   SET m.phone = '0000'  
 WHERE m.phone IS NULL
;
COMMIT;


--2.M001 �ɹ��� ������ NULL ������ ������Ʈ 
-- PK���  
UPDATE member m 
   SET m.major = NULL  
 WHERE m.member_id = 'M001'
;

--3.ADDRESS �÷��� NULL�� ����� 
--�ϰ������� '�ƻ��'�� ������Ʈ
UPDATE member m 
   SET m.address = '�ƻ��'  
 WHERE m.address IS NULL
; 
ROLLBACK;

--4.MOO9 �ɹ��� NULL�����͸� 
-- PHONE : 3581 , ADDRESS : õ�Ƚ�, GENDER : M
UPDATE member m 
   SET m.phone = 3581
     , m.address = 'õ�Ƚ�'
     , m.gender = 'M' 
 WHERE m.member_id = 'M009' 
;









