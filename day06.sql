--day06 
----2)¹®ÀÚÇÔ¼ö  
----------1.INITCAP(str) : strÀÇ Ã¹ ±ÛÀÚ¸¦ ´ë¹®ÀÚÈ­(¿µ¹®) 
SELECT INITCAP('the watch')   
  FROM dual 
;
--==>ÄÃ·³  : ±×³É, ÀÌ¸§ : '' ÇÊ¿ä

SELECT initcap('¾È³ç')
  FROM dual 
;
------------------------------------------------------------------------------------------

------------2.LOWER(str) : strÀÇ ¸ðµç ±ÛÀÚ¸¦ ¼Ò¹®ÀÚÈ­(¿µ¹®) 
SELECT lower('MR,SCOOT') 
  FROM dual 
; 
------------------------------------------------------------------------------------------
------------3.UPPER(str):  strÀÇ ¸ðµç ±ÛÀÚ¸¦ ´ë¹®ÀÚÈ­(¿µ¹®)
SELECT UPPER('lee') 
  FROM dual 
;  


-- smith¸¦ Ã£´Âµ¥ ÀÔ·ÂÀÌ ¼Ò¹®ÀÚ·Î µÈ °æ¿ì¿¡ 
-- SMITH¿Í ´Ù¸¥ ±ÛÀÚ·Î ÀÎ½ÄµÇ¹Ç·Î Ã£À»¼ö ¾ø´Ù. 
SELECT e.empno 
     , e.ename 
  FROM emp e 
 WHERE e.ename = 'SMITH' 
;

-- ename °ú ºñ±³ÇÏ´Â °ªÀÌ ´ë¹®ÀÚ ÀÌ¹Ç·Î Á¤º¸°¡ Á¶È¸µÊ
SELECT e.empno 
     , e.ename 
  FROM emp e 
 WHERE e.ename = upper('smith') 
;  

------------------------------------------------------------------------------------------
-----4.LENGTH(str), LENGTHB(str): 
--strÀÇ ±ÛÀÚ ±æÀÌ , ±ÛÀÚÀÇ byte ¸¦ °è»êÇÏ¿© ¼ýÀÚ·Î ­x·Â 

SELECT length('hello, sql') as "±ÛÀÚ ±æÀÌ" 
  FROM dual 
; 

--==> Æ¯¼ö±âÈ£, °ø¹éµµ °è»ê (°á°ú:10)

SELECT 'hello, ±ÛÀÚ ±æÀÌ´Â' || length('hello, sql') 
                          || 'ÀÔ´Ï´Ù' "±ÛÀÚ ±æÀÌ" 
  FROM dual 
;

--°á°ú:hello, ±ÛÀÚ ±æÀÌ´Â10ÀÔ´Ï´Ù

--oracle¿¡¼­ ÇÑ±ÛÀ» 3byte·Î °èÇÑ 
SELECT lengthb('hello, sql') "±ÛÀÚ byte" 
  FROM dual 
;
--°á°ú:10

SELECT lengthb('¿À¶óÅ¬') "±ÛÀÚ byte" 
  FROM dual 
; 
--°á°ú:9 

------------------------------------------------------------------------------------------
----- 5.CONCAT(str1,str2) : str°ú str°ú¸¦ ¹®ÀÚ¿­ Á¢ÇÕ ¿¬»êÀÚ¿Í µ¿ÀÏÇÑ °á°ú 

SELECT concat('¾È³çÇÏ¼¼¿ä,','SQL!') ÀÎ»ç
  FROM dual
;

SELECT '¾È³çÇÏ¼¼¿ä,' || 'SQL!' ÀÎ»ç
  FROM dual
;    -- ¿À¶óÅ¬¿¡¼­¸¸ »ç¿ë°¡´É

/*
ÀÎ»ç 
---------------
¾È³çÇÏ¼¼¿ä,SQL!
*/

------------------------------------------------------------------------------------------
-----6 SUBSTR(str, i, n): 
--      str ¿¡¼­ i¹øÂ° À§Ä¡¿¡ºÎÅÍ n°³ÀÇ ±ÛÀÚ¸¦ ÃßÃâ  
--      SQL¿¡¼­ ¹®ÀÚ¿­ÀÇ ÀÎµ¦½º(¼ø¼­)´Â 1ºÎÅÍ ½ÃÀÛ
--      str¿¡¼­ i¹øÂ° À§Ä¡¿¡¼­ ³¡±îÁö ±ÛÀÚ¸¦ ÃßÃâ
SELECT substr('SQL is cooooooooooooooo', 3, 4) "ÀÌ¸§Âª°Ô¸¸µé±â" 
  FROM dual
