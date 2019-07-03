--day 12 : DDL (Date definition Language) 
--              ������ ���Ǿ� 
-- 1.���̺��� �����ϴ� ��ɾ� -> ���̺��� DBMS�� OBJECT�� �ϳ� 
-- 2.DBMS�� OBJECT(��ü)�� ����/�ν� �ϴ� �����  
-- ���� , ���� , ���� �ϴ� ��ɾ�  

-- ���� : CREATE 
-- ���� : ALTER 
-- ���� : DROP 

-- vs.DML (date Manipulation Language) ������ ���۾� 
-- ���� : INSERT 
-- ���� : UPDATE 
-- ���� : DELETE

----------------------------------------------------------

/*
DDL ������ ���� 

CREATE | ALTER | DROP {������ ��ü�� Ÿ�Ը�}

DBMS�� OBJECT(��ü)�� ���� 
SHEMA, DOMAIN, TABLE, VIEW, INDEX, SEQUENCE, USERM DATABASE 

EX) CREATE SHEMA  
EX) CREATE TABLE ���̺� �̸� 
( �Ӽ��̸� ������ Ÿ�� [NOT NULL],...,  

EX)CREATE TABLE 
(empno
  

��Ÿ(META) : ������ ���� ���� (EMP TABEL�� ~~~ �� �����̴�) 


DATE_TYPE ( ������ ũ��,�Ҽ��� �ڸ�)
*/ 

--  CREATE TABLE ���� ����
CREATE TABLE ���̺��̸� 
( �÷�1�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]
 ,[�÷�2�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]]
 ....
 ,[�÷�n�̸� ������Ÿ��[(����)] [DEFAULT �⺻��] [�÷��� �������]]
);

/*
�÷��� ������� 
1.PRIMARY KEY : �� �÷��� �ԷµǴ� ���� �ߺ����� �ʰ� 
                �� ���� �ĺ��� �� �ִ� ������ �����ؾ� �ϸ� 
                NULL ������ �Է��� �Ұ����� ���̾�� �Ѵ�.

2.FOREIGN KEY : �ַ� JOIN�� ��뤧�ϴ� ������������
                �ٸ� ���Ը��� PRIMARY KEY�� ���Ǿ��� ����
                �����ؾ߸� �Ѵ�.

3.UNIQUE      : �� �÷��� �ԷµǴ� ���� �ߺ����� ������ ���� �ؾ��Ѵ� 
                NULL ������ �Է��� �����ϴ�. 
                =>�����Ͱ� NULL(���ų�) �̰ų� 
                NULL�� �ƴϸ� �ݵ�� ������ ���̾�� ��.

4.NOT NULL    : �� �÷��� �ԷµǴ� ���� �ߺ��� ���������
                NULL���´� ���� �ʵ��� �����Ѵ�. 
                
==>PK : UNIQUE + NOT NULL ���յ� ���¶�� ���� �� �� �ִ�.
*/

--��) û���� ���� �����ο� ������ ������ ���̺� ���� 
/*
 ���̺� �̸�          : number        
 1.��� ���̵�        : member_id     :���� : VARCHAR2
 2.�ɹ� �̸�          : member_name   :���� : VARCHAR2 
 3.��ȭ��ȣ ���ڸ�    : phone         :���� : VARCHAR2
 4.�ý��۵����       : reg_date      :��¥ : DATE
 5.��� ��(���̸�)    :address        :���� : VARCHAR2
 6.�����ϴ� ����      :  like_number  :���� : NUMBER
 7.����               : major         :���� : VARCHAR2
*/
------------------------------------------------------------------------

--1.���̺� ���� ���� : number  
CREATE TABLE member 
( member_id    VARCHAR2(4)      PRIMARY KEY
 ,member_name  VARCHAR2(15)     NOT NULL 
 ,phone        VARCHAR2(4)      --NULL ���(�������� ���X)
 ,reg_date     DATE             DEFAULT sysdate 
 ,address      VARCHAR2(30) 
 ,like_number  NUMBER 
 ,major        VARCHAR2(50)  
);

--2.���̺� ���� ���� 
DROP TABLE member;

