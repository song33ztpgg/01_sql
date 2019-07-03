--DAY 14 

--3) DELECTE : ���̺��� [��]������ �����͸� ���� 
-- DELETE ���� ���� 
DELETE [FROM] ���̺��̸� [���̺� ��Ī] 
 WHERE ���� 
; 

---1.WHERE ������ �ִ� DELETE ���� 
--���� �� Ŀ��  
COMMIT; 

-- member ���̺��� gender�� 'F'�� �����͸� ����
DELETE member m 
 WHERE m.gender = 'R' -- ��Ÿ �Է� 
; 
/* 0���� ���� ���� �Ǿ����ϴ�. (������ ������ ������)*/


DELETE member m 
 WHERE m.gender = 'F' 
 ; 
 /* 1���� ���� ���� �Ǿ����ϴ�.  
Ư�� �� ������ PK �� �ƴ� �������� �����ϴ°��� �����ؾ� �� 
*/  
 
 ROLLBACK;
 
 --���� 'M004'���� ���� �ϴ°��� �����̶�� PK�� �����ؾ� �� 
 DELETE member m 
  WHERE m.member_id = 'M004' 
  ; 
  
  COMMIT;
 
 --2.WHERE ������ ���� DELETE ���� 
 --  WHERE ������ �ƾ� ����(����)�� ��� ��ü ���� ����  
 DELETE member; 
 ROLLBACK; 
 
 ---3.DELETE �� WHERE �� �������� ���� 
 -- �ּҰ� '�ƻ��'�� ����� ��� ����
 DELETE member m 
  WHERE m.address = '�ƻ��' 
  ; 
  
 ---(1) �ּҰ� '�ƽŽ�'�� ����� ��ȸ
SELECT m.member_id 
  FROM member m 
 WHERE m.address = '�ƻ��' 
; 

--(2) �����ϴ� ���� ���� �ۼ� 
DELETE member m 
 WHERE m.member_id = ?   -- ���� 1���ۿ� ���� ���Ѵ�
; 

--(3) 2q���� ���� ������ 1���� �������� ����
DELETE member m 
 WHERE m.member_id IN (SELECT m.member_id 
                         FROM member m 
                        WHERE m.address = '�ƻ��')
;  

ROLLBACK;
 
-------------------------------------------------------- 
--DELETE VS TRUNCATE 
/*
1.TRUNCATE �� DDL�� ���ϴ� ��ɾ� ���� 
  ROLLBACK ������ �������� ���� 
  �� �� ����� DDL�� �ǵ��� �� ���� 
  
2.TRUNCATE �� DDL �̱� ������ 
  WHERE ������ ������ �Ұ��� �ϹǷ� 
  Ư�� �����͸� �����Ͽ� �����ϴ� ���� �Ұ��� 
*/ 


--TRUNCATE ���� �Ŀ� �ǵ��ư� COMMIT ���� ���� 
COMMIT; 

--new member�� �߶󳻱�
TRUNCATE TABLE  new_member;
/* Table NEW_MEMBER��(��) �߷Ƚ��ϴ�. */ 
--�ǵ����� �õ� 

ROLLBACK;
/* �ѹ��� �����ε� �������� 
TRUNCATE ����� ����� ���ÿ� �ڵ�Ŀ���� �̷�� ���Ƿ� 
TRUNCATE ���� ������ �ѹ鰡���� Ŀ���������� �����ϴ�.*/ 

------------------------------------------------------------------- 
--TCL : Transaction Control Language 
--1)COMMIT 
--2)ROLLBACK  
--3)SAVEPOINT 
---1.member ���̺� 1���� �߰�  
-----1.1 INSERT ���� Ŀ������ ���� 
COMMIT;

-----1.2 DML : INSERT �۾� ����
INSERT INTO member m(m.member_id, m.member_name) 
VALUES ('M010','ȫ�浿') 
;
/*1 �� ��(��) ���ԵǾ����ϴ�.*/ 

