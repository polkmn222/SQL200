-- EXAM126
CREATE  TABLE  CANCER
( 암종       VARCHAR2(50),   
  질병코드   VARCHAR2(20),
  환자수     NUMBER(10),
  성별       VARCHAR2(20),
  조유병률   NUMBER(10,2),     
  생존률    NUMBER(10,2) );

-- EXAM127  
CREATE TABLE SPEECH
( SPEECH_TEXT  VARCHAR2(1000) );

-- EXAM127-2
SELECT count(*) FROM speech;

-- EXAM127-3
SELECT REGEXP_SUBSTR('I never graduated from college', '[^ ]+', 1, 2) word
  FROM dual;

-- EXAM127-4
SELECT REGEXP_SUBSTR(lower(speech_text), '[^ ]+', 1, a) word
  FROM speech,  ( SELECT level a
                   FROM dual
                   CONNECT BY level <= 52);

-- EXAM127-5
SELECT word, count(*)
 FROM (
        SELECT REGEXP_SUBSTR(lower(speech_text), '[^ ]+', 1, a) word
            FROM speech,  ( SELECT level a
                              FROM dual
                              CONNECT BY level <= 52)
         )
 WHERE word is not null
 GROUP BY word
 ORDER BY count(*) desc;

-- EXAM128
CREATE TABLE POSITIVE ( P_TEXT  VARCHAR2(2000) );
CREATE TABLE NEGATIVE ( N_TEXT  VARCHAR2(2000) );

-- EXAM128-2
CREATE OR REPLACE  VIEW SPEECH_VIEW
AS
SELECT REGEXP_SUBSTR(lower(speech_text), '[^ ]+', 1, a) word
            FROM speech,  ( SELECT level a
                                    FROM dual
                                    CONNECT BY level <= 52);

-- EXAM128-3
SELECT count(word) as 긍정단어
    FROM speech_view
    WHERE lower(word) IN ( SELECT lower(p_text)
                             FROM positive );

-- EXAM128-4
SELECT count(word) as 부정단어
  FROM speech_view
  WHERE lower(word) IN ( SELECT lower(n_text)
                           FROM negative);


-- EXAM129
DROP TABLE CRIME_DAY;

CREATE TABLE CRIME_DAY
( CRIME_TYPE  VARCHAR2(50),
  SUN_CNT    NUMBER(10),
  MON_CNT   NUMBER(10),
  TUE_CNT    NUMBER(10),
  WED_CNT   NUMBER(10),
  THU_CNT    NUMBER(10),
  FRI_CNT     NUMBER(10),
  SAT_CNT    NUMBER(10),
  UNKNOWN_CNT  NUMBER(10) );
  
-- EXAM129-2
CREATE TABLE CRIME_DAY_UNPIVOT
 AS
 SELECT *
   FROM CRIME_DAY
   UNPIVOT ( CNT FOR  DAY_CNT  IN ( SUN_CNT, MON_CNT, TUE_CNT, WED_CNT,
   THU_CNT, FRI_CNT, SAT_CNT) );
   
-- EXAM129-3

SELECT *
  FROM ( 
         SELECT DAY_CNT, CNT, RANK() OVER (ORDER BY CNT DESC) RNK
           FROM CRIME_DAY_UNPIVOT
           WHERE TRIM(CRIME_TYPE)='절도'
       )
WHERE  RNK = 1;

-- EXAM130
CREATE TABLE UNIVERSITY_FEE
(DIVISION       VARCHAR2(20),
 TYPE           VARCHAR2(20),
 UNIVERSITY     VARCHAR2(60),
 LOC            VARCHAR2(40),
 ADMISSION_CNT  NUMBER(20),
 ADMISSION_FEE   NUMBER(20),
 TUITION_FEE      NUMBER(20) ) ;
 
-- EXAM 130-2
SELECT *
 FROM ( 
   SELECT UNIVERSITY, TUITION_FEE , 
             RANK() OVER (ORDER BY TUITION_FEE DESC NULLS LAST) 순위
      FROM UNIVERSITY_FEE
      )
 WHERE 순위 =1 ;

