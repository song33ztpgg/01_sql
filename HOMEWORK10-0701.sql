-- HOMEWORK 
실습 10) 세개의 테이블을 생성하는 구문을 작성 
3번 방식으로 작성 

GAME 
-----------------------------------
GAME_CODE NUMBER(2)     PK형식 
GAME_NAME VARCHAR2(200) NOT NULL 
-----------------------------------



GMEMBER 
------------------------------------------------
IF   VARCHAR2(4)  PK형식     --회원의 아이디
NAME VARCHAR2(15) NOT NULL   --회원의 이름
----------------------------------------------- 

MEMBER_GAME_HISTORY 
ID   VARCHAR2(4) FK 설정, FK 이름 : FK_ID 
                 GMEMBER 테이블의 ID 컬럼을 참조하도록 설정 
YEAR NUMBER(4)   --게임을 한 년도
GAME_CODE NUMBER(2) FK 설정, FK이름 : FK_GAME_CODE 
                    GAME 테이블의 GAME_CODE 칼럼을 참조하도록 설정


--게임 4개 
--유저 2명 
--관련된자료 4개