--3.���̺� ���� ���� 
/*
������ ���� 
1. �÷��� �߰� : ADO
2. �÷��� ���� : MODIFY
3. �÷��� ���� : DROP COLUMN 

*/ 

ALTER TABLE ���̺��̸� { ADD | MODIFY | DROP COLUMN} ... ; 
--��) ������ member ���̺� �÷� 2���� �߰� 
--��� �� : birth_month : NUMBER 
--����    : gender      : VARCHAR2(1) : F, M �ΰ����� �Է� ���� 

--1) ADD 
-- member ���̺� ���� �� �Ʒ� ���� ����
ALTER TABLE member ADD 
( birth_month NUMBER 
 ,gender      VARCHAR2(1) CHECK (gender IN ('F','M'))
 
);
----------------------------------------------------------------  

--2) MODIFY 
-- ��)��� �� �÷��� ����2�ڸ������� �����ϵ��� ���� 
ALTER TABLE ���̺��̸� MODIFY �÷��̸� ������Ÿ��(ũ��); 
ALTER TABLE member MODIFY  birth_month NUMBER(2); 

--3)DROP COLUMN 
--��) ������ ���̺� member���� like_number �÷��� ���� 
ALTER TABLE ���̺��̸� DROP COLUMN �÷��̸�; 
ALTER TABLE member DROP COLUMN like_number; 

------------------------------------------------------------------- 
CREATE TABLE member 
( member_id    VARCHAR2(4)      PRIMARY KEY
 ,member_name  VARCHAR2(15)     NOT NULL 
 ,phone        VARCHAR2(4)      --NULL ���(�������� ���X)
 ,reg_date     DATE             DEFAULT sysdate 
 ,address      VARCHAR2(30) 
 ,major        VARCHAR2(50)
 ,birth_month  NUMBER(2) 
 ,gender       VARCHAR2(1)      CHECK (gender IN ('F','M'))
 
);
-- ���� �ܼ�ȭ�� ���̺� ���� ���� 
-- ���� ����(constraint)�� �� �÷��ڿ� �ٷ� �������� �̸� ���� ����
-- �������ǿ� �̸��� �ο��ؼ� ���� : 
-- �÷��� ���ǰ� ���� �� �������� ���Ǹ� ���Ƽ� �ۼ� 


--���̺� ����  
DROP TABLE member; 
--���� ���� �̸� �ش�
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
--CONSTRAINT ���������̸� �������� Ÿ��(�������� ������ �÷�)
);


--���̺� ������ DDL�� ������ ������ �ý��� īŻ�α׿� �����. 
-- user_tables, user_constraints �ΰ��� �ý��� īŻ�α� ���̺��� ��ȸ 

-- 1) �� ���̺��� ����(�÷� �̸�) ��ȸ 
DESC user_tables; 
DESC user_constraints; 
/*
�̸�                        ��?       ����             
------------------------- -------- -------------- 
TABLE_NAME                NOT NULL VARCHAR2(128)  
*/


SELECT t.table_name
  FROM user_tables t 
;

/*
TABLE_NAME 
-------
DEPT
EMP
BONUS
SALGRADE
MEMBER
*/

-- ���� ����(scott)�� ������ �ִ� ���� ���� ��ȸ 
SELECT c.constraint_name
     , c.constraint_type 
     , c.table_name
  FROM user_constraints c 
;
/*
FK_DEPTNO	        R	EMP
PK_DEPT	            P	DEPT
PK_EMP	            P	EMP
CK_MEMBER_GENDER	C	MEMBER
PK_MEMBER	        P	MEMBER
*/

--MEMBER ���̺��� �������ŰǸ� Ȯ�� 
SELECT c.constraint_name
     , c.constraint_type 
     , c.table_name
  FROM user_constraints c 
 WHERE c.table_name = 'MEMBER'
;

/*
CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME 
------------------------------------------------
SYS_C007681     	C	            MEMBER
CK_MEMBER_GENDER	C	            MEMBER
PK_MEMBER	        P	            MEMBER
*/ 

--user_object : ���� ����ڰ� ������ �ִ� object���� ������ ����Ǵ� 
--              �ý��� īŻ�α� ���̺�

DESC user_objects;


SELECT o.object_name 
     , o.object_id 
     , o.object_type 
  FROM user_objects o 
;

/*
DEPT	    73559	TABLE
PK_DEPT	    73560	INDEX
EMP	        73561	TABLE
PK_EMP	    73562	INDEX
BONUS	    73563	TABLE
SALGRADE	73564	TABLE
PK_MEMBER	74700	INDEX
MEMBER	    74699	TABLE
*/

-- ���̺� ���� ����� �̹� �����ϴ� ���̺�� ���� ���� ����
-- ���̺� ���� ���� ���� ���� 
CREATE TABLE ���̺� �̸� 
AS 
SELECT �÷��̸� 
  FROM ���������̺� 
 WHERE �׻� ������ �Ǵ� ���� 
 ; 
 
 --ex) �ռ� ������ member���̺��� ���� : new_member 
CREATE TABLE new_member
AS
SELECT m.* 
  FROM memeber m 
 WHERE 1 = 2  --�׻� ������ �Ǵ� ����
;
--PK������ ������� �ʰ� ���̺� ����(��ȸ�� �÷��� �����)

--------------~~~~~~~~~~~~~~~~
--------------~~~~~~~~~~~~~~~~
--------------~~~~~~~~~~~~~~~~
--------------~~~~~~~~~~~~~~~~



INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M001', '�ڼ���', '9155', '������', '����', '3', 'M')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M002', '������', '1418', '������', '�Ͼ�', '1', 'M')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M003', '�̺���', '0186', 'õ�Ƚ�', '�İ�', '3', 'M')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M004', '�蹮��', '1392', 'û�ֽ�', '�Ͼ�', '3', 'F')
INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M005', '����ȯ', '0322', '�Ⱦ��', '����', '3', 'M')
COMMIT;
--Ŀ�� ����



--3D������ ������ �����ؼ� �� ���̺��� ����

CREATE TABLE march_member 
AS 
SELECT  m.* 
  FROM member m 
 WHERE  m.birth_month = 3 
; 
--�����Ͽ� ���̺� ������ ���� �� �� �ִ� ������ �ָ� 
--�ش� ������ �����ϴ� ���� �����ͱ��� ����Ǹ鼭 ���̺� ����
--�׻� ���� �Ǵ� ������ �ָ� ��� �����͸� �����ϸ鼭 ���̺� ���� 

CREATE TABLE full_member 
AS 
SELECT  m.* 
  FROM member m 
 WHERE  1 = 1 
;  


--full_member ���� 
DROP TABLE full_member; 
CREATE TABLE full_member
AS 
SELECT m.* 
  FROM member m 
-- WHERE �������� �����ϸ� 
-- �׻� ���� ����� �����ϹǷ� ��� �����Ͱ� ����Ǹ� �� ���̺� ����
;





---------------------------------------------------- 
--���̺� ����(ALTER) ���ǻ��� 
--1) �÷��� ���� �� : ��� ���濡 �����ο� 
--                   ������ Ÿ�Ժ���, ������ ũ�� ���濡 �����ο�

--2) �÷��� �����Ͱ� ���� �� 
--   : �����Ͱ� �ҽǵǸ� �ȵǹǷ� ���濡 ������ ����
--     Ÿ�� ������ ���� Ÿ�Գ������� ����  
--     ���� Ÿ�԰��� CHAR -> VARCHAR2 ���氡�� 
--     ũ�� ������ ���� Ȥ�� Ŀ���� �������θ� ����  
--     ���� Ÿ���� ũ�⺯���� ���е��� Ŀ���� �������θ� ����

--3) �⺻��(DEFAULT)������ ���� ���� ������ ����� 
--ex) 3�� ���� �ɹ��� ������ MARCH_MEMBER ���̺��� �����غ��� 
--    : BIRTH_MONTH �÷��� ���� �׻� 3���� �����Ǿ �� �� ����. 

--a)  
--MARCH_MEMBER ���̺� 
--BIRTH_MONTH �÷��� ���� ���� ��� ���� 1�� �߰�

INSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, PHONE, ADDRESS, MAJOR, BIRTH_MONTH, GENDER) VALUES ('M006', '�Կ���', '0437', '������', '�İ�', 'F');

--b) a�� �ɹ� ���� �߰� �� DEFAULY �߰� 
ALTER TABLE march_member MODIFY (BIRTH_MONTH DEFAULT 3);
--Table MARCH_MEMBER 

--c) MARCH_MEMBER ���̺�
NSERT INTO "SCOTT"."MEMBER" (MEMBER_ID, MEMBER_NAME, ADDRESS, MAJOR, GENDER) VALUES ('M007', 'ȫ�浿', '������', '����', 'M');
COMMIT;



---------------- 
--2) �÷��� �����Ͱ� ���� �� 

--ex) MARCH_MEMBER ���̺��� BIRTH_MONTH �÷���
--    ������ Ÿ���� ũ�⸦ NUMBER(1) �� ���̸� 

ALTER TABLE MARCH_MEMBER  MODIFY (BIRTH_MONTH  NUMBER(1)); 
--��� : ORA-01440: ���� �Ǵ� �ڸ����� ����� ���� ��� �־�� �մϴ�

-- ���� �������� ���е��� �����ϴ� ������ �����ϸ� 
-- 2 -> 10�ڸ� ���� �Ҽ��� 2�ڸ�
ALTER TABLE MARCH_MEMBER  MODIFY (BIRTH_MONTH  NUMBER(10,2)); 
--��� : ����Ϸ� 
-------------------------------------- 
--3)���� �������� BIRTH_MONTH �÷��� ���� �����ͷ� ���� 
ALTER TABLE MARCH_MEMBER  MODIFY (BIRTH_MONTH  VARCHAR(1)); 
--���: ������ ������ ������ ���� ��� �־�� �մϴ� 

--MARCH_MEMBER ���̺��� ��� �࿡ ���ؼ� 
--BIRTH_MONTH �÷��� ���� NULL �����ͷ� �����ϴ� ���
UPDATE "SCOTT"."MARCH_MEMBER" 
   SET BIRTH_MONTH = '' 
; 
COMMIT; 