-- EXAM 131
create  table price 
(  
P_SEQ	number(10),
M_SEQ	number(10),
M_NAME  varchar2(80),
A_SEQ	number(10),
A_NAME	varchar2(60),
A_UNIT	varchar2(40),
A_PRICE	number(10),
P_YEAR_MONTH	varchar2(30),
ADD_COL	     varchar2(180),
M_TYPE_CODE	varchar2(20),
M_TYPE_NAME	varchar2(20),
M_GU_CODE	varchar2(10),
M_GU_NAME	varchar2(30) );

-- EXAM131-2
SELECT A_NAME AS "상품", A_PRICE AS "가격", M_NAME AS "매장명"
FROM PRICE
WHERE A_PRICE = (SELECT MAX(A_PRICE)
                    FROM PRICE);
                    
-- EXAM132
drop table crime_loc;

create  table  crime_loc
( CRIME_TYPE     varchar2(50),
  C_LOC             varchar2(50),
  CNT             number(10) );


Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','아파트',25389);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','집',37787);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','고속도로',151);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','노상',62560);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','상점',29977);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','시장노점',1239);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','숙박업소',9203);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','병원',16053);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','사무실',8416);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','공장',3540);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','공사장',4003);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','창고',2329);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','역대합실',881);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','지하철',737);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','교통',2249);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','유흥접객업소',631);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','유원지',1532);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','학교',3203);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','금융기관',5888);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','의료기관',2719);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','종교기관',2293);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','산야',2393);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','해상',50);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','부대',81);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','구금장소',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','공지',366);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('절도','기타',44333);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','아파트',88);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','집',130);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','고속도로',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','노상',483);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','상점',1188);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','시장노점',21);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','숙박업소',11);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','병원',39);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','사무실',271);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','공장',177);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','공사장',41);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','창고',57);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','역대합실',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','지하철',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','교통',13);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','유흥접객업소',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','유원지',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','학교',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','금융기관',26);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','의료기관',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','종교기관',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','산야',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','해상',14);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','부대',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','구금장소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','공지',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('장물','기타',575);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','아파트',3122);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','집',3172);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','고속도로',32);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','노상',22193);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','상점',2054);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','시장노점',142);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','숙박업소',907);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','병원',3539);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','사무실',1183);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','공장',158);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','공사장',217);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','창고',67);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','역대합실',100);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','지하철',41);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','교통',101);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','유흥접객업소',45);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','유원지',115);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','학교',239);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','금융기관',176);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','의료기관',194);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','종교기관',159);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','산야',624);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','해상',87);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','부대',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','구금장소',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','공지',76);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('손괴','기타',11821);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','아파트',242);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','집',312);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','고속도로',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','노상',280);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','상점',23);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','시장노점',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','숙박업소',43);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','병원',87);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','사무실',40);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','공장',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','공사장',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','창고',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','역대합실',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','지하철',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','교통',9);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','유흥접객업소',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','유원지',13);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','학교',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','금융기관',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','의료기관',19);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','종교기관',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','산야',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','해상',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','부대',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','구금장소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','공지',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('살인','기타',131);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','아파트',372);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','집',528);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','고속도로',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','노상',1541);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','상점',487);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','시장노점',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','숙박업소',262);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','병원',275);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','사무실',128);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','공장',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','공사장',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','창고',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','역대합실',13);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','지하철',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','교통',33);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','유흥접객업소',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','유원지',55);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','학교',35);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','금융기관',23);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','의료기관',24);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','종교기관',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','산야',12);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','해상',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','부대',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','구금장소',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','공지',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강도','기타',552);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','아파트',354);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','집',450);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','고속도로',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','노상',293);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','상점',66);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','시장노점',9);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','숙박업소',61);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','병원',86);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','사무실',77);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','공장',39);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','공사장',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','창고',17);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','역대합실',7);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','지하철',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','교통',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','유흥접객업소',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','유원지',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','학교',19);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','금융기관',13);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','의료기관',25);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','종교기관',29);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','산야',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','해상',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','부대',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','구금장소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','공지',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('방화','기타',298);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','아파트',2371);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','집',2927);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','고속도로',18);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','노상',3488);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','상점',390);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','시장노점',26);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','숙박업소',2798);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','병원',1362);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','사무실',352);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','공장',26);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','공사장',12);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','창고',24);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','역대합실',298);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','지하철',1339);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','교통',551);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','유흥접객업소',65);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','유원지',227);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','학교',188);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','금융기관',17);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','의료기관',147);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','종교기관',64);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','산야',37);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','해상',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','부대',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','구금장소',14);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','공지',11);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('강간','기타',3184);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','아파트',7603);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','집',7407);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','고속도로',107);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','노상',50270);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','상점',3669);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','시장노점',573);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','숙박업소',2097);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','병원',14142);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','사무실',3526);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','공장',480);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','공사장',349);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','창고',43);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','역대합실',720);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','지하철',508);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','교통',864);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','유흥접객업소',159);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','유원지',1240);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','학교',590);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','금융기관',92);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','의료기관',949);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','종교기관',183);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','산야',105);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','해상',65);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','부대',28);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','구금장소',79);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','공지',31);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭행','기타',13701);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','아파트',5115);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','집',5335);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','고속도로',75);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','노상',29219);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','상점',1973);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','시장노점',434);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','숙박업소',1434);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','병원',9568);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','사무실',2925);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','공장',560);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','공사장',374);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','창고',59);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','역대합실',347);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','지하철',188);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','교통',378);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','유흥접객업소',139);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','유원지',835);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','학교',844);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','금융기관',55);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','의료기관',651);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','종교기관',196);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','산야',181);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','해상',31);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','부대',25);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','구금장소',149);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','공지',53);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('상해','기타',9642);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','아파트',403);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','집',640);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','고속도로',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','노상',624);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','상점',99);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','시장노점',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','숙박업소',41);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','병원',247);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','사무실',368);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','공장',17);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','공사장',13);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','창고',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','역대합실',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','지하철',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','교통',12);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','유흥접객업소',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','유원지',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','학교',23);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','금융기관',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','의료기관',46);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','종교기관',18);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','산야',10);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','해상',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','부대',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','구금장소',7);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','공지',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('협박','기타',690);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','아파트',218);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','집',180);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','고속도로',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','노상',2154);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','상점',152);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','시장노점',43);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','숙박업소',58);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','병원',382);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','사무실',489);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','공장',37);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','공사장',101);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','창고',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','역대합실',27);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','지하철',12);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','교통',25);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','유흥접객업소',19);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','유원지',124);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','학교',190);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','금융기관',51);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','의료기관',38);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','종교기관',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','산야',7);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','해상',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','부대',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','구금장소',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','공지',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('공갈','기타',898);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','아파트',31);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','집',31);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','고속도로',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','노상',84);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','상점',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','시장노점',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','숙박업소',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','병원',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','사무실',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','공장',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','공사장',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','창고',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','역대합실',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','지하철',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','교통',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','유흥접객업소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','유원지',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','학교',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','금융기관',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','의료기관',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','종교기관',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','산야',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','해상',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','부대',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','구금장소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','공지',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('약취와유인','기타',23);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','아파트',71);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','집',96);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','고속도로',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','노상',222);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','상점',19);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','시장노점',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','숙박업소',50);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','병원',31);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','사무실',43);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','공장',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','공사장',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','창고',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','역대합실',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','지하철',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','교통',19);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','유흥접객업소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','유원지',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','학교',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','금융기관',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','의료기관',47);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','종교기관',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','산야',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','해상',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','부대',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','구금장소',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','공지',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('체포와감금','기타',122);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','아파트',2640);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','집',3089);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','고속도로',53);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','노상',20769);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','상점',1177);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','시장노점',236);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','숙박업소',738);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','병원',7396);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','사무실',1482);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','공장',385);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','공사장',237);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','창고',25);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','역대합실',140);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','지하철',70);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','교통',116);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','유흥접객업소',108);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','유원지',788);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','학교',755);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','금융기관',30);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','의료기관',251);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','종교기관',122);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','산야',109);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','해상',14);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','부대',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','구금장소',18);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','공지',28);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('폭력행위등처벌에관한법률위반','기타',6620);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','아파트',241);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','집',348);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','고속도로',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','노상',17);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','상점',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','시장노점',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','숙박업소',590);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','병원',23);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','사무실',40);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','공장',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','공사장',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','창고',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','역대합실',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','지하철',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','교통',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','유흥접객업소',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','유원지',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','학교',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','금융기관',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','의료기관',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','종교기관',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','산야',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','해상',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','부대',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','구금장소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','공지',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('간통','기타',404);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','아파트',625);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','집',2693);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','고속도로',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','노상',105);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','상점',420);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','시장노점',30);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','숙박업소',156);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','병원',976);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','사무실',3706);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','공장',41);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','공사장',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','창고',44);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','역대합실',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','지하철',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','교통',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','유흥접객업소',75);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','유원지',47);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','학교',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','금융기관',13);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','의료기관',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','종교기관',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','산야',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','해상',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','부대',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','구금장소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','공지',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도박과복표','기타',4300);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','아파트',65);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','집',64);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','고속도로',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','노상',463);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','상점',53);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','시장노점',13);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','숙박업소',19);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','병원',171);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','사무실',35);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','공장',20);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','공사장',12);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','창고',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','역대합실',18);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','지하철',28);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','교통',11);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','유흥접객업소',91);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','유원지',49);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','학교',31);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','금융기관',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','의료기관',25);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','종교기관',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','산야',14);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','해상',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','부대',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','구금장소',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','공지',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('과실치사상','기타',208);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','아파트',56);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','집',41);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','고속도로',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','노상',379);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','상점',58);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','시장노점',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','숙박업소',54);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','병원',76);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','사무실',50);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','공장',337);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','공사장',403);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','창고',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','역대합실',20);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','지하철',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','교통',39);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','유흥접객업소',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','유원지',32);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','학교',28);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','금융기관',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','의료기관',586);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','종교기관',9);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','산야',47);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','해상',158);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','부대',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','구금장소',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','공지',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('업무상과실치사상','기타',381);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','아파트',242);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','집',354);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','고속도로',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','노상',171);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','상점',120);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','시장노점',7);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','숙박업소',58);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','병원',139);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','사무실',53);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','공장',196);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','공사장',28);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','창고',94);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','역대합실',10);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','지하철',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','교통',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','유흥접객업소',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','유원지',11);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','학교',27);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','금융기관',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','의료기관',7);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','종교기관',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','산야',49);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','해상',27);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','부대',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','구금장소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','공지',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('실화','기타',423);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','아파트',1254);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','집',2454);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','고속도로',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','노상',153);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','상점',141);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','시장노점',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','숙박업소',175);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','병원',197);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','사무실',279);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','공장',72);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','공사장',17);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','창고',26);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','역대합실',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','지하철',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','교통',7);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','유흥접객업소',9);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','유원지',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','학교',56);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','금융기관',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','의료기관',36);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','종교기관',65);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','산야',17);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','해상',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','부대',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','구금장소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','공지',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('주거침입','기타',586);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','아파트',17);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','집',24);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','고속도로',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','노상',27);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','상점',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','시장노점',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','숙박업소',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','병원',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','사무실',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','공장',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','공사장',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','창고',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','역대합실',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','지하철',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','교통',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','유흥접객업소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','유원지',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','학교',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','금융기관',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','의료기관',9);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','종교기관',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','산야',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','해상',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','부대',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','구금장소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','공지',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('유기','기타',30);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','아파트',142);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','집',11);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','고속도로',489);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','노상',196218);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','상점',55);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','시장노점',30);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','숙박업소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','병원',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','사무실',64);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','공장',11);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','공사장',18);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','창고',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','역대합실',14);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','지하철',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','교통',74);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','유흥접객업소',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','유원지',60);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','학교',24);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','금융기관',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','의료기관',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','종교기관',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','산야',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','해상',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','부대',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','구금장소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','공지',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('교통사고처리','기타',1123);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','아파트',65);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','집',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','고속도로',211);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','노상',42824);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','상점',25);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','시장노점',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','숙박업소',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','병원',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','사무실',76);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','공장',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','공사장',7);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','창고',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','역대합실',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','지하철',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','교통',14);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','유흥접객업소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','유원지',21);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','학교',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','금융기관',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','의료기관',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','종교기관',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','산야',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','해상',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','부대',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','구금장소',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','공지',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('도로교통법위반','기타',704);