-----1.3 1�� �߰����� �߰� ���� ���� 
SAVEPOINT do_insert; 
--Savepoint�� �����Ǿ����ϴ�. 

--2.ȫ�浿�� �ּҸ� ������Ʈ 
---2.1 DML : UPDATE �۾� ���� 
--- 
UPDATE member m 
   SET m.address = '������' 
 WHERE m.member_id = 'M010' 
 ; 
 
---2.2 �ּ� �������� �߰� ����  
SAVEPOINT do_address;

--3.ȫ�浵�� ��ȭ��ȣ ������Ʈ 
UPDATE member m 
   SET m.phone = '9999' 
 WHERE m.member_id = 'M010' 
 ; 
---3.2 ��ȭ��ȣ �������� �߰����� 
SAVEPOINT do_update_phone; 

--4.ȫ�浿�� ���� ������Ʈ 
--4.1 DML : UPDATE �۾� ���� 
UPDATE member m 
   SET m.gender = 'F' 
 WHERE m.member_id = 'M010'
;

--4.2 ���� ������Ʈ  
SAVEPOINT do_update_gender;

--���� 4���� SAVEPOINT�� �ϳ��� Ʈ��������� ���� �ִ� ��Ȳ 
--COMMIT�� ���� �ʾƼ� Ʈ����� �������ᰡ �ƴ� ��Ȳ
/*
1.COMMIT
2.SAVEPOINT1 
3.SAVEPOINT2
4.SAVEPOINT3 
5.SAVEPOINT4  
 
������ �������� �ۿ� ���� ���� 
*/ 

ROLLBACK TO do_update_addr; -- �ѹ� ���̺�����Ʈ�� �߸� ������ ��
-- �ѹ� �Ϸ�.

-- 2. �ּ�, ��ȭ��ȣ ���������� �¾Ұ�, ���� ������ �߸��Ǿ���.
ROLLBACK TO do_update_phone;
/*
 'DO_UPDATE_PHONE' �������� �� ���ǿ� �������� �ʾҰų� �������մϴ�.

  SAVEPOINT ���� ������ �ִ�.
  do_update_addr �� do_update_phone ���� �ռ� ������ �����̱⶧����
  ������� ROLLBACK TO �� �Ͼ��
  �� �� ������ SAVEPOINT �� ��� ���� ��.
*/


--3. 2���� ROLLBACK TO ���� �Ŀ� �ǵ��� �� �ִ� ���� 
ROLLBACK TO do_insert -- insert �� ���� 
ROLLBACK;             -- ���� ���� ���� 
----------------------------------------------------- 

--��Ÿ ��ü : SEQUENCE , INDEX , VIEW 
--SEQUENCE : �⺻ Ű(PK)������ ���Ǵ� �Ϸù�ȣ ���� ��ü
--1.���� ��ȣ : 1, �ִ� : 30, ����Ŭ�� ���� ������ ���� 
CREATE SEQUENCE seq_member_id 
 START WITH 1 
MAXVALUE 30 
NOCYCLE 
;
/* Sequence SEQ_MEMBER_ID��(��) �����Ǿ����ϴ�. */
/*
CREATED	        19/07/03
LAST_DDL_TIME	19/07/03
SEQUENCE_OWNER	SCOTT
SEQUENCE_NAME	SEQ_MEMBER_ID
MIN_VALUE	    1      -�ּ� ����
MAX_VALUE	    30     -�ִ� ����
INCREMENT_BY	1
CYCLE_FLAG	    N
ORDER_FLAG	    N
CACHE_SIZE	    20
LAST_NUMBER	    1      -������ ��ȣ
SCALE_FLAG	    N
EXTEND_FLAG	    N
SESSION_FLAG	N
KEEP_VALUE	    N
DUPLICATED	    N
SHARDED	        N
*/   
--�������� ��ü�̱� ������ DDL �����Ѵ�  
-- �������� �����Ǹ� �ý��� īŻ�α׿� ����ȴ�. 
--user_sequences  
SELECT s.sequence_name 
     , s.min_value 
     , s.max_value 
     , s.cycle_flag 
     , s.increment_by
  FROM user_sequences s 
 WHERE s.sequence_name = 'SEQ_MEMBER_ID' 
 ;
 /*
 SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, CYCLE_FLAG, INCREMENT_BY 
 -------------------------------------------------------------
 SEQ_MEMBER_ID	    1	    30	            N	        1
 */
 
 
 --���� ���� �������� �����ϸ� 
CREATE SEQUENCE seq_member_id 
 START WITH 1 
MAXVALUE 30 
NOCYCLE 
;
 /*������ ��ü�� �̸��� ����ϰ� �ֽ��ϴ�  
 ����� ��� �ȴ�.
 */
 
 
 --��Ÿ �����͸� �����ϴ� ���� ��ųʸ� 
 /*
 ���Ἲ ��������  : user_constraints 
 ������ ��������  : user_sequences 
 ���̺� ��������  : user_tables 
 �ε��� ��������  : user_indexes 
 ��ü�� ��������  : user_objects
 */


--2.������ ��� 
-- : ������ �������� SELECT �������� ��밡�� 
--(1) NEXTVAL : �������� ���� ��ȣ�� �� 
--              CREATE �ǰ� ���� �ݵ�� ���� 1�� NEXTVAL 
--              ȣ���� �Ǿ�� ������ ���� 

--���� : �������̸�.NEXTVAL 
SELECT SEQ_MEMBER_ID.NEXTVAL 
  FROM dual   
; 
/*
�����Ҷ����� ���� ������
MAXVALUE �̻� �����ϸ������ ������ �߻� 
*/ 

--(2) CURRVAL : ���������� ���� ������ ��ȣ�� Ȯ�� 
--              ������ ������ ���� 1���� NEXTVAL ȣ���� ������ ��
--              ������ ��ȣ�� ���� �� ���� 
--              �� , �������� ���� ��Ȱ��ȭ ����  

--���� : ������ �̸�.CURRVAL 
SELECT SEQ_MEMBER_ID.CURRVAL  
  FROM dual 
; 

/* NEXTVAL�� �������� ������� Ȱ��ȭ�� ���� �ʾƼ� ������ �����.*/

--(3) ������ ���� : ALTER SEQUECNE  
-- ������ SEQ_MEMBER_ID�� MAXVALUE ������ NOMAXVALUE �� ���� 
ALTER SEQUENCE SEQ_MEMBER_ID 
NOMAXVALUE 
; 

/* MAX_VALUE	9999999999999999999999999999 */ 

ALTER SEQUENCE SEQ_MEMBER_ID 
INCREMENT BY 10 
;
/* INCREMENT_BY	10*/ 

ALTER SEQUENCE SEQ_MEMBER_ID 
CYCLE
; 
/* CYCLE_FLAG	Y */

DROP SEQUENCE seq_member_id; 
/*Sequence SEQ_MEMBER_ID��(��) �����Ǿ����ϴ�.*/

SELECT SEQ_MEMBER_ID.CURRVAL  
  FROM dual 
; 
/* ORA-02289: �������� �������� �ʽ��ϴ�. */ 

----------------------------------------------- 
--new_member ���̺� ������ �Է½� ������ Ȱ�� 

--new_member�� id �÷��� ����� ������ �ű� ���� 
/*
������ �̸� : seq_new_member_id 
���۹�ȣ    : START WITH 1
���� ��     : INCREMENT BY 1
���� ��ȣ   : 1 
�ִ� ��ȣ   : NOMAXVALUE 
����Ŭ ���� : NOCYCLE 
*/ 

CREATE SEQUENCE seq_new_member_id 
START WITH 1
INCREMENT BY 1
NOMAXVALUE 
NOCYCLE  
; 
/* Sequence SEQ_NEW_MEMBER_ID��(��) �����Ǿ����ϴ�. */ 


-- ���� ��ǥ member_id�� M001,M002
SELECT 'M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL, 3, 0) AS member_id
  FROM dual
; 

INSERT INTO new_member(member_id, member_name) 
VALUES ('M' || LPAD(SEQ_NEW_MEMBER_ID.NEXTVAL, 3, 0) 
             , 'ȫ�浿') 
; 
COMMIT;


----------------------------------------------------------------- 
--INDEX : �������� ��ȸ,�˻� (DQL)�� ������ �˻� �ӵ� ������ ���� 
--        DBMS�� �����ϴ� ��ü 

--1.user_indexes ���̺��� �̹� �����ϴ� INDEX ��ȸ 
SELECT i.index_name 
     , i.index_type 
     , i.table_name 
     , i.include_column
  FROM user_indexes i
;

/*
SYS_C007730	    NORMAL	CUSTOMER	
PK_DEPT	        NORMAL	DEPT	
PK_EMP	        NORMAL	EMP	
SYS_C007697	    NORMAL	MAIN_TABLE1	
SYS_C007698	    NORMAL	MAIN_TABLE1	
PK_MAIN3	    NORMAL	MAIN_TABLE3	
UQ_NICKNAME3	NORMAL	MAIN_TABLE3	
PK_MAIN4	    NORMAL	MAIN_TABLE4	
UQ_NICKNAME4	NORMAL	MAIN_TABLE4	
SYS_C007691	    NORMAL	MAIN_TALBLE1	
SYS_C007692	    NORMAL	MAIN_TALBLE1	
PK_MEMBER	    NORMAL	MEMBER	
PK_SUB4	        NORMAL	SUB_TABLE4	
*/

--2.���̺��� ��Ű(PK)�÷��� ���ؼ��� DBMS�� 
--�ڵ����� �ε��� �������� �� �� ���� 
-- UNIQUE�� ���ؼ��� �ε����� �ڵ����� ������
--�ѹ� �ε����� ������ �÷��� ���ؼ��� �ߺ� ���� �Ұ��� 

--EX) MEMBER ���̺��� MEMBER_ID �÷��� ���� �ε��� ���� �õ� 
CREATE INDEX idx_member_id
ON member (member_id) 
;
/* �� ��Ͽ��� �̹� �ε����� �ۼ��Ǿ� �ֽ��ϴ�  
=> PK_member ��� �̸��� �ٸ� IDX_MEMBER_ID�� ���� �õ��ص� 
���� Ŀ���� ���ؼ��� �ε����� �� �� �������� ���� */


--3.���� ���̺� new_member ����  PK�� ���� ������ �ε����� ���� ����
--1) new_member �� member_id �÷��� �ε��� ����
CREATE INDEX idx_new_member_id 
ON new_member (member_id) 
;
/* Index IDX_NEW_MEMBER_ID��(��) �����Ǿ����ϴ�. */ 

--�ε��� ���� Ȯ���� DROP 
DROP INDEX idx_new_member_id ; 
/*����*/

CREATE INDEX idx_new_member_id 
ON new_member (member_id DESC) 
;
/*ASC -> DESC */

SELECT i.index_name 
     , i.index_type 
     , i.table_name 
     , i.include_column
  FROM user_indexes i
; 

-- INDEX �� SELECT �� ���� �� 
-- ���� �˻��� ���ؼ� ��������� SELECT�� ����ϴ� ��찡 ���� 
-- ==> HINT���� SELECT�� ����Ѵ�.


/*
������   ����                            ��������(pk�� �����ϸ� �ڵ� ��������)
------------------------------------
SCOTT	PK_EMP	SCOTT	EMP	EMPNO	1	ASC
--��������(pk�� �����ϸ� �ڵ� ��������)
*/




