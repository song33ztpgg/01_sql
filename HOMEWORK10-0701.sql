-- HOMEWORK 
�ǽ� 10) ������ ���̺��� �����ϴ� ������ �ۼ� 
3�� ������� �ۼ� 

GAME 
-----------------------------------
GAME_CODE NUMBER(2)     PK���� 
GAME_NAME VARCHAR2(200) NOT NULL 
-----------------------------------



GMEMBER 
------------------------------------------------
IF   VARCHAR2(4)  PK����     --ȸ���� ���̵�
NAME VARCHAR2(15) NOT NULL   --ȸ���� �̸�
----------------------------------------------- 

MEMBER_GAME_HISTORY 
ID   VARCHAR2(4) FK ����, FK �̸� : FK_ID 
                 GMEMBER ���̺��� ID �÷��� �����ϵ��� ���� 
YEAR NUMBER(4)   --������ �� �⵵
GAME_CODE NUMBER(2) FK ����, FK�̸� : FK_GAME_CODE 
                    GAME ���̺��� GAME_CODE Į���� �����ϵ��� ����


--���� 4�� 
--���� 2�� 
--���õ��ڷ� 4��