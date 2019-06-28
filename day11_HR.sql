--HR ���� Ȱ��ȭ 
ALTER SESSION 
    SET "_ORACLE_SCRIPT"=true 
;

@C:\app\Administrator\product\18.0.0\dbhomeXE\demo\schema\human_resources\hr_main


--HR�Է� 
--HR�Է� 
--HR�Է� 
--$ORACLE_HOME/demo/schema/log/ �Է� 

--HR�� �۾�  
------------------------------------------------------------------------------
------------------------------------------------------------------------------

--2.DISTINT 

----2.1) job�� �ߺ��� ��������
SELECT DISTINCT e.DEPARTMENT_ID
  FROM employees e
;

/*
DEPARTMENT_ID 
----------------
50
40
110
70
90
30
10

20
60
100
80
*/

----2.2) MANAGER_ID �ߺ� ���� �ʰ� ����� ������ �Ͻÿ� 
SELECT DISTINCT e.manager_id
  FROM employees e
;

/*
MANAGER_ID 
---------
124
108
121
145
101

103
120
122
146
148
149
201
114
100
205
102
123
147
*/


----2.3) SALARY �ߺ����� �ʴ� �����  ����ÿ�
SELECT DISTINCT e.salary
  FROM employees e 
; 
/* 
SALARY 
------
6500
4200
7800
8000
2200
2600
3100
2900
9600
4400
9000
2400
3600
7200
3400
8300
4800
3200
10500
7500
7000
6800
8800
4100
6000
8200
7700
2800
2500
3300
7400
12008
11000
7900
2700
9500
11500
3900
10000
17000
13500
12000
6400
7300
3000
13000
24000
6900
5800
2100
3500
14000
6200
6100
8600
8400
3800
4000
*/

--����������������������������������������������������--

--3.ORDER BY  

----3.1) job�� ������������ �����Ͻÿ� �ߺ��� ���� ����
SELECT DISTINCT e.job_id
  FROM employees e
 ORDER BY e.job_id
; 
/*
JOB_ID 
----------
AC_ACCOUNT
AC_MGR
AD_ASST
AD_PRES
AD_VP
FI_ACCOUNT
FI_MGR
HR_REP
IT_PROG
MK_MAN
MK_REP
PR_REP
PU_CLERK
PU_MAN
SA_MAN
SA_REP
SH_CLERK
ST_CLERK
ST_MAN
*/

----3.2) MANAGER_ID �� ������������ �����Ͻÿ� ( �ߺ��� ��������)
SELECT DISTINCT e.manager_id 
  FROM employees e 
 ORDER BY e.manager_id
;

/* 
MANAGER_ID 
------
100
101
102
103
108
114
120
121
122
123
124
145
146
147
148
149
201
205
*/

----3.3) SALARY ������������ �����  ����ÿ�(�ߺ����� ����)
SELECT DISTINCT e.salary
  FROM employees e  
 ORDER BY e.salary DESC
;

/* 
SALARY 
------
24000
17000
14000
13500
13000
12008
12000
11500
11000
10500
10000
9600
9500
9000
8800
8600
8400
8300
8200
8000
7900
7800
7700
7500
7400
7300
7200
7000
6900
6800
6500
6400
6200
6100
6000
5800
4800
4400
4200
4100
4000
3900
3800
3600
3500
3400
3300
3200
3100
3000
2900
2800
2700
2600
2500
2400
2200
2100
*/

--����������������������������������������������������--
--4.ALIAS 

----4.1) job�� Į���� '����' ��Ī�� ����ÿ�(�ߺ�����) 
SELECT DISTINCT e.job_id ����
  FROM employees e 
;

/*
���� 
----------
AC_ACCOUNT
AC_MGR
AD_ASST
AD_PRES
AD_VP
FI_ACCOUNT
FI_MGR
HR_REP
IT_PROG
MK_MAN
MK_REP
PR_REP
PU_CLERK
PU_MAN
SA_MAN
SA_REP
SH_CLERK
ST_CLERK
ST_MAN
*/

----4.2) MANAGER_ID �� '�Ŵ��� ID' ��Ī�� ����ÿ� (�ߺ�����)
SELECT DISTINCT e.manager_id "�Ŵ��� ID"
  FROM employees e 
;
/* 
�Ŵ��� ID 
----------
124
108
121
145
101

103
120
122
146
148
149
201
114
100
205
102
123
147
*/

----4.3) SALARY �� '�޿�' ��Ī���� ����� 10,000 �̻��� ����� ã���ÿ�(�ߺ�����)
SELECT DISTINCT e.salary �޿�
  FROM employees e 
 WHERE e.salary > 10000
; 
/*
�޿� 
------
10500
12008
11000
11500
17000
13500
12000
13000
24000
14000
*/
--����������������������������������������������������--
--5.WHERE 

----5.1) job �� 'ST_CLERK' ��� ����� ã���ÿ�
SELECT e.first_name 
     , e.job_id
  FROM employees e 
 WHERE e.job_id = 'ST_CLERK'  
 ; 
 
/*
FIRST_NAME, JOB_ID 
 ------------------
Mozhe	ST_CLERK
Laura	ST_CLERK
Curtis	ST_CLERK
Ki	    ST_CLERK
Renske	ST_CLERK
James	ST_CLERK
Jason	ST_CLERK
Steven	ST_CLERK
James	ST_CLERK
Randall	ST_CLERK
Irene	ST_CLERK
Julia	ST_CLERK
TJ	    ST_CLERK
Joshua	ST_CLERK
Hazel	ST_CLERK
Trenna	ST_CLERK
Michael	ST_CLERK
John	ST_CLERK
Stephen	ST_CLERK
Peter	ST_CLERK
 */
----5.2) MANAGER_ID �� '121' �� ����� ã���ÿ� (�̸��� ������������) 
SELECT e.first_name
     , e.manager_id
  FROM  employees e 
 WHERE e.manager_id = 121 
 ORDER BY e.first_name
; 

/* 
FIRST_NAME, MANAGER_ID 
----------------------
Alexis	    121
Anthony	    121
James	    121
Julia	    121
Laura	    121
Mozhe	    121
Nandita	    121
TJ	        121
*/

----5.3) SALARY �� '7500' �� ����� ã���ÿ� (�̸��� ������������) 
SELECT e.first_name
     , e.salary  
  FROM employees e 
 WHERE e.salary = 7500
 ORDER BY e.first_name
; 

/*
FIRST_NAME, SALARY
----------------
Louise	    7500
Nanette	    7500
*/

--����������������������������������������������������--
--6.��� ������ 

----6.1) ������ SA_MAN �� ������ �Ѵ� �޿��� ���� ����Ͻÿ� (�̸��� ������������)
SELECT e.first_name   �̸�
     , e.salary       �޿� 
     , TO_CHAR( e.salary / 12 , '9999.9') ����
  FROM employees e 
 WHERE e.job_id = 'SA_MAN' 
 ORDER BY e.first_name
;
/*
�̸�,    �޿�,   ���� 
---------------------------
Alberto	12000	 1000.0
Eleni	10500	  875.0
Gerald	11000	  916.7
John	14000	 1166.7
Karen	13500	 1125.0
*/

----6.2) ������ ���� ������� ���� �޿��� ��ü ����� ���̸� ���Ͻÿ� (���̸� ������������)
SELECT e.first_name
     , e.salary + (SELECT TO_CHAR(avg(e.salary), '9999.9') 
                     FROM employees e) "�޿� - ���" 
  FROM employees e 
 WHERE e.commission_pct IS NULL  
 ORDER BY "�޿� - ���" 
;
/*
FIRST_NAME, �޿� - ��� 
------------------------
TJ	        8561.8
Hazel	    8661.8
Steven	    8661.8
James	    8861.8
Ki	        8861.8
Randall 	8961.8
Karen	    8961.8
Joshua  	8961.8
Peter	    8961.8
Martha	    8961.8
James	    8961.8
Donald	    9061.8
Douglas	    9061.8
Guy	        9061.8
Randall	    9061.8
John	    9161.8
Irene	    9161.8
Girard	    9261.8
Sigal	    9261.8
Mozhe	    9261.8
Vance	    9261.8
Michael	    9361.8
Shelli	    9361.8
Timothy	    9361.8
Anthony	    9461.8
Kevin	    9461.8
Alana	    9561.8
Curtis	    9561.8
Alexander	9561.8
Jean	    9561.8
Julia	    9661.8
Samuel	    9661.8
Stephen	    9661.8
Winston	    9661.8
Laura	    9761.8
Jason	    9761.8
Julia	    9861.8
Trenna	    9961.8
Renske	    10061.8
Jennifer	10061.8
Kelly	    10261.8
Britney	    10361.8
Sarah	    10461.8
Alexis	    10561.8
Nandita	    10661.8
Diana	    10661.8
Jennifer	10861.8
David	    11261.8
Valli	    11261.8
Kevin	    12261.8
Bruce	    12461.8
Pat	        12461.8
Susan	    12961.8
Shanta	    12961.8
Luis	    13361.8
Ismael	    14161.8
Jose Manuel	14261.8
Payam	    14361.8
Matthew	    14461.8
Adam	    14661.8
John	    14661.8
William	    14761.8
Daniel	    15461.8
Alexander	15461.8
Hermann	    16461.8
Den	        17461.8
Nancy	    18469.8
Shelley	    18469.8
Michael	    19461.8
Lex	        23461.8
Neena	    23461.8
Steven	    30461.8
*/
 
----6.3) ������ �Ϸ� ������ �޿��� �ٲٰ� ���� ���� �ݾ��� ���Ͻÿ� 
SELECT MAX(TO_CHAR(e.salary / 12 , '9999.9')) "�Ϸ�޿�"
  FROM employees e  
;


--����������������������������������������������������--
--7.�� ������ 

----7.1) ���� D�� �����ϰ� �޿��� 10,000 ������ ����� ã���ÿ�
SELECT e.first_name 
     , e.salary 
     , e.manager_id
  FROM employees e 
 WHERE e.last_name LIKE 'D%'
   AND e.salary < 10000
 ORDER BY e.first_name DES\
;

----7.2) EMPLOYEE_ID �� �Ŵ��� id �� '110' ������ ����� ã���ÿ�
SELECT e.first_name  �̸�
     , e.employee_id ENPID 
     , e.manager_id  �Ŵ���ID
  FROM employees e  ��
 WHERE e.employee_id < 110 
    OR e.manager_id < 110 
 ORDER BY e.first_name
; 

/* 
�̸�,     ENPID, �Ŵ���ID 
--------------------
Adam	    121	    100
Alberto	    147	    100
Alexander	103 	102
Bruce	    104	    103
Daniel	    109	    108
David	    105	    103
Den	114	    100
Diana	    107 	103
Eleni	    149 	100
Gerald	    148	    100
Hermann	    204 	101
Ismael	    111	    108
Jennifer	200	    101
John	    145 	100
John	    110 	108
Jose Manuel	112	    108
Karen	    146	    100
Kevin      	124	    100
Lex	        102	    100
Luis	    113	    108
Matthew	    120	    100
Michael	    201	    100
Nancy	    108	    101
Neena	    101	    100
Payam	    122	    100
Shanta	    123	    100
Shelley 	205	    101
Steven	    100	
Susan	    203	    101
Valli	    106 	103
*/


----7.3) SALARY �� '7500' �̻��� ����, �̸��� ã���ÿ� 
LAST 
FIRST  
--����������������������������������������������������--
--8.SQL ������ 
----8.1) IN�� �̿��Ͽ� �޿��� 7000 �̰ų� ������ 0.4�� ����� ã���ÿ�

----8.2) BETWEEN�� �̿��Ͽ� ������ 0.2 ~ 0.5 ������ ����� ã���ÿ�

----8.3) ������ ���� ���� ����� ���� ���Ͻÿ�
--����������������������������������������������������--
--9.������ �Լ� 
----9.1) 

----9.2) 

----9.3) 


--����������������������������������������������������--
--����������������������������������������������������--
--����������������������������������������������������--
--����������������������������������������������������--
--����������������������������������������������������--
--����������������������������������������������������--
--����������������������������������������������������--
--����������������������������������������������������--
--����������������������������������������������������--
--����������������������������������������������������--