;
/*
ÀÌ¸§Âª°Ô¸¸µé±â 
-----------
L is
*/
SELECT substr('SQL is cooooooooooooooo', 3, 4) "ÀÌ¸§Âª°Ô¸¸µé±â" 
  FROM dual
;


--¹®Á¦ :SQL¸¸ ÃßÃâ
SELECT substr('SQL is cooooooooooooooo', 1, 3) "ÀÌ¸§Âª°Ô¸¸µé±â" 
  FROM dual
;
--¹®Á¦ :is¸¸ ÃßÃâ
SELECT substr('SQL is cooooooooooooooo', 5, 2) "ÀÌ¸§Âª°Ô¸¸µé±â" 
  FROM dual
;
--¹®Á¦: !!¸¸ ÃßÃâ
SELECT substr('SQL is cooooooooooooooo!!', 24) "ÀÌ¸§Âª°Ô¸¸µé±â" 
  FROM dual
; 
-- ==> ¸¶Áö¸· ±ÛÀÚ ´Ù Æ÷ÇÔÇÑ´Ù¸é µÞ ¼ýÀÚ¸¦ ÀÔ·ÂÇÏÁö ¾Ê¾Æµµ µÈ´Ù.

--¹®Á¦ : emp Å×ÀÌºí¿¡¼­ Á÷¿øÀÇ ÀÌ¸§À» ¾Õ µÎ±ÛÀÚ ±îÁö¸¸ ÃßÃâÇÏ¿© 
--       »ç¹ø°ú ÇÔ²² Á¶È¸ÇÏ½Ã¿À 
SELECT substr(e.ename,1,2) 
     , e.empno
  FROM emp e
;
--------------------------------------------------------------------------------- 
-----7.INSTR(str1,str2) : µÎ¹øÂ° ¹®ÀÚ¿­ÀÎ str2°¡ 
--                        Ã¹¹øÂ° ¹®ÀÚ¿­ÀÎ str1ÀÇ ¾îµð¿¡ À§Ä¡ÇÏ´ÂÁö 
--                         µîÀåÇÏ´Â À§Ä¡¸¦ °è»êÇÏ¿© ¼ýÀÚ·Î Ãâ·Â                        

SELECT instr('SQL is cooooooooooooooo!!', 'is') "is À§Ä¡" 
  FROM dual
; 

SELECT instr('SQL is cooooooooooooooo!!', 'io') "is À§Ä¡" 
  FROM dual
;   -- °á°ú : 0


-- ==> µÎ¹øÂ° ¹®ÀÚ¿­ÀÌ Ã¹¹øÂ° ¹®ÀÚ¿­¿¡ ¾øÀ¸¸é 0À» Ãâ·ÂÇÑ´Ù.

-------------------------------------------------------------------
-------8.LPAD ,RPAD(str, n ,c) ÀÔ·ÂµÈstr´ëÇØ¼­ ÀüÃ¼ ±ÛÀÚ°¡ Â÷ÁöÇÒ ÀÚ¸´¼ö¸¦ nÀ¸·Î Àâ°í
--                             ÀüÃ¼ ±ÛÀÚ¼ö ´ëºñ ¿ÞÂÊ/¿À¸¥ÂÊ¿¡ ³²´Â ÀÚ¸´¼ö¿¡ 
--                              cÀÇ ¹®ÀÚ¸¦ Ã¤¿ö³Ö´Â´Ù

-- ==> L% : leftÀÇ¹Ì ,  R% : RightÀÇ¹Ì
-- ==> n:¼ýÀÚ , c : ±ÛÀÚ 1°³ , str:1°³ ÀÌ»ó ±Û 


SELECT lpad('SQL is cool!',20,'*')
  FROM dual 
; 
--°á°ú : ********SQL is cool!
-- ±ÛÀÚ´Â ÃÑ 12°³ ÀÎ´ë  20°ªÀ» ÁöÁ¤ÇÏ¿´±â¿¡ ³ª¸ÓÁö 8°ªÀ»  ¿ÞÂÊ¿¡ *À» ´ëÀÔÀ» ÇÑ´Ù.

SELECT rpad('SQL is cool!',20,'*')
  FROM dual 
; 
--°á°ú : SQL is cool!********

-------------------------------------------------------------------- 
-------9.LTRIM, RTRIM,TRIM :ÀÔ·ÂµÈ ¹®ÀÚ¿­ÀÇ  L,R,¾çÂÊ °ø¹éÀ» Á¦°Å 
SELECT '¡á' || '     sql is cool     ' || '¡á'
  FROM dual 
;
--°á°ú : ¡á     sql is cool     ¡á

SELECT '¡á' || ltrim('     sql is cool     ') || '¡á'
  FROM dual 
;
--°á°ú : ¡ásql is cool     ¡á

SELECT '¡á' || rtrim('     sql is cool     ') || '¡á'
  FROM dual 
;
--°á°ú : ¡á     sql is cool<

SELECT '¡á' || trim('     sql is cool     ') || '¡á'
  FROM dual 
;
--°á°ú : ¡ásql is cool¡á 



SELECT e.empno 
     , e.ename 
  FROM emp e 
 WHERE e.ename =trim(' SMITH  ') 
;
 -- 'SMITH' °ª¿¡  trim ÇÔ¼ö¸¦ Àû¿ëÇÏ¿© Á¶È¸¼º°ø 
 
 
--¹®Á¦ : ºñ±³°ªÀÌ '     smith  ' ÀÏ¶§ SMITHÀÇ Á¤º¸¸¦ Á¶È¸ÇÏ½Ã¿À 
SELECT e.empno 
     , e.ename 
  FROM emp e 
 WHERE e.ename = upper(trim(' smith  ')) 
 ;
 
 ---------------------------------------------------------------------------
 ------10.NVL(expr1, expr2) 
 --       NVL2(expr1, expr2, expr3_ 
 --       NVLLI(expr1,expr2)
 
 
 --NVL(expr1, expr2) :Ã¹¹øÂ° ½ÄÀÇ °ªÀÌ NULLÀÌ¸é µÎ¹øÂ° ½ÄÀ¸·Î ´ëÃ¼ÇÏ¿© Ãâ·Â 
 --¸Å´ÏÀú(mgr)°¡ ¹èÁ¤µÇÁö ¾ÊÀº Á÷¿øÀÇ °æ¿ì 0À¸·Î Ãâ·Â

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
 
 
 --¸Å´ÏÀú(mgr)dl ¹èÁ¤µÇÁö ¾ÊÀº Á÷¿øÀº '¸ÅÁöÀú ¾øÀ½'¶ó°í Ãâ·Â
SELECT e.empno 
     , e.ename
     , nvl(e.mgr, '¸Å´ÏÀú ¾øÀ½')
 FROM emp e
;

/*
ORA-01722: ¼öÄ¡°¡ ºÎÀûÇÕÇÕ´Ï´Ù
01722. 00000 -  "invalid number"

==> nvlÃ³¸® ´ë»ó ÄÃ¸²ÀÎ e.mgrÀº ¼ýÀÚÅ¸ÀÓÀÇ µ¥ÀÌÅÍ ÀÎµ¥ 
    null °ªÀ» ´ëÃ¼ÇÒ¶§ '¸Å´ÏÀú ¾øÀ½'Àº ¹®ÀÚÅ¸ÀÔÀÇ µ¥ÀÌÅÍ ÀÌ¹Ç·Î 
    º¯È¯½Ã mgrÄÃ·³ÀÇ Å¸ÀÔ°úºÒÀÏÄ¡ ÇÏ±â ¶§¹®¿¡ 
    ½ÇÇà½Ã ±¸¹® ¿À·ù°¡ ¹ß»ý
*/
 
SELECT e.empno 
     , e.ename
     , nvl(e.mgr || '','¸Å´ÏÀú ¾øÀ½')
 FROM emp e
;
 
/*
EMPNO, ENAME, NVL(E.MGR||'','¸Å´ÏÀú¾øÀ½') 
--------------------------------------------
9999	J_JAMES	¸Å´ÏÀú ¾øÀ½
8888	J%JAMES	¸Å´ÏÀú ¾øÀ½
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7839	KING	¸Å´ÏÀú ¾øÀ½
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
*/
 
-- ==> || °áÇÕ¿¬»êÀÚ·Î mgr¿¡ ºó¹®ÀÚ¸¦ ºÙ¿©¼­ ¹®ÀÚÅ¸ÀÔÀ¸·Î º¯°æ 
 
--¹®Á¦ : || ¿¬»êÀÚ ´ë½Å concar()ÇÔ¼ö¸¦ »ç¿ëÇÏ¿© °°Àº °á°ú¸¦ ³»½Ã¿À  
 
SELECT e.empno 
     , e.ename
     --, nvl(e.mgr,'¸Å´ÏÀú ¾øÀ½')
     , nvl(concat(e.mgr,''),'¸Å´ÏÀú ¾øÀ½')
 FROM emp e
; 
--==> '' ¿À¶óÅ¬¿¡¼­´Â null°ªÀ¸·Î ÀÎ½Ä

 
--NVL2(expr1, expr2, expr3) 
--     Ã¹¹øÂ° ½ÄÀÇ °ªÀÌ NOT NULLÀÌ¸é µÎ¹øÂ° ½ÄÀÇ °ªÀ¸·Î Ãâ·Â 
--                         NULLÀÌ¸é ¼¼¹øÂ° ½ÄÀÇ °ªÀ¸·Î Ãâ·Â 
  
--mgr°¡ ¹èÁ¤µÈ °æ¿ì·¹´Â '¸Å´ÏÀú ÀÖÀ½'À¸·Î 
--¸Å´ÏÀú°¡ ¹èÁ¤µÇÁö ¾ÊÀº °æ¿ì¿¡´Â '¸Å´ÏÀú ¾øÀ½'À¸·Î Ãâ·Â


SELECT e.empno 
     , e.ename
     , nvl2(e.mgr, '¸Å´ÏÀú ÀÖÀ½','¸Å´ÏÀú ¾øÀ½') "À¯/¹«"
 FROM emp e
;
/*
EMPNO, ENAME, À¯/¹«
---------------------------
9999	J_JAMES	¸Å´ÏÀú ¾øÀ½
8888	J%JAMES	¸Å´ÏÀú ¾øÀ½
7369	SMITH	¸Å´ÏÀú ÀÖÀ½
7499	ALLEN	¸Å´ÏÀú ÀÖÀ½
7521	WARD	¸Å´ÏÀú ÀÖÀ½
7566	JONES	¸Å´ÏÀú ÀÖÀ½
7654	MARTIN	¸Å´ÏÀú ÀÖÀ½
7698	BLAKE	¸Å´ÏÀú ÀÖÀ½
7782	CLARK	¸Å´ÏÀú ÀÖÀ½
7839	KING	¸Å´ÏÀú ¾øÀ½
7844	TURNER	¸Å´ÏÀú ÀÖÀ½
7900	JAMES	¸Å´ÏÀú ÀÖÀ½
7902	FORD	¸Å´ÏÀú ÀÖÀ½
7934	MILLER	¸Å´ÏÀú ÀÖÀ½
*/
-- ==>str2, str3 Çü½Ä(¼ýÀÚ, ¹®ÀÚ)ÀÌ Çü½ÄÀÌ °°¾Æ¾ß ÇÑ´Ù.



--¿À¶óÅ¬¿¡¼­ ºó¹®ÀÚ¿­('')À» NULL·Î Ãë±ÞÇÏ´Â °ÍÀ» 
-- È®ÀÎÇÏ±â À§ÇÑ ±¸¹® 
SELECT NVl2('','IS NOT NULL','IS NULL') 
  FROM dual 
;
--°á°ú : IS NULL

SELECT nvl2(' ','IS NOT NULL','IS NULL') 
  FROM dual 
; 
--°á°ú : IS NOT NULL
 
 
 --NULLIF(EXPR1,EXPR2) : 
 --Ã¹¹øÂ° ½Ä, µÎ¹øÂ° ½ÄÀÇ °ªÀÌ µ¿ÀÏÇÏ¸é NULLÀ» Ãâ·Â 
 --µÎ °ªÀÌ ´Ù¸£¸é Ã¹¹øÂ° ½ÄÀÇ °ªÀ» Ãâ·Â 
 
 SELECT NULLIF('AAA','BBB')  
   FROM dual
;
-- °á°ú : AAA 


 SELECT NULLIF('AAA','AAA')  
   FROM dual
;
-- °á°ú : (null)  ,  (null)°ªµµ 1ÇàÀÌ Á¸ÀçÇÑ´Ù (ÀÎÃâµÈ ¸ðµç Çà:0) °ú ´Ù¸£´Ù

----------------------------------------------------------------------------------------

------3) ³¯Â¥ ÇÔ¼ö : ³¯Â¥¿Í °ü·ÃµÈ Ãâ·Â/³¯Â¥ÀÇ ´õÇÏ±â »©±â µîÀÇ ¿¬»êÀ» ÇÒ¼öÀÖ´Â ±â´É Á¦°ø