--�����Ͱ� ���� �÷����� ���� �� 
--VARCHAR2(2) �����÷����� ���� 
ALTER TABLE MARCH_MEMBER MODIFY (BIRTH_MONTH VARCHAR2(2)); 
MODIFY (BIRTH_MONTH NUMBER(1);                ------�ڡڡڡڡڡڡ� ���� ������

--NUMBER(1) ���� 1�ڸ� �÷����� ����



-------------------------------------------------------------------------------- 

--������ ���Ἲ ���� ���� ó����� 4���� 
/*
MAIN_TABLE
-------------------------------
ID       VARCHAR2(10)  PRIMARY KEY 
NICKNAME VARCHAR2(10)  UNIQUE
REG_DATE DATE          DEFAULT SYSDATE 
GENGER   VARCHAR2(1)   CHECK (GENDER IN ('M', 'F')) 
MESSAGE  VARCHAR2(300) 


SUB_TABLE 
-----------------------------------------
ID         VARCHAR2(10)    REFERENCES MAIN_TABLE(10) 
                          (FK FROM MAIN_TABLE.ID) 
HOBBY      VARCHAR2(200) 
BIRTH_YEAR NUMBER(4)
*/

--1.�÷������Ҷ� , ���� ���� �̸� ���� �ٷ� ����
DROP TABLE MAIN_TABLE1;                    
CREATE TABLE MAIN_TABLE1
(    ID       VARCHAR2(10)  PRIMARY KEY 
  ,  NICKNAME VARCHAR2(30)  UNIQUE
  ,  REG_DATE DATE          DEFAULT SYSDATE 
  ,  GENDER   VARCHAR2(1)   CHECK (GENDER IN ('M', 'F')) 
  ,  MESSAGE  VARCHAR2(300) 
); 

DROP TABLE SUB_TABLE1; 
CREATE TABLE SUB_TABLE1 
(  ID         VARCHAR2(10) REFERENCES MAIN_TABLE1(ID) 
 , HOBBY      VARCHAR2(200)  
 , BIREH_YEAR NUMBER(4)
); 


--2.�÷� ���� �� ��,���� ���� �̸��� �ָ� ���� 
DROP TABLE MAIN_TABLE2;                    -------������ ���� ������ ������ ���� ������
CREATE TABLE MAIN_TABLE2 
(    ID       VARCHAR2(10)  CONSTRAINT PK_MAIN     PRIMARY KEY 
  ,  NICKNAME VARCHAR2(30)  CONSTRAINT UQ_NICKNAME UNIQUE
  ,  REG_DATE DATE          DEFAULT    SYSDATE 
  ,  GENDER   VARCHAR2(1)   CONSTRAINT CK_GENDER CHECK (GENDER IN ('M', 'F')) 
  ,  MESSAGE  VARCHAR2(300) 
); 

DROP TABLE SUB_TABLE2; 
CREATE TABLE SUB_TABLE2 
(  ID         VARCHAR2(10)  CONSTRAINT FK_SUB REFERENCES MAIN_TABLE2(ID) 
 , HOBBY      VARCHAR2(200)  
 , BIREH_YEAR NUMBER(4)
); 

--3. �÷� ���� �� ����

DROP TABLE MAIN_TABLE3;                    -------������ ���� ������ ������ ���� ������
CREATE TABLE MAIN_TABLE3 
(    ID       VARCHAR2(10)   
  ,  NICKNAME VARCHAR2(30)  
  ,  REG_DATE DATE               DEFAULT SYSDATE 
  ,  GENDER   VARCHAR2(1)   
  ,  MESSAGE  VARCHAR2(300) 
  ,  CONSTRAINT PK_MAIN3         PRIMARY KEY (ID) 
  ,  CONSTRAINT UQ_NICKNAME3     UNIQUE (NICKNAME) 
  ,  CONSTRAINT CK_GENDER3       CHECK (GENDER IN  ('M', 'F')) 
); 

DROP TABLE SUB_TABLE3; 
CREATE TABLE SUB_TABLE3 
(  ID         VARCHAR2(10)  
 , HOBBY      VARCHAR2(200)  
 , BIRTH_YEAR NUMBER(4)
 , CONSTRAINT FK_SUB3 FOREIGN KEY (ID) REFERENCES MAIN_TABLE3(ID) 
-- SUB_TABLE3�� ��� PRIMARY KEY�� ID, BIRTH_YEAR�� ����Ű�� ���� 
-- ����Ű�� PK�� �������� ���� �ݵ�� �������� �߰��θ� ��������
 , CONSTRAINT PK_SUB3 PRIMARY KEY (ID , BIRTH_YEAR) 
); 


--4.���̺� ���� �� ���̺� ����(ALTER TABLE)�� �������� �߰�  
DROP TABLE MAIN_TABLE4; 

--4.1 MAIN TABLE4 ���� �κ� 
CREATE TABLE MAIN_TABLE4 
(    ID       VARCHAR2(10)   
  ,  NICKNAME VARCHAR2(30)  
  ,  REG_DATE DATE               DEFAULT SYSDATE 
  ,  GENDER   VARCHAR2(1)   
  ,  MESSAGE  VARCHAR2(300) 
  
);

--4.2 �������� �߰� ����  
ALTER TABLE MAIN_TABLE4 ADD 
(
     CONSTRAINT PK_MAIN4         PRIMARY KEY (ID) 
  ,  CONSTRAINT UQ_NICKNAME4     UNIQUE (NICKNAME) 
  ,  CONSTRAINT CK_GENDER4       CHECK  (GENDER IN  ('M', 'F')) 
);


DROP TABLE SUB_TABLE4;
--4.3 SUB_TABLE4 ���� 
CREATE TABLE SUB_TABLE4 
(  ID         VARCHAR2(10)  
 , HOBBY      VARCHAR2(200)  
 , BIRTH_YEAR NUMBER(4)
); 

--4.4 SUB_TALBE4 ����
ALTER TABLE SUB_TABLE4 ADD 
(  CONSTRAINT FK_SUB4 FOREIGN KEY (ID) REFERENCES MAIN_TABLE4(ID) 
 , CONSTRAINT PK_SUB4 PRIMARY KEY (ID , BIRTH_YEAR) 
);


--�ý��� īŻ�α� : user_constraints ���� 
--������ ���� ���� Ȯ�� 


SELECT c.table_name 
     , c.constraint_name 
     , c.constraint_type 
  FROM user_constraints c 
 WHERE c.table_name LIKE 'MAIN_TABLE%' 
    OR c.table_name LIKE 'SUB_TABLE%' 
 ORDER BY c.table_name 
 ; 
 
 /*
���̺� �̸� / PK(�ߺ��Ǹ� �ȵǴ� ��) /  
------------------------------------------- 
MAIN_TABLE1	    SYS_C007697	    P   --
MAIN_TABLE1	    SYS_C007698	    U
MAIN_TABLE1	    SYS_C007696	    C
MAIN_TABLE2	    CK_GENDER	    C
MAIN_TABLE2	    UQ_NICKNAME	    U
MAIN_TABLE2	    PK_MAIN	        P
.
.
.   
SUB_TABLE4	    PK_SUB4	        P
SUB_TABLE4	    FK_SUB4	        R ( =REFERENCE => FOREIGN KEY)

*/ 
 


--���̺� �̸��� ���� : RENAME 
--EX) MARCH_MEMEBER --> MEMBER_OF_MARCH 
RENAME MARCH_MEMBER TO MEMEBER_OF_MARCH; 
RENAME MEMEBER_OF_MARCH TO MARCH_MEMBER; 

