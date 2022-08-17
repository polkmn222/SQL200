-- EXAM126
CREATE  TABLE  CANCER
( ����       VARCHAR2(50),   
  �����ڵ�   VARCHAR2(20),
  ȯ�ڼ�     NUMBER(10),
  ����       VARCHAR2(20),
  ��������   NUMBER(10,2),     
  ������    NUMBER(10,2) );

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
SELECT count(word) as �����ܾ�
    FROM speech_view
    WHERE lower(word) IN ( SELECT lower(p_text)
                             FROM positive );

-- EXAM128-4
SELECT count(word) as �����ܾ�
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
           WHERE TRIM(CRIME_TYPE)='����'
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
             RANK() OVER (ORDER BY TUITION_FEE DESC NULLS LAST) ����
      FROM UNIVERSITY_FEE
      )
 WHERE ���� =1 ;

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
SELECT A_NAME AS "��ǰ", A_PRICE AS "����", M_NAME AS "�����"
FROM PRICE
WHERE A_PRICE = (SELECT MAX(A_PRICE)
                    FROM PRICE);
                    
-- EXAM132
drop table crime_loc;

create  table  crime_loc
( CRIME_TYPE     varchar2(50),
  C_LOC             varchar2(50),
  CNT             number(10) );


Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����Ʈ',25389);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��',37787);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��ӵ���',151);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',62560);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',29977);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',1239);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���ھ���',9203);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',16053);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�繫��',8416);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',3540);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',4003);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','â��',2329);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�����ս�',881);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����ö',737);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',2249);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������������',631);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',1532);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�б�',3203);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',5888);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�Ƿ���',2719);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',2293);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',2393);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�ػ�',50);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�δ�',81);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',366);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��Ÿ',44333);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','����Ʈ',88);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','��',130);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','��ӵ���',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','���',483);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','����',1188);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','�������',21);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','���ھ���',11);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','����',39);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','�繫��',271);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','����',177);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','������',41);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','â��',57);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','�����ս�',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','����ö',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','����',13);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','������������',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','������',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','�б�',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','�������',26);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','�Ƿ���',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','�������',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','���',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','�ػ�',14);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','�δ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','����',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�幰','��Ÿ',575);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','����Ʈ',3122);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','��',3172);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','��ӵ���',32);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','���',22193);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','����',2054);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','�������',142);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','���ھ���',907);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','����',3539);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','�繫��',1183);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','����',158);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','������',217);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','â��',67);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','�����ս�',100);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','����ö',41);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','����',101);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','������������',45);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','������',115);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','�б�',239);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','�������',176);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','�Ƿ���',194);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','�������',159);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','���',624);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','�ػ�',87);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','�δ�',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','�������',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','����',76);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ձ�','��Ÿ',11821);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����Ʈ',242);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��',312);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��ӵ���',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',280);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',23);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���ھ���',43);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',87);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�繫��',40);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','â��',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�����ս�',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����ö',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',9);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������������',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',13);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�б�',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�Ƿ���',19);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�ػ�',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�δ�',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��Ÿ',131);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����Ʈ',372);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��',528);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��ӵ���',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',1541);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',487);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���ھ���',262);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',275);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�繫��',128);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','â��',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�����ս�',13);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����ö',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',33);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������������',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',55);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�б�',35);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',23);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�Ƿ���',24);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',12);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�ػ�',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�δ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��Ÿ',552);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','����Ʈ',354);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','��',450);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','��ӵ���',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','���',293);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','����',66);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�������',9);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','���ھ���',61);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','����',86);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�繫��',77);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','����',39);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','������',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','â��',17);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�����ս�',7);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','����ö',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','����',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','������������',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','������',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�б�',19);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�������',13);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�Ƿ���',25);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�������',29);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','���',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�ػ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�δ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','����',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','��Ÿ',298);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����Ʈ',2371);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��',2927);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��ӵ���',18);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',3488);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',390);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',26);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���ھ���',2798);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',1362);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�繫��',352);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',26);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',12);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','â��',24);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�����ս�',298);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����ö',1339);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',551);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������������',65);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',227);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�б�',188);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',17);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�Ƿ���',147);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',64);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',37);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�ػ�',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�δ�',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',14);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',11);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��Ÿ',3184);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����Ʈ',7603);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��',7407);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��ӵ���',107);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',50270);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',3669);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',573);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���ھ���',2097);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',14142);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�繫��',3526);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',480);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',349);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','â��',43);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�����ս�',720);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����ö',508);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',864);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������������',159);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',1240);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�б�',590);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',92);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�Ƿ���',949);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',183);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',105);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�ػ�',65);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�δ�',28);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',79);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',31);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��Ÿ',13701);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����Ʈ',5115);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��',5335);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��ӵ���',75);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',29219);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',1973);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',434);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���ھ���',1434);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',9568);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�繫��',2925);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',560);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',374);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','â��',59);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�����ս�',347);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����ö',188);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',378);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������������',139);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',835);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�б�',844);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',55);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�Ƿ���',651);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',196);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',181);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�ػ�',31);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�δ�',25);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',149);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',53);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��Ÿ',9642);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����Ʈ',403);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��',640);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��ӵ���',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',624);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',99);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���ھ���',41);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',247);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�繫��',368);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',17);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',13);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','â��',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�����ս�',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����ö',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',12);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������������',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�б�',23);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�Ƿ���',46);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',18);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',10);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�ػ�',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�δ�',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',7);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��Ÿ',690);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����Ʈ',218);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��',180);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��ӵ���',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',2154);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',152);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',43);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���ھ���',58);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',382);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�繫��',489);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',37);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',101);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','â��',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�����ս�',27);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����ö',12);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',25);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������������',19);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',124);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�б�',190);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',51);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�Ƿ���',38);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',7);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�ػ�',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�δ�',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��Ÿ',898);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','����Ʈ',31);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','��',31);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','��ӵ���',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','���',84);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','����',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','���ھ���',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','����',8);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','�繫��',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','����',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','â��',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','�����ս�',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','����ö',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','����',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','������������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','������',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','�б�',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','�Ƿ���',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','���',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','�ػ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','�δ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','����',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������','��Ÿ',23);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','����Ʈ',71);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','��',96);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','��ӵ���',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','���',222);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','����',19);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','�������',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','���ھ���',50);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','����',31);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','�繫��',43);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','����',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','������',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','â��',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','�����ս�',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','����ö',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','����',19);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','������������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','������',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','�б�',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','�������',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','�Ƿ���',47);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','�������',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','���',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','�ػ�',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','�δ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','�������',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','����',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('ü���Ͱ���','��Ÿ',122);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','����Ʈ',2640);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','��',3089);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','��ӵ���',53);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','���',20769);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','����',1177);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','�������',236);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','���ھ���',738);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','����',7396);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','�繫��',1482);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','����',385);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','������',237);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','â��',25);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','�����ս�',140);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','����ö',70);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','����',116);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','������������',108);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','������',788);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','�б�',755);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','�������',30);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','�Ƿ���',251);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','�������',122);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','���',109);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','�ػ�',14);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','�δ�',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','�������',18);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','����',28);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����������ó�������ѹ�������','��Ÿ',6620);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����Ʈ',241);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��',348);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��ӵ���',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',17);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���ھ���',590);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',23);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�繫��',40);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','â��',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�����ս�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����ö',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������������',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�б�',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�Ƿ���',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�ػ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�δ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��Ÿ',404);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','����Ʈ',625);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','��',2693);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','��ӵ���',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','���',105);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','����',420);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','�������',30);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','���ھ���',156);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','����',976);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','�繫��',3706);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','����',41);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','������',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','â��',44);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','�����ս�',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','����ö',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','����',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','������������',75);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','������',47);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','�б�',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','�������',13);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','�Ƿ���',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','�������',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','���',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','�ػ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','�δ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','����',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���ڰ���ǥ','��Ÿ',4300);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','����Ʈ',65);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','��',64);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','��ӵ���',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','���',463);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','����',53);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','�������',13);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','���ھ���',19);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','����',171);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','�繫��',35);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','����',20);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','������',12);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','â��',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','�����ս�',18);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','����ö',28);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','����',11);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','������������',91);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','������',49);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','�б�',31);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','�������',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','�Ƿ���',25);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','�������',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','���',14);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','�ػ�',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','�δ�',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','�������',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','����',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����ġ���','��Ÿ',208);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','����Ʈ',56);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','��',41);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','��ӵ���',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','���',379);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','����',58);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','�������',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','���ھ���',54);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','����',76);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','�繫��',50);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','����',337);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','������',403);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','â��',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','�����ս�',20);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','����ö',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','����',39);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','������������',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','������',32);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','�б�',28);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','�������',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','�Ƿ���',586);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','�������',9);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','���',47);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','�ػ�',158);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','�δ�',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','�������',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','����',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���������ġ���','��Ÿ',381);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','����Ʈ',242);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','��',354);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','��ӵ���',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','���',171);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','����',120);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�������',7);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','���ھ���',58);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','����',139);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�繫��',53);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','����',196);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','������',28);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','â��',94);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�����ս�',10);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','����ö',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','����',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','������������',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','������',11);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�б�',27);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�������',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�Ƿ���',7);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�������',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','���',49);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�ػ�',27);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�δ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','����',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('��ȭ','��Ÿ',423);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','����Ʈ',1254);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','��',2454);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','��ӵ���',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','���',153);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','����',141);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','�������',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','���ھ���',175);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','����',197);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','�繫��',279);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','����',72);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','������',17);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','â��',26);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','�����ս�',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','����ö',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','����',7);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','������������',9);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','������',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','�б�',56);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','�������',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','�Ƿ���',36);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','�������',65);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','���',17);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','�ػ�',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','�δ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','����',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('�ְ�ħ��','��Ÿ',586);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����Ʈ',17);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��',24);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��ӵ���',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',27);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���ھ���',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�繫��',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','â��',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�����ս�',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����ö',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','������',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�б�',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�Ƿ���',9);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','���',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�ػ�',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�δ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','����',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('����','��Ÿ',30);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','����Ʈ',142);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','��',11);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','��ӵ���',489);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','���',196218);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','����',55);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','�������',30);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','���ھ���',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','����',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','�繫��',64);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','����',11);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','������',18);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','â��',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','�����ս�',14);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','����ö',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','����',74);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','������������',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','������',60);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','�б�',24);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','�Ƿ���',16);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','�������',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','���',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','�ػ�',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','�δ�',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','����',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('������ó��','��Ÿ',1123);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','����Ʈ',65);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','��',15);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','��ӵ���',211);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','���',42824);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','����',25);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','�������',6);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','���ھ���',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','����',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','�繫��',76);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','����',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','������',7);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','â��',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','�����ս�',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','����ö',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','����',14);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','������������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','������',21);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','�б�',5);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','�������',2);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','�Ƿ���',4);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','���',1);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','�ػ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','�δ�',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','�������',0);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','����',3);
Insert into CRIME_LOC (CRIME_TYPE,C_LOC,CNT) values ('���α��������','��Ÿ',704);