commit;

-- EXAM132-2
SELECT *
  FROM ( SELECT c_loc, cnt, rank() over (order by cnt desc)  rnk
              FROM crime_loc
              WHERE crime_type='살인'
        )
  WHERE  rnk = 1;
  
-- EXAM133
CREATE TABLE CRIME_CAUSE
(범죄유형  VARCHAR2(30),
 생계형    NUMBER(10),
 유흥     NUMBER(10),
 도박     NUMBER(10),
 허영심    NUMBER(10),
 복수     NUMBER(10),
 해고     NUMBER(10),
 징벌     NUMBER(10),
 가정불화   NUMBER(10),
 호기심    NUMBER(10),
 유혹     NUMBER(10),
 사고     NUMBER(10),
 불만     NUMBER(10),
 부주의    NUMBER(10),
 기타     NUMBER(10) );

insert into crime_cause values( '살인',1,6,0,2,5,0,0,51,0,0,147,15,2,118);
 insert into crime_cause values( '살인미수',0,0,0,0,2,0,0,44,0,1,255,38,3,183);
 insert into crime_cause values( '강도',631,439,24,9,7,53,1,15,16,37,642,27,16,805);
 insert into crime_cause values( '강간강제추행',62,19,4,1,33,22,4,30,1026,974,5868,74,260,4614);
 insert into crime_cause values( '방화',6,0,0,0,1,2,1,97,62,0,547,124,40,339);
 insert into crime_cause values( '상해',26,6,2,4,6,42,18,1666,27,17,50503,1407,1035,22212);
 insert into crime_cause values( '폭행',43,15,1,4,5,51,117,1724,45,24,55814,1840,1383,24953);
 insert into crime_cause values( '체포감금',7,1,0,0,1,2,0,17,1,3,283,17,10,265);
 insert into crime_cause values( '협박',14,3,0,0,0,10,11,115,16,16,1255,123,35,1047);
 insert into crime_cause values( '약취유인',22,7,0,0,0,0,0,3,8,15,30,6,0,84);
 insert into crime_cause values( '폭력행위등',711,1125,12,65,75,266,42,937,275,181,52784,1879,1319,29067);
 insert into crime_cause values( '공갈',317,456,12,51,17,116,1,1,51,51,969,76,53,1769);
 insert into crime_cause values( '손괴',20,4,0,1,3,17,8,346,61,11,15196,873,817,8068);
 insert into crime_cause values( '직무유기',0,1,0,0,0,0,0,0,0,0,0,0,18,165);
 insert into crime_cause values( '직권남용',1,0,0,0,0,0,0,0,0,0,1,0,12,68);
 insert into crime_cause values( '증수뢰',25,1,1,2,5,1,0,0,0,10,4,0,21,422);
 insert into crime_cause values( '통화',15,11,0,1,1,0,0,0,6,2,5,0,2,44);
 insert into crime_cause values( '문서인장',454,33,8,10,37,165,0,16,684,159,489,28,728,6732);
 insert into crime_cause values( '유가증권인지',23,1,0,0,2,3,0,0,0,0,3,0,11,153);
 insert into crime_cause values( '사기',12518,2307,418,225,689,2520,17,47,292,664,3195,193,4075,60689);
 insert into crime_cause values( '횡령',1370,174,58,34,86,341,3,10,358,264,1273,23,668,8697);
 insert into crime_cause values( '배임',112,4,4,0,30,29,0,0,2,16,27,1,145,1969);
 insert into crime_cause values( '성풍속범죄',754,29,1,6,12,100,2,114,1898,312,1051,60,1266,6712);
 insert into crime_cause values( '도박범죄',1005,367,404,32,111,12969,4,8,590,391,2116,9,737,11167);
 insert into crime_cause values( '특별경제범죄',5313,91,17,28,293,507,31,75,720,194,9002,1206,6816,33508);
 insert into crime_cause values( '마약범죄',57,5,0,1,2,19,3,6,399,758,223,39,336,2195);
 insert into crime_cause values( '보건범죄',2723,10,6,4,63,140,1,6,5,56,225,6,2160,10661);
 insert into crime_cause values( '환경범죄',122,1,0,2,1,2,0,0,15,3,40,3,756,1574);
 insert into crime_cause values( '교통범죄',258,12,3,4,2,76,3,174,1535,1767,33334,139,182010,165428);
 insert into crime_cause values( '노동범죄',513,11,0,0,23,30,0,2,5,10,19,3,140,1251);
 insert into crime_cause values( '안보범죄',6,0,0,0,0,0,1,0,4,0,4,23,0,56);
 insert into crime_cause values( '선거범죄',27,0,0,3,1,0,2,1,7,15,70,43,128,948);
 insert into crime_cause values( '병역범죄',214,0,0,0,2,7,3,35,2,6,205,50,3666,11959);
 insert into crime_cause values( '기타',13872,512,35,55,552,2677,51,455,2537,1661,18745,1969,20957,87483);

commit;
 
-- EXAM133-2
CREATE TABLE CRIME_CAUSE2
AS
SELECT *
    FROM CRIME_CAUSE
    UNPIVOT ( CNT FOR TERM IN ( 생계형, 유흥, 도박, 허영심, 복수, 해고, 징벌, 가정불화, 호기심, 유혹, 사고, 불만, 부주의, 기타));

-- EXAM133-3
SELECT 범죄유형
    FROM CRIME_CAUSE2
    WHERE CNT = (SELECT MAX(CNT)
                    FROM CRIME_CAUSE2
                    WHERE TERM = '가정불화')
    AND TERM = '가정불화';
    
-- EXAM134
SELECT TERM AS 원인
    FROM CRIME_CAUSE2
    WHERE CNT = (SELECT MAX(CNT)
                    FROM CRIME_CAUSE2
                    WHERE 범죄유형 = '방화')
    AND 범죄유형 = '방화';
    
-- EXAM135
CREATE TABLE ACC_LOC_DATA
(ACC_LOC_NO         NUMBER(10),
 ACC_YEAR           NUMBER(10),
 ACC_TYPE           VARCHAR2(20),
 ACC_LOC_CODE       NUMBER(10),
 CIRY_NAME          VARCHAR2(50),
 ACC_LOC_NAME       VARCHAR2(200),
 ACC_CNT            NUMBER(10),
 AL_CNT             NUMBER(10),
 DEAD_CNT           NUMBER(10),
 M_INJURY_CNT       NUMBER(10),
 L_INJURY_CNT       NUMBER(10),
 H_INJURY_CNT       NUMBER(10),
 LAT                NUMBER(15, 8),
 LOT                NUMBER(15, 8),
 DATA_UPDATE_DATE   DATE);
 
-- EXAM135-2
SELECT *
    FROM (SELECT ACC_LOC_NAME AS 사고장소, ACC_CNT AS 사고건수,
                DENSE_RANK() OVER (ORDER BY ACC_CNT DESC NULLS LAST) AS 순위
            FROM ACC_LOC_DATA
            WHERE ACC_YEAR = 2017
        )
    WHERE 순위 <= 5;
    
-- EXAM136
CREATE TABLE CLOSING
(연도     NUMBER(10),
 미용실    NUMBER(10),
 양식집    NUMBER(10),
 일식집    NUMBER(10),
 치킨집    NUMBER(10),
 커피음료   NUMBER(10),
 한식음식점  NUMBER(10),
 호프간이주점 NUMBER(10));
 
-- EXAM136-2
SELECT 연도 "치킨집 폐업 연도", 치킨집 "건수"
    FROM (SELECT 연도, 치킨집,
                RANK() OVER(ORDER BY 치킨집 DESC) 순위
            FROM CLOSING)
    WHERE 순위 = 1;

-- EXAM137
CREATE TABLE WORKING_TIME
(COUNTRY        VARCHAR2(30),
    Y_2014      NUMBER(10),
    Y_2015      NUMBER(10),
    Y_2016      NUMBER(10),
    Y_2017      NUMBER(10),
    Y_2018      NUMBER(10) );
    
-- EXAM137-2
CREATE VIEW C_WORK_TIME
AS
SELECT *
    FROM WORKING_TIME
    UNPIVOT (CNT FOR Y_YEAR IN (Y_2014, Y_2015, Y_2016, Y_2017, Y_2018));
    
-- EXAM137-3
SELECT COUNTRY, CNT, RANK() OVER (ORDER BY CNT DESC) 순위
    FROM C_WORK_TIME
    WHERE Y_YEAR = 'Y_2018';
    
-- EXAM138
DROP  TABLE  CANCER;
CREATE TABLE CANCER
(암종         VARCHAR2(50),
 질병코드     VARCHAR2(20),
 환자수        NUMBER(10),
 성별         VARCHAR2(20),
 조유병률       NUMBER(10, 2),
 생존률        NUMBER(10, 2) );
 
-- EXAM138-2
SELECT DISTINCT(암종), 성별, 환자수
    FROM CANCER
    WHERE 환자수 = (SELECT MAX(환자수)
                    FROM CANCER
                    WHERE 성별 = '남자' AND 암종 != '모든암')
UNION ALL
SELECT DISTINCT(암종), 성별, 환자수
    FROM CANCER
    WHERE 환자수 = (SELECT MAX(환자수)
                    FROM CANCER
                    WHERE 성별 = '여자');
                    
-- EXAM139
SET SERVEROUTPUT ON
ACCEPT P_NUM1 PROMPT    '첫 번째 숫자를 입력하세요 ~ '
ACCEPT P_NUM2 PROMPT    '두 번째 숫자를 입력하세요 ~ '

DECLARE
        V_SUM   NUMBER(10);
BEGIN
        V_SUM := &P_NUM1 + &P_NUM2;
        
        DBMS_OUTPUT.PUT_LINE('총합은: ' || V_SUM);
END;
/

-- EXAM140
SET SERVEROUTPUT ON
ACCEPT P_EMPNO PROMPT   '사원 번호를 입력하세요 ~ '
    DECLARE
            V_SAL   NUMBER(10);
    BEGIN
            SELECT SAL INTO V_SAL
                FROM EMP
                WHERE EMPNO = &P_EMPNO;
    DBMS_OUTPUT.PUT_LINE('해당 사원의 월급은 ' || V_SAL);

END;
/

-- EXAM141
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCCEPT  P_NUM  PROMPT  '숫자를 입력하세요 ~ '
BEGIN
    IF  MOD(&P_NUM, 2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('짝수입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('홀수입니다.');
    END IF;
END;
/

-- EXAM142
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCCEPT P_ENAME  PROMPT  '사원 이름을 입력합니다 ~ '
DECLARE
    V_ENAME EMP.ENAME%TYPE := UPPER('&P_ENAME');
    V_SAL   EMP.SAL%TYPE;
    
BEGIN
    SELECT SAL INTO V_SAL
        FROM EMP
        WHERE ENAME = V_ENAME;
        
    IF V_SAL >= 3000 THEN
            DBMS_OUTPUT.PUT_LINE('고소득자입니다.');
    ELSIF V_SAL >= 2000 THEN
            DBMS_OUTPUT.PUT_LINE('중간 소득자입니다.');
    ELSE
            DBMS_OUTPUT.PUT_LINE('저소득자입니다.');
    END IF;
END;
/

-- EXAM143
DECLARE
        V_COUNT NUMBER(10) := 0;
BEGIN
    LOOP
        V_COUNT := V_COUNT +1;
        DBMS_OUTPUT.PUT_LINE('2 X ' || V_COUNT || ' = ' || 2 * V_COUNT);
        EXIT WHEN V_COUNT = 9;
    END LOOP;
END;
/