--ÇöÀçÀÇ ½Ã½ºÅÛ ½Ã°£À» ¾ò´Â sysdataÇÔ¼ö 
SELECT sysdate 
  FROM dual 
;
-- °á°ú : 19/05/24 (yy/mm/dd)

--TO_CHAR(arg) : arg´Â ¼ýÀÚ³ª ³¯Â¥ Å¸ÀÔÀÇ µ¥¾îÅÍ°¡ µÉ¼öÀÖ´Ù.
--               ÀÔ·ÂµÈ arg¸¦ ¹®ÀÚÅ¸ÀÔÀ¸·Î º¯°æÇØÁÖ´Â ÇÔ¼ö 
--               to º¸³»´Ù , arg¸¦  char¹®ÀÚ·Î ¹Ù²Ù¾î¶ó
SELECT to_char(sysdate, 'YYYY') "³âµµ" 
  FROM dual 
;
--°á°ú : 2019

SELECT to_char(sysdate, 'YY') "³âµµ" 
  FROM dual 
;
--°á°ú :19

SELECT to_char(sysdate, 'MM') "¿ù" 
  FROM dual 
;
--°á°ú :05

SELECT to_char(sysdate, 'MON') "¿ù" 
  FROM dual 
;
--°á°ú :5¿ù 