commit;

-- EXAM132-2
SELECT *
  FROM ( SELECT c_loc, cnt, rank() over (order by cnt desc)  rnk
              FROM crime_loc
              WHERE crime_type='����'
        )
  WHERE  rnk = 1;
  
-- EXAM133
CREATE TABLE CRIME_CAUSE
(��������  VARCHAR2(30),
 ������    NUMBER(10),
 ����     NUMBER(10),
 ����     NUMBER(10),
 �㿵��    NUMBER(10),
 ����     NUMBER(10),
 �ذ�     NUMBER(10),
 ¡��     NUMBER(10),
 ������ȭ   NUMBER(10),
 ȣ���    NUMBER(10),
 ��Ȥ     NUMBER(10),
 ���     NUMBER(10),
 �Ҹ�     NUMBER(10),
 ������    NUMBER(10),
 ��Ÿ     NUMBER(10) );

insert into crime_cause values( '����',1,6,0,2,5,0,0,51,0,0,147,15,2,118);
 insert into crime_cause values( '���ι̼�',0,0,0,0,2,0,0,44,0,1,255,38,3,183);
 insert into crime_cause values( '����',631,439,24,9,7,53,1,15,16,37,642,27,16,805);
 insert into crime_cause values( '������������',62,19,4,1,33,22,4,30,1026,974,5868,74,260,4614);
 insert into crime_cause values( '��ȭ',6,0,0,0,1,2,1,97,62,0,547,124,40,339);
 insert into crime_cause values( '����',26,6,2,4,6,42,18,1666,27,17,50503,1407,1035,22212);
 insert into crime_cause values( '����',43,15,1,4,5,51,117,1724,45,24,55814,1840,1383,24953);
 insert into crime_cause values( 'ü������',7,1,0,0,1,2,0,17,1,3,283,17,10,265);
 insert into crime_cause values( '����',14,3,0,0,0,10,11,115,16,16,1255,123,35,1047);
 insert into crime_cause values( '��������',22,7,0,0,0,0,0,3,8,15,30,6,0,84);
 insert into crime_cause values( '����������',711,1125,12,65,75,266,42,937,275,181,52784,1879,1319,29067);
 insert into crime_cause values( '����',317,456,12,51,17,116,1,1,51,51,969,76,53,1769);
 insert into crime_cause values( '�ձ�',20,4,0,1,3,17,8,346,61,11,15196,873,817,8068);
 insert into crime_cause values( '��������',0,1,0,0,0,0,0,0,0,0,0,0,18,165);
 insert into crime_cause values( '���ǳ���',1,0,0,0,0,0,0,0,0,0,1,0,12,68);
 insert into crime_cause values( '������',25,1,1,2,5,1,0,0,0,10,4,0,21,422);
 insert into crime_cause values( '��ȭ',15,11,0,1,1,0,0,0,6,2,5,0,2,44);
 insert into crime_cause values( '��������',454,33,8,10,37,165,0,16,684,159,489,28,728,6732);
 insert into crime_cause values( '������������',23,1,0,0,2,3,0,0,0,0,3,0,11,153);
 insert into crime_cause values( '���',12518,2307,418,225,689,2520,17,47,292,664,3195,193,4075,60689);
 insert into crime_cause values( 'Ⱦ��',1370,174,58,34,86,341,3,10,358,264,1273,23,668,8697);
 insert into crime_cause values( '����',112,4,4,0,30,29,0,0,2,16,27,1,145,1969);
 insert into crime_cause values( '��ǳ�ӹ���',754,29,1,6,12,100,2,114,1898,312,1051,60,1266,6712);
 insert into crime_cause values( '���ڹ���',1005,367,404,32,111,12969,4,8,590,391,2116,9,737,11167);
 insert into crime_cause values( 'Ư����������',5313,91,17,28,293,507,31,75,720,194,9002,1206,6816,33508);
 insert into crime_cause values( '�������',57,5,0,1,2,19,3,6,399,758,223,39,336,2195);
 insert into crime_cause values( '���ǹ���',2723,10,6,4,63,140,1,6,5,56,225,6,2160,10661);
 insert into crime_cause values( 'ȯ�����',122,1,0,2,1,2,0,0,15,3,40,3,756,1574);
 insert into crime_cause values( '�������',258,12,3,4,2,76,3,174,1535,1767,33334,139,182010,165428);
 insert into crime_cause values( '�뵿����',513,11,0,0,23,30,0,2,5,10,19,3,140,1251);
 insert into crime_cause values( '�Ⱥ�����',6,0,0,0,0,0,1,0,4,0,4,23,0,56);
 insert into crime_cause values( '���Ź���',27,0,0,3,1,0,2,1,7,15,70,43,128,948);
 insert into crime_cause values( '��������',214,0,0,0,2,7,3,35,2,6,205,50,3666,11959);
 insert into crime_cause values( '��Ÿ',13872,512,35,55,552,2677,51,455,2537,1661,18745,1969,20957,87483);

commit;
 
-- EXAM133-2
CREATE TABLE CRIME_CAUSE2
AS
SELECT *
    FROM CRIME_CAUSE
    UNPIVOT ( CNT FOR TERM IN ( ������, ����, ����, �㿵��, ����, �ذ�, ¡��, ������ȭ, ȣ���, ��Ȥ, ���, �Ҹ�, ������, ��Ÿ));

-- EXAM133-3
SELECT ��������
    FROM CRIME_CAUSE2
    WHERE CNT = (SELECT MAX(CNT)
                    FROM CRIME_CAUSE2
                    WHERE TERM = '������ȭ')
    AND TERM = '������ȭ';
    
-- EXAM134
SELECT TERM AS ����
    FROM CRIME_CAUSE2
    WHERE CNT = (SELECT MAX(CNT)
                    FROM CRIME_CAUSE2
                    WHERE �������� = '��ȭ')
    AND �������� = '��ȭ';
    
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
    FROM (SELECT ACC_LOC_NAME AS ������, ACC_CNT AS ���Ǽ�,
                DENSE_RANK() OVER (ORDER BY ACC_CNT DESC NULLS LAST) AS ����
            FROM ACC_LOC_DATA
            WHERE ACC_YEAR = 2017
        )
    WHERE ���� <= 5;
    
-- EXAM136
CREATE TABLE CLOSING
(����     NUMBER(10),
 �̿��    NUMBER(10),
 �����    NUMBER(10),
 �Ͻ���    NUMBER(10),
 ġŲ��    NUMBER(10),
 Ŀ������   NUMBER(10),
 �ѽ�������  NUMBER(10),
 ȣ���������� NUMBER(10));
 
-- EXAM136-2
SELECT ���� "ġŲ�� ��� ����", ġŲ�� "�Ǽ�"
    FROM (SELECT ����, ġŲ��,
                RANK() OVER(ORDER BY ġŲ�� DESC) ����
            FROM CLOSING)
    WHERE ���� = 1;

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
SELECT COUNTRY, CNT, RANK() OVER (ORDER BY CNT DESC) ����
    FROM C_WORK_TIME
    WHERE Y_YEAR = 'Y_2018';
    
-- EXAM138
DROP  TABLE  CANCER;
CREATE TABLE CANCER
(����         VARCHAR2(50),
 �����ڵ�     VARCHAR2(20),
 ȯ�ڼ�        NUMBER(10),
 ����         VARCHAR2(20),
 ��������       NUMBER(10, 2),
 ������        NUMBER(10, 2) );
 
-- EXAM138-2
SELECT DISTINCT(����), ����, ȯ�ڼ�
    FROM CANCER
    WHERE ȯ�ڼ� = (SELECT MAX(ȯ�ڼ�)
                    FROM CANCER
                    WHERE ���� = '����' AND ���� != '����')
UNION ALL
SELECT DISTINCT(����), ����, ȯ�ڼ�
    FROM CANCER
    WHERE ȯ�ڼ� = (SELECT MAX(ȯ�ڼ�)
                    FROM CANCER
                    WHERE ���� = '����');
                    
-- EXAM139
SET SERVEROUTPUT ON
ACCEPT P_NUM1 PROMPT    'ù ��° ���ڸ� �Է��ϼ��� ~ '
ACCEPT P_NUM2 PROMPT    '�� ��° ���ڸ� �Է��ϼ��� ~ '

DECLARE
        V_SUM   NUMBER(10);
BEGIN
        V_SUM := &P_NUM1 + &P_NUM2;
        
        DBMS_OUTPUT.PUT_LINE('������: ' || V_SUM);
END;
/

-- EXAM140
SET SERVEROUTPUT ON
ACCEPT P_EMPNO PROMPT   '��� ��ȣ�� �Է��ϼ��� ~ '
    DECLARE
            V_SAL   NUMBER(10);
    BEGIN
            SELECT SAL INTO V_SAL
                FROM EMP
                WHERE EMPNO = &P_EMPNO;
    DBMS_OUTPUT.PUT_LINE('�ش� ����� ������ ' || V_SAL);

END;
/

-- EXAM141
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCCEPT  P_NUM  PROMPT  '���ڸ� �Է��ϼ��� ~ '
BEGIN
    IF  MOD(&P_NUM, 2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('¦���Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ȧ���Դϴ�.');
    END IF;
END;
/

-- EXAM142
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCCEPT P_ENAME  PROMPT  '��� �̸��� �Է��մϴ� ~ '
DECLARE
    V_ENAME EMP.ENAME%TYPE := UPPER('&P_ENAME');
    V_SAL   EMP.SAL%TYPE;
    
BEGIN
    SELECT SAL INTO V_SAL
        FROM EMP
        WHERE ENAME = V_ENAME;
        
    IF V_SAL >= 3000 THEN
            DBMS_OUTPUT.PUT_LINE('��ҵ����Դϴ�.');
    ELSIF V_SAL >= 2000 THEN
            DBMS_OUTPUT.PUT_LINE('�߰� �ҵ����Դϴ�.');
    ELSE
            DBMS_OUTPUT.PUT_LINE('���ҵ����Դϴ�.');
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