--���̺� ���� : DROP 
-- �� ���̺� ���̿� REFERECES ( FOREEIGN KEY) ���谡 ���� ���� ���� 
-- MAIN_TABKE1�� ��� SUB_TABLE�� ���� ID�÷��� �����ǰ� �ִ� ���� 

--1) MAIN_TABLE1 ���� ���� 
DROP TABLE MAIN_TABLE1;
-- ��� : ORA-02449: �ܷ� Ű�� ���� �����Ǵ� ����/�⺻ Ű�� ���̺� �ֽ��ϴ� 
-- SUB_TABLE1 �� MAIN_TABLE1�� ID �÷��� �����ϰ� �ֱ� ������ SUB�� ���� ������ �Ѵ�. 

--2)SUB_TABLE1 ���� ���� �� MAIN_TABLE1�� �����Ѵ�
DROP TABLE SUB_TABLE1;
DROP TABLE MAIN_TABLE1; 

--3)���� ������� ������� �ٷ� �����ϴ� ���
DROP TABLE MAIN_TABLE2 CASCADE CONSTRAINT;


--CASCADE �ɼ����� ���̺��� �����ϸ� ���� ���� ��� ����� ��� ���� 0�� �ȴ�.
--���������� ��� �����Ͽ� ���̺��� DROP�� 
--Ư�� �� ������� SUB_TABLE2�� �ִ� R �翪 ���� ��������� �ǹ�
SELECT c.table_name 
     , c.constraint_name 
     , c.constraint_type 
  FROM user_constraints c 
 WHERE c.table_name LIKE 'MAIN_TABLE%' 
    OR c.table_name LIKE 'SUB_TABLE%' 
 ORDER BY c.table_name  
 ;
 
 
 
 --SUB_TABLE3D�� DROP �� �� user_constraints ���� ���� ���� ������� Ȯ�� 
DROP TABLE SUB_TABLE3 CASCADE CONSTRAINT;


SELECT c.table_name 
     , c.constraint_name 
     , c.constraint_type 
  FROM user_constraints c 
 WHERE c.table_name LIKE 'MAIN_TABLE3' 
    OR c.table_name LIKE 'SUB_TABLE3' 
 ORDER BY c.table_name  
 ; 
 
 
 /*
    MAIN_TABLE3	CK_GENDER3	    C
    MAIN_TABLE3	UQ_NICKNAME3	U
    MAIN_TABLE3	PK_MAIN3    	P
 --SUB_TABLE3�� DROP�ص� MAIN_TABLE3�� ���� ���ǿ��� ������ ��ġ�� ����
 */