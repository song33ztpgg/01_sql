--day06 
----2)�����Լ�  
----------1.INITCAP(str) : str�� ù ���ڸ� �빮��ȭ(����) 
SELECT INITCAP('the watch')   
  FROM dual 
;
--==>�÷�  : �׳�, �̸� : '' �ʿ�

SELECT initcap('�ȳ�')
  FROM dual 
;
------------------------------------------------------------------------------------------

------------2.LOWER(str) : str�� ��� ���ڸ� �ҹ���ȭ(����) 
SELECT lower('MR,SCOOT') 
  FROM dual 
; 
------------------------------------------------------------------------------------------
------------3.UPPER(str):  str�� ��� ���ڸ� �빮��ȭ(����)
SELECT UPPER('lee') 
  FROM dual 
;  


-- smith�� ã�µ� �Է��� �ҹ��ڷ� �� ��쿡 
-- SMITH�� �ٸ� ���ڷ� �νĵǹǷ� ã���� ����. 
SELECT e.empno 
     , e.ename 
  FROM emp e 
 WHERE e.ename = 'SMITH' 
;

-- ename �� ���ϴ� ���� �빮�� �̹Ƿ� ������ ��ȸ��
SELECT e.empno 
     , e.ename 
  FROM emp e 
 WHERE e.ename = upper('smith') 
;  

------------------------------------------------------------------------------------------
-----4.LENGTH(str), LENGTHB(str): 
--str�� ���� ���� , ������ byte �� ����Ͽ� ���ڷ� �x�� 

SELECT length('hello, sql') as "���� ����" 
  FROM dual 
; 

--==> Ư����ȣ, ���鵵 ��� (���:10)

SELECT 'hello, ���� ���̴�' || length('hello, sql') 
                          || '�Դϴ�' "���� ����" 
  FROM dual 
;

--���:hello, ���� ���̴�10�Դϴ�

--oracle���� �ѱ��� 3byte�� ���� 
SELECT lengthb('hello, sql') "���� byte" 
  FROM dual 
;
--���:10

SELECT lengthb('����Ŭ') "���� byte" 
  FROM dual 
; 
--���:9 

------------------------------------------------------------------------------------------
----- 5.CONCAT(str1,str2) : str�� str���� ���ڿ� ���� �����ڿ� ������ ��� 

SELECT concat('�ȳ��ϼ���,','SQL!') �λ�
  FROM dual
;

SELECT '�ȳ��ϼ���,' || 'SQL!' �λ�
  FROM dual
;    -- ����Ŭ������ ��밡��

/*
�λ� 
---------------
�ȳ��ϼ���,SQL!
*/

------------------------------------------------------------------------------------------
-----6 SUBSTR(str, i, n): 
--      str ���� i��° ��ġ������ n���� ���ڸ� ����  
--      SQL���� ���ڿ��� �ε���(����)�� 1���� ����
--      str���� i��° ��ġ���� ������ ���ڸ� ����
SELECT substr('SQL is cooooooooooooooo', 3, 4) "�̸�ª�Ը����" 
  FROM dual
;
/*
�̸�ª�Ը���� 
-----------
L is
*/
SELECT substr('SQL is cooooooooooooooo', 3, 4) "�̸�ª�Ը����" 
  FROM dual
;


--���� :SQL�� ����
SELECT substr('SQL is cooooooooooooooo', 1, 3) "�̸�ª�Ը����" 
  FROM dual
;
--���� :is�� ����
SELECT substr('SQL is cooooooooooooooo', 5, 2) "�̸�ª�Ը����" 
  FROM dual
;
--����: !!�� ����
SELECT substr('SQL is cooooooooooooooo!!', 24) "�̸�ª�Ը����" 
  FROM dual
; 
-- ==> ������ ���� �� �����Ѵٸ� �� ���ڸ� �Է����� �ʾƵ� �ȴ�.

--���� : emp ���̺��� ������ �̸��� �� �α��� ������ �����Ͽ� 
--       ����� �Բ� ��ȸ�Ͻÿ� 
SELECT substr(e.ename,1,2) 
     , e.empno
  FROM emp e
;
--------------------------------------------------------------------------------- 
-----7.INSTR(str1,str2) : �ι�° ���ڿ��� str2�� 
--                        ù��° ���ڿ��� str1�� ��� ��ġ�ϴ��� 
--                         �����ϴ� ��ġ�� ����Ͽ� ���ڷ� ���                        