SELECT to_char(sysdate, 'DD') "ÀÏ" 
  FROM dual 
; 
--°á°ú :5¿ù 

SELECT to_char(sysdate, 'D') "ÀÏ" 
  FROM dual 
; 
--°á°ú : 6 -- ±Ý¿äÀÏ ÀÇ¹Ì 


SELECT to_char(sysdate, 'Day') "ÀÏ" 
  FROM dual 
; 
--°á°ú : ±Ý¿äÀÏ


SELECT to_char(sysdate, 'Dy') "ÀÏ" 
  FROM dual 
; 
--°á°ú : ±Ý


SELECT to_char(sysdate, 'YYYY-MM-DD') "¿À´Ã³¯Â¥" 
  FROM dual 
; 
--°á°ú : 2019-05-24


SELECT to_char(sysdate, 'FMYYYY-MM-DD') "¿À´Ã³¯Â¥" 
  FROM dual 
; 
--°á°ú : 2019-5-24 
--=>fm À¯È¿ÇÏÁö ¾ÊÀº ³¯Â¥ Á¦°Å

SELECT to_char(sysdate, 'YYYY-MON-DD DAY') "¿À´Ã³¯Â¥" 
  FROM dual 
; 
--°á°ú : 2019-5¿ù -24 ±Ý¿äÀÏ



/*
½Ã°£ÆÐÅÏ: 
HH:½Ã°£À» 2ÀÚ¸® Ç¥½Ã
HI:ºÐÀ» µÎÀÚ¸®·Î Ç¥½Ã 
SS:ÃÊ¸¦ µÎÀÚ¸®¼Ò Ç¥½Ã
HH24:½Ã°£À» 24½Ã°£À¸·Î Ç¥±â 
AM:¿ÀÀüÀÎÁö ¿ÀÈÄ ÀÎÁö Ç¥±â
*/ 
SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') "¿À´Ã³¯Â¥ ½ÃºÐÃÊ" 
  FROM dual 
;
--°á°ú : 2019-05-24 15:32:45
-- ==> 24±îÁö Ç¥±âµÊ  

SELECT to_char(sysdate, 'YYYY-MM-DD AM HH:MI:SS') "¿À´Ã³¯Â¥ ½ÃºÐÃÊ" 
  FROM dual 
;
--°á°ú : 2019-05-24 ¿ÀÈÄ 03:43:02
-- ==> AM ¿ÀÀü/¿ÀÈÄ ±¸º°±¯ 


SELECT sysdate + 10  "10ÀÏÈÄ"
    ,  sysdate - 10  "10ÀÏÀü"
    ,  sysdate + 10/24 "10½Ã°£µÚ"
  FROM dual 
;
--°á°ú : 19/06/03	19/05/14	19/05/25

SELECT to_char(sysdate +10/24,'YYYY-MM-DD AM HH:MI:SS') "10½Ã°£µÚ"
  FROM dual 
;
--°á°ú : 2019-05-25 ¿ÀÀü 01:49:18


-----------------1.MONTHS_BETWEEN(³¯Â¥1, ³¯Â¥2)  
-------            µÎ ³¯Â¥ »çÀÌÀÇ ´ÞÀÇ Â÷ÀÌ
SELECT e.empno 
     , e.ename
     , MONTHS_BETWEEN(sysdate, e.hiredate) "±Ù¼Ó °³¿ù ¼ö" 
FROM emp e 
;

-- °¢ Á÷¿øÀÇ ±Ù¼Ó °³¿ù¼ö¸¦ ±¸ÇÏµÇ ¼Ò¼öÁ¡ 1ÀÇ ÀÚ¸®±îÁö¸¸ ±¸ÇÏ±â 

SELECT e.empno 
     , e.ename
     , ROUND((MONTHS_BETWEEN(sysdate, e.hiredate)),2) "±Ù¼Ó °³¿ù ¼ö"
  FROM emp e 
;

-----------------------------------------------------------------------------
---------------2.ADD_MONTHS(³¯Â¥, ¼ýÀÚ) : 
--                ³¯Â¥¿¡ ¼ý¤µÀÚ¸¦ ´õÇÑ ¸¸Å­ ÈÖÀÇ ³¯Â¥¸¦ ±¸ÇÔ 
SELECT add_months(sysdate, 3)
  FROM dual 
;
--°á°ú : 19/08/24

-- ³¯Â¥ + ¼ýÀÚ : ¼ýÀÚ ¸¸Å­ÀÇ ³¯ ¼ö¸¦ ´õÇÏ¿© ³¯Â¥¸¦ ±¸ÇÔ 
-- ³¯Â¥ + ¼ýÀÚ/24 : ¼ýÀÚ ¸¸Å­ÀÇ ½Ã°£À» ´õÇÏ¿© ³¯Â¥¸¦ ±¸ÇÔ
-- ADD_MONTHS(³¯Â¥,¼ýÀÚ) ¼ýÀÚ ¸¸Å­ÀÇ ´ÞÀ» ´õÇÏ¿© ³¯Â¥¸¦ ±¸ÇÔ

---------------------------------------------------------------------------------- 
-----------3.NEXT_DAY, LAST_DAY 
-- ´ÙÀ½ ¿äÀÏ¿¡ ÇØ´çÇÏ´Â ³¯Â¥¸¦ ±¸ÇÔ 
-- ÀÌ´ÞÀÇ ¸¶Áö¸· ³¯Â¥¸¦ ±¸ÇÔ

--ÇöÀç ³¯Â¥¿¡¼­ µ¹¾Æ¿À´Â ¼ö(4)¿äÀÏÀÇ ³¯Â¥¸¦ ±¸ÇÔ
SELECT next_day(sysdate,4) "µ¹¾Æ¿À´Â ¼ö¿äÀÏ"
     , next_day(sysdate,'¼ö¿äÀÏ') "µ¹¾Æ¿À´Â ¼ö¿äÀÏ2" 
     , last_day(sysdate) "ÀÌ´ÞÀÇ ¸¶Áö¸· ³¯"
  FROM dual 
;
/*
µ¹¾Æ¿À´Â ¼ö¿äÀÏ, µ¹¾Æ¿À´Â ¼ö¿äÀÏ2, ÀÌ´ÞÀÇ ¸¶Áö¸· ³¯ 
------------------------------------
19/05/29	19/05/29	19/05/31
*/
-- ==> DAY°³³äÀº ¿äÀÏÀÌ´Ù

---------------------------------------------------------------------------------- 
-----------4.ROUND, TRUNC :³¯Â¥¿¡ ´ëÇÑ ¹Ý¿Ã¸², ¹ö¸² ¿¬»ê 
SELECT round(sysdate) "ÇöÀç ½Ã°£¿¡¼­ ¹Ý¿Ã¸²" 
  FROM dual 
; 

--¹®Á¦ : ÇöÀç ½Ã°£¿¡¼­ ¹Ý¿Ã¸² µÈ ³¯ÀÚ¸¦ ½Ã/ºÐ/ÃÊ ±îÁö Ãâ·Â 
SELECT to_char(round(sysdate),'DD HH:MI:SS') "ÇöÀç ½Ã°£¿¡¼­ ¹Ý¿Ã¸²" 
  FROM dual 
; 
-- °á°ú : ÇÏ·çµÚ 00½Ã °á°ú

SELECT to_char(trunc(sysdate),'DD HH:MI:SS') "ÇöÀç ½Ã°£¿¡¼­ ¹Ý¿Ã¸²" 
  FROM dual 
; 
-- °á°ú : ¿À´Ã 00½Ã °á°ú