SELECT instr('SQL is cooooooooooooooo!!', 'is') "is ��ġ" 
  FROM dual
; 

SELECT instr('SQL is cooooooooooooooo!!', 'io') "is ��ġ" 
  FROM dual
;   -- ��� : 0


-- ==> �ι�° ���ڿ��� ù��° ���ڿ��� ������ 0�� ����Ѵ�.

-------------------------------------------------------------------
-------8.LPAD ,RPAD(str, n ,c) �Էµ�str���ؼ� ��ü ���ڰ� ������ �ڸ����� n���� ���
--                             ��ü ���ڼ� ��� ����/�����ʿ� ���� �ڸ����� 
--                              c�� ���ڸ� ä���ִ´�

-- ==> L% : left�ǹ� ,  R% : Right�ǹ�
-- ==> n:���� , c : ���� 1�� , str:1�� �̻� �� 


SELECT lpad('SQL is cool!',20,'*')
  FROM dual 
; 
--��� : ********SQL is cool!
-- ���ڴ� �� 12�� �δ�  20���� �����Ͽ��⿡ ������ 8����  ���ʿ� *�� ������ �Ѵ�.

SELECT rpad('SQL is cool!',20,'*')
  FROM dual 
; 
--��� : SQL is cool!********

-------------------------------------------------------------------- 
-------9.LTRIM, RTRIM,TRIM :�Էµ� ���ڿ���  L,R,���� ������ ���� 
SELECT '��' || '     sql is cool     ' || '��'
  FROM dual 
;
--��� : ��     sql is cool     ��

SELECT '��' || ltrim('     sql is cool     ') || '��'
  FROM dual 
;
--��� : ��sql is cool     ��

SELECT '��' || rtrim('     sql is cool     ') || '��'
  FROM dual 
;
--��� : ��     sql is cool<

SELECT '��' || trim('     sql is cool     ') || '��'
  FROM dual 
;
--��� : ��sql is cool�� 



SELECT e.empno 
     , e.ename 
  FROM emp e 
 WHERE e.ename =trim(' SMITH  ') 
;
 -- 'SMITH' ����  trim �Լ��� �����Ͽ� ��ȸ���� 
 
 
--���� : �񱳰��� '     smith  ' �϶� SMITH�� ������ ��ȸ�Ͻÿ� 
SELECT e.empno 
     , e.ename 
  FROM emp e 
 WHERE e.ename = upper(trim(' smith  ')) 
 ;
 
 ---------------------------------------------------------------------------
 ------10.NVL(expr1, expr2) 
 --       NVL2(expr1, expr2, expr3_ 
 --       NVLLI(expr1,expr2)
 
 
 --NVL(expr1, expr2) :ù��° ���� ���� NULL�̸� �ι�° ������ ��ü�Ͽ� ��� 
 --�Ŵ���(mgr)�� �������� ���� ������ ��� 0���� ���

SELECT e.empno 
     , e.ename
     , nvl(e.mgr, 0)
FROM emp e
;

/*
EMPNO, ENAME, NVL(E.MGR,0) 
---------------------------
9999	J_JAMES	0
8888	J%JAMES	0
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	0
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/
 
 
 --�Ŵ���(mgr)dl �������� ���� ������ '������ ����'��� ���
SELECT e.empno 
     , e.ename
     , nvl(e.mgr, '�Ŵ��� ����')
 FROM emp e
;

/*
ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid number"

==> nvló�� ��� �ø��� e.mgr�� ����Ÿ���� ������ �ε� 
    null ���� ��ü�Ҷ� '�Ŵ��� ����'�� ����Ÿ���� ������ �̹Ƿ� 
    ��ȯ�� mgr�÷��� Ÿ�԰�����ġ �ϱ� ������ 
    ����� ���� ������ �߻�
*/
 
SELECT e.empno 
     , e.ename
     , nvl(e.mgr || '','�Ŵ��� ����')
 FROM emp e
;
 
/*
EMPNO, ENAME, NVL(E.MGR||'','�Ŵ�������') 
--------------------------------------------
9999	J_JAMES	�Ŵ��� ����
8888	J%JAMES	�Ŵ��� ����
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	�Ŵ��� ����
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/
 
-- ==> || ���տ����ڷ� mgr�� ���ڸ� �ٿ��� ����Ÿ������ ���� 
 
--���� : || ������ ��� concar()�Լ��� ����Ͽ� ���� ����� ���ÿ�  
 
SELECT e.empno 
     , e.ename
     --, nvl(e.mgr,'�Ŵ��� ����')
     , nvl(concat(e.mgr,''),'�Ŵ��� ����')
 FROM emp e
; 
--==> '' ����Ŭ������ null������ �ν�

 
--NVL2(expr1, expr2, expr3) 
--     ù��° ���� ���� NOT NULL�̸� �ι�° ���� ������ ��� 
--                         NULL�̸� ����° ���� ������ ��� 
  
--mgr�� ������ ��췹�� '�Ŵ��� ����'���� 
--�Ŵ����� �������� ���� ��쿡�� '�Ŵ��� ����'���� ���


SELECT e.empno 
     , e.ename
     , nvl2(e.mgr, '�Ŵ��� ����','�Ŵ��� ����') "��/��"
 FROM emp e
;
/*
EMPNO, ENAME, ��/��
---------------------------
9999	J_JAMES	�Ŵ��� ����
8888	J%JAMES	�Ŵ��� ����
7369	SMITH	�Ŵ��� ����
7499	ALLEN	�Ŵ��� ����
7521	WARD	�Ŵ��� ����
7566	JONES	�Ŵ��� ����
7654	MARTIN	�Ŵ��� ����
7698	BLAKE	�Ŵ��� ����
7782	CLARK	�Ŵ��� ����
7839	KING	�Ŵ��� ����
7844	TURNER	�Ŵ��� ����
7900	JAMES	�Ŵ��� ����
7902	FORD	�Ŵ��� ����
7934	MILLER	�Ŵ��� ����
*/
-- ==>str2, str3 ����(����, ����)�� ������ ���ƾ� �Ѵ�.



--����Ŭ���� ���ڿ�('')�� NULL�� ����ϴ� ���� 
-- Ȯ���ϱ� ���� ���� 
SELECT NVl2('','IS NOT NULL','IS NULL') 
  FROM dual 
;
--��� : IS NULL

SELECT nvl2(' ','IS NOT NULL','IS NULL') 
  FROM dual 
; 
--��� : IS NOT NULL
 
 
 --NULLIF(EXPR1,EXPR2) : 
 --ù��° ��, �ι�° ���� ���� �����ϸ� NULL�� ��� 
 --�� ���� �ٸ��� ù��° ���� ���� ��� 
 
 SELECT NULLIF('AAA','BBB')  
   FROM dual
;
-- ��� : AAA 


 SELECT NULLIF('AAA','AAA')  
   FROM dual
;
-- ��� : (null)  ,  (null)���� 1���� �����Ѵ� (����� ��� ��:0) �� �ٸ���

----------------------------------------------------------------------------------------

------3) ��¥ �Լ� : ��¥�� ���õ� ���/��¥�� ���ϱ� ���� ���� ������ �Ҽ��ִ� ��� ����

--������ �ý��� �ð��� ��� sysdata�Լ� 
SELECT sysdate 
  FROM dual 
;
-- ��� : 19/05/24 (yy/mm/dd)

--TO_CHAR(arg) : arg�� ���ڳ� ��¥ Ÿ���� �����Ͱ� �ɼ��ִ�.
--               �Էµ� arg�� ����Ÿ������ �������ִ� �Լ� 
--               to ������ , arg��  char���ڷ� �ٲپ��
SELECT to_char(sysdate, 'YYYY') "�⵵" 
  FROM dual 
;
--��� : 2019

SELECT to_char(sysdate, 'YY') "�⵵" 
  FROM dual 
;
--��� :19

SELECT to_char(sysdate, 'MM') "��" 
  FROM dual 
;
--��� :05

SELECT to_char(sysdate, 'MON') "��" 
  FROM dual 
;
--��� :5�� 

SELECT to_char(sysdate, 'DD') "��" 
  FROM dual 
; 
--��� :5�� 

SELECT to_char(sysdate, 'D') "��" 
  FROM dual 
; 
--��� : 6 -- �ݿ��� �ǹ� 


SELECT to_char(sysdate, 'Day') "��" 
  FROM dual 
; 
--��� : �ݿ���


SELECT to_char(sysdate, 'Dy') "��" 
  FROM dual 
; 
--��� : ��


SELECT to_char(sysdate, 'YYYY-MM-DD') "���ó�¥" 
  FROM dual 
; 
--��� : 2019-05-24


SELECT to_char(sysdate, 'FMYYYY-MM-DD') "���ó�¥" 
  FROM dual 
; 
--��� : 2019-5-24 
--=>fm ��ȿ���� ���� ��¥ ����

SELECT to_char(sysdate, 'YYYY-MON-DD DAY') "���ó�¥" 
  FROM dual 
; 
--��� : 2019-5�� -24 �ݿ���



/*
�ð�����: 
HH:�ð��� 2�ڸ� ǥ��
HI:���� ���ڸ��� ǥ�� 
SS:�ʸ� ���ڸ��� ǥ��
HH24:�ð��� 24�ð����� ǥ�� 
AM:�������� ���� ���� ǥ��
*/ 
SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') "���ó�¥ �ú���" 
  FROM dual 
;
--��� : 2019-05-24 15:32:45
-- ==> 24���� ǥ���  

SELECT to_char(sysdate, 'YYYY-MM-DD AM HH:MI:SS') "���ó�¥ �ú���" 
  FROM dual 
;
--��� : 2019-05-24 ���� 03:43:02
-- ==> AM ����/���� ������ 


SELECT sysdate + 10  "10����"
    ,  sysdate - 10  "10����"
    ,  sysdate + 10/24 "10�ð���"
  FROM dual 
;
--��� : 19/06/03	19/05/14	19/05/25

SELECT to_char(sysdate +10/24,'YYYY-MM-DD AM HH:MI:SS') "10�ð���"
  FROM dual 
;
--��� : 2019-05-25 ���� 01:49:18


-----------------1.MONTHS_BETWEEN(��¥1, ��¥2)  
-------            �� ��¥ ������ ���� ����
SELECT e.empno 
     , e.ename
     , MONTHS_BETWEEN(sysdate, e.hiredate) "�ټ� ���� ��" 
FROM emp e 
;

-- �� ������ �ټ� �������� ���ϵ� �Ҽ��� 1�� �ڸ������� ���ϱ� 

SELECT e.empno 
     , e.ename
     , ROUND((MONTHS_BETWEEN(sysdate, e.hiredate)),2) "�ټ� ���� ��"
  FROM emp e 
;

-----------------------------------------------------------------------------
---------------2.ADD_MONTHS(��¥, ����) : 
--                ��¥�� �����ڸ� ���� ��ŭ ���� ��¥�� ���� 
SELECT add_months(sysdate, 3)
  FROM dual 
;
--��� : 19/08/24

-- ��¥ + ���� : ���� ��ŭ�� �� ���� ���Ͽ� ��¥�� ���� 
-- ��¥ + ����/24 : ���� ��ŭ�� �ð��� ���Ͽ� ��¥�� ����
-- ADD_MONTHS(��¥,����) ���� ��ŭ�� ���� ���Ͽ� ��¥�� ����

---------------------------------------------------------------------------------- 
-----------3.NEXT_DAY, LAST_DAY 
-- ���� ���Ͽ� �ش��ϴ� ��¥�� ���� 
-- �̴��� ������ ��¥�� ����

--���� ��¥���� ���ƿ��� ��(4)������ ��¥�� ����
SELECT next_day(sysdate,4) "���ƿ��� ������"
     , next_day(sysdate,'������') "���ƿ��� ������2" 
     , last_day(sysdate) "�̴��� ������ ��"
  FROM dual 
;
/*
���ƿ��� ������, ���ƿ��� ������2, �̴��� ������ �� 
------------------------------------
19/05/29	19/05/29	19/05/31
*/
-- ==> DAY������ �����̴�

---------------------------------------------------------------------------------- 
-----------4.ROUND, TRUNC :��¥�� ���� �ݿø�, ���� ���� 
SELECT round(sysdate) "���� �ð����� �ݿø�" 
  FROM dual 
; 

--���� : ���� �ð����� �ݿø� �� ���ڸ� ��/��/�� ���� ��� 
SELECT to_char(round(sysdate),'DD HH:MI:SS') "���� �ð����� �ݿø�" 
  FROM dual 
; 
-- ��� : �Ϸ�� 00�� ���

SELECT to_char(trunc(sysdate),'DD HH:MI:SS') "���� �ð����� �ݿø�" 
  FROM dual 
; 
-- ��� : ���� 00�� ���


