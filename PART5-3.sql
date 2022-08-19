-- EXAM191
DROP TABLE DTSETTINGS;

CREATE TABLE DTSETTINGS
( SETTING_NAME    VARCHAR2 (200),
 SETTING_VALUE   VARCHAR2 (200) );

BEGIN

   INSERT INTO DTSETTINGS
     VALUES (DBMS_DATA_MINING.ALGO_NAME, 'ALGO_SUPPORT_VECTOR_MACHINES');

   INSERT INTO DTSETTINGS
      VALUES (DBMS_DATA_MINING.PREP_AUTO, 'ON');

   INSERT INTO DTSETTINGS
     VALUES (DBMS_DATA_MINING.SVMS_KERNEL_FUNCTION, 'SVMS_LINEAR');

COMMIT;
END;
/

BEGIN
  DBMS_DATA_MINING.DROP_MODEL('WC_MODEL');
END;
/

BEGIN
   DBMS_DATA_MINING.CREATE_MODEL (
      MODEL_NAME            => 'WC_MODEL',
      MINING_FUNCTION       => DBMS_DATA_MINING.CLASSIFICATION,
      DATA_TABLE_NAME       => 'WISC_BC_DATA_TRAINING',
      CASE_ID_COLUMN_NAME   => 'ID',
      TARGET_COLUMN_NAME    => 'DIAGNOSIS',
      SETTINGS_TABLE_NAME   => 'DTSETTINGS');
END;
/

SELECT MODEL_NAME,
          ALGORITHM,
          MINING_FUNCTION
  FROM ALL_MINING_MODELS
  WHERE MODEL_NAME = 'WC_MODEL';


SELECT SETTING_NAME, SETTING_VALUE
  FROM ALL_MINING_MODEL_SETTINGS
  WHERE MODEL_NAME = 'WC_MODEL';

DROP TABLE WC_DATA_TEST_MATRIX;
      
CREATE OR REPLACE VIEW   VIEW_WISC_BC_DATA_TEST
AS
SELECT ID, PREDICTION(WC_MODEL USING *) PREDICTED_VALUE,
          PREDICTION_PROBABILITY(WC_MODEL USING * ) PROBABILITY
  FROM WISC_BC_DATA_TEST;
  
set serveroutput on  
  
DECLARE
   V_ACCURACY NUMBER;
BEGIN
   DBMS_DATA_MINING.COMPUTE_CONFUSION_MATRIX (
      ACCURACY           => V_ACCURACY,
      APPLY_RESULT_TABLE_NAME => 'VIEW_WISC_BC_DATA_TEST',
      TARGET_TABLE_NAME       => 'WISC_BC_DATA_TEST',
      CASE_ID_COLUMN_NAME   => 'ID',
      TARGET_COLUMN_NAME   => 'DIAGNOSIS',
      CONFUSION_MATRIX_TABLE_NAME => 'WC_DATA_TEST_MATRIX',
      SCORE_COLUMN_NAME       => 'PREDICTED_VALUE',
      SCORE_CRITERION_COLUMN_NAME => 'PROBABILITY',
      COST_MATRIX_TABLE_NAME      => NULL,
      APPLY_RESULT_SCHEMA_NAME   => NULL,
      TARGET_SCHEMA_NAME       => NULL,
      COST_MATRIX_SCHEMA_NAME => NULL,
      SCORE_CRITERION_TYPE   => 'PROBABILITY');
   DBMS_OUTPUT.PUT_LINE('**** MODEL ACCURACY ****: ' || ROUND(V_ACCURACY,4));
END;
/

-- EXAM192
SET SERVEROUTPUT ON
SET VERIFY OFF

ACCEPT P_ID PROMPT '환자 번호를 입력하세요~ (예: 845636)'

DECLARE  
   V_PRED    VARCHAR2(20);
   V_PROB    NUMBER(10,2);

BEGIN

SELECT PREDICTION (WC_MODEL USING *),
          PREDICTION_PROBABILITY(WC_MODEL  USING * )  INTO V_PRED, V_PROB
  FROM WISC_BC_DATA_TEST
  WHERE ID = '&P_ID';

 IF V_PRED ='M' THEN 

   DBMS_OUTPUT.PUT_LINE('머신러닝이 예측한 결과: 유방암 환자입니다. 유방암일 확률은 ' || ROUND(V_PROB,2) * 100 || '%입니다');

 ELSE 
    DBMS_OUTPUT.PUT_LINE('머신러닝이 예측한 결과: 유방암 환자가 아닙니다. 유방암 환자가 아닐 확률은 ' || ROUND(V_PROB,2) * 100 || '%입니다');

 END IF;

END;
/

-- EXAM193
DROP TABLE STUDENT_SCORE;

CREATE TABLE STUDENT_SCORE
(  ST_ID        NUMBER(10),
  ACADEMIC   NUMBER(20,8),
  SPORTS      NUMBER(30,10),
  MUSIC       NUMBER(30,10),
 ACCEPTANCE  NUMBER(30,10) );


select count(*) from STUDENT_SCORE;

DROP TABLE STUDENT_SCORE_TRAINING; 

CREATE TABLE STUDENT_SCORE_TRAINING
AS
   SELECT *
     FROM STUDENT_SCORE
     WHERE ST_ID < 181;

DROP TABLE STUDENT_SCORE_TEST;

CREATE TABLE STUDENT_SCORE_TEST
AS
   SELECT *
     FROM STUDENT_SCORE
     WHERE ST_ID >= 181;



DROP TABLE SETTINGS_REG1;

CREATE TABLE SETTINGS_REG1
AS
SELECT *
     FROM TABLE (DBMS_DATA_MINING.GET_DEFAULT_SETTINGS)
     WHERE SETTING_NAME LIKE '%GLM%';

BEGIN

INSERT INTO SETTINGS_REG1
  VALUES (DBMS_DATA_MINING.ALGO_NAME, 'ALGO_GENERALIZED_LINEAR_MODEL');

INSERT INTO SETTINGS_REG1
  VALUES (DBMS_DATA_MINING.PREP_SCALE_2DNUM, 'PREP_SCALE_RANGE');

COMMIT;

END;
/



BEGIN
 DBMS_DATA_MINING.DROP_MODEL('MD_REG_MODEL1');
END;
/

BEGIN 
   DBMS_DATA_MINING.CREATE_MODEL(
      MODEL_NAME            => 'MD_REG_MODEL1',
      MINING_FUNCTION       => DBMS_DATA_MINING.REGRESSION,
      DATA_TABLE_NAME       => 'STUDENT_SCORE_TRAINING',
      CASE_ID_COLUMN_NAME   => 'ST_ID',
      TARGET_COLUMN_NAME    => 'ACCEPTANCE',
      SETTINGS_TABLE_NAME   => 'SETTINGS_REG1');
END;
/



SELECT MODEL_NAME,
          ALGORITHM,
          MINING_FUNCTION
  FROM ALL_MINING_MODELS
  WHERE MODEL_NAME = 'MD_REG_MODEL1';



SELECT SETTING_NAME, SETTING_VALUE
  FROM ALL_MINING_MODEL_SETTINGS
  WHERE MODEL_NAME = 'MD_REG_MODEL1';



SELECT ST_ID 학생번호, ACADEMIC 학과점수, ROUND(MUSIC,2) 음악점수 , 
          SPORTS 체육점수, ROUND(ACCEPTANCE,2) AS 실제점수, ROUND(MODEL_PREDICT_RESPONSE,2) AS 예측점수
 FROM ( 
           SELECT T.*, PREDICTION (MD_REG_MODEL1 USING *) MODEL_PREDICT_RESPONSE
             FROM STUDENT_SCORE_TEST T
      );



SELECT *
  FROM TABLE(DBMS_DATA_MINING.GET_MODEL_DETAILS_GLOBAL(MODEL_NAME =>  'MD_REG_MODEL1'))
  WHERE GLOBAL_DETAIL_NAME IN ('R_SQ','ADJUSTED_R_SQUARE');


SELECT ATTRIBUTE_NAME, COEFFICIENT
  FROM TABLE (DBMS_DATA_MINING.GET_MODEL_DETAILS_GLM ('MD_REG_MODEL1'));


-- EXAM194
DROP TABLE INSURANCE;

CREATE TABLE INSURANCE
( ID         NUMBER(10),
  AGE       NUMBER(3),
  SEX        VARCHAR2(10),
  BMI        NUMBER(10,2),
  CHILDREN  NUMBER(2),
  SMOKER    VARCHAR2(10),
  REGION    VARCHAR2(20), 
  EXPENSES  NUMBER(10,2) );

select count(*) from INSURANCE;


DROP TABLE INSURANCE_TRAINING; 

CREATE TABLE INSURANCE_TRAINING
AS
   SELECT *
     FROM INSURANCE
     WHERE ID < 1114;

DROP TABLE INSURANCE_TEST;

CREATE TABLE INSURANCE_TEST
AS
   SELECT *
     FROM INSURANCE
     WHERE ID >= 1114;


DROP TABLE SETTINGS_REG2;

CREATE TABLE SETTINGS_REG2
AS
SELECT *
  FROM TABLE (DBMS_DATA_MINING.GET_DEFAULT_SETTINGS)
  WHERE SETTING_NAME LIKE '%GLM%';

BEGIN

INSERT INTO SETTINGS_REG2
 VALUES (DBMS_DATA_MINING.ALGO_NAME,'ALGO_GENERALIZED_LINEAR_MODEL');

INSERT INTO SETTINGS_REG2
 VALUES (DBMS_DATA_MINING.PREP_AUTO, 'ON');

COMMIT;

END;
/

BEGIN
  DBMS_DATA_MINING.DROP_MODEL('MD_REG_MODEL2');
END;
/

BEGIN 

   DBMS_DATA_MINING.CREATE_MODEL(
      MODEL_NAME            => 'MD_REG_MODEL2',
      MINING_FUNCTION       => DBMS_DATA_MINING.REGRESSION,
      DATA_TABLE_NAME       => 'INSURANCE_TRAINING',
      CASE_ID_COLUMN_NAME   => 'ID',
      TARGET_COLUMN_NAME    => 'EXPENSES',
      SETTINGS_TABLE_NAME   => 'SETTINGS_REG2');
END;
/


SELECT MODEL_NAME,
          ALGORITHM,
          MINING_FUNCTION
  FROM ALL_MINING_MODELS
  WHERE MODEL_NAME = 'MD_REG_MODEL2';

SELECT SETTING_NAME, SETTING_VALUE
  FROM ALL_MINING_MODEL_SETTINGS
  WHERE MODEL_NAME = 'MD_REG_MODEL2';


SELECT ATTRIBUTE_NAME, ATTRIBUTE_VALUE, ROUND(COEFFICIENT)
  FROM TABLE (DBMS_DATA_MINING.GET_MODEL_DETAILS_GLM ('MD_REG_MODEL2'));


SELECT ID, AGE, SEX, EXPENSES, 
          ROUND(PREDICTION (MD_REG_MODEL2 USING *),2) MODEL_PREDICT_RESPONSE
  FROM INSURANCE_TEST T;

SELECT GLOBAL_DETAIL_NAME, ROUND(GLOBAL_DETAIL_VALUE,3)
  FROM
  TABLE(DBMS_DATA_MINING.GET_MODEL_DETAILS_GLOBAL(MODEL_NAME =>'MD_REG_MODEL2'))
  WHERE  GLOBAL_DETAIL_NAME IN ('R_SQ','ADJUSTED_R_SQUARE');

-- EXAM195
ALTER TABLE INSURANCE
  DROP COLUMN BMI30;

ALTER TABLE INSURANCE
  ADD BMI30 NUMBER(10);

UPDATE INSURANCE   I
   SET BMI30 = ( SELECT CASE WHEN BMI >= 30 AND SMOKER='yes'
                                THEN  1  ELSE  0  END 
                        FROM INSURANCE S
                        WHERE S.ROWID = I.ROWID) ;
COMMIT;


DROP TABLE INSURANCE_TRAINING; 

CREATE TABLE INSURANCE_TRAINING
AS
   SELECT *
     FROM INSURANCE
     WHERE ID < 1114;

DROP TABLE INSURANCE_TEST;

CREATE TABLE INSURANCE_TEST
AS
   SELECT *
     FROM INSURANCE
    WHERE ID >= 1114;


BEGIN
  DBMS_DATA_MINING.DROP_MODEL('MD_REG_MODEL3');
END;
/

BEGIN 

   DBMS_DATA_MINING.CREATE_MODEL(
      MODEL_NAME            => 'MD_REG_MODEL3',
      MINING_FUNCTION       => DBMS_DATA_MINING.REGRESSION,
      DATA_TABLE_NAME       => 'INSURANCE_TRAINING',
      CASE_ID_COLUMN_NAME   => 'ID',
      TARGET_COLUMN_NAME    => 'EXPENSES',
      SETTINGS_TABLE_NAME   => 'SETTINGS_REG2');
END;
/


SELECT MODEL_NAME,
          ALGORITHM,
          MINING_FUNCTION
  FROM ALL_MINING_MODELS
  WHERE MODEL_NAME = 'MD_REG_MODEL3';


SELECT ATTRIBUTE_NAME, ATTRIBUTE_VALUE, ROUND(COEFFICIENT)
  FROM 
  TABLE (DBMS_DATA_MINING.GET_MODEL_DETAILS_GLM ('MD_REG_MODEL3'));


SELECT GLOBAL_DETAIL_NAME, ROUND(GLOBAL_DETAIL_VALUE,3)
  FROM
  TABLE(DBMS_DATA_MINING.GET_MODEL_DETAILS_GLOBAL(MODEL_NAME =>'MD_REG_MODEL3'))
  WHERE  GLOBAL_DETAIL_NAME IN ('R_SQ','ADJUSTED_R_SQUARE');

-- EXAM196
ALTER TABLE INSURANCE
  DROP COLUMN AGE2;

ALTER TABLE INSURANCE
  ADD AGE2 NUMBER(10);

UPDATE INSURANCE
  SET AGE2 = AGE * AGE ;

COMMIT;


DROP TABLE INSURANCE_TRAINING; 

CREATE TABLE INSURANCE_TRAINING
AS
   SELECT *
     FROM INSURANCE
     WHERE ID < 1114;

DROP TABLE INSURANCE_TEST;

CREATE TABLE INSURANCE_TEST
AS
   SELECT *
     FROM INSURANCE
    WHERE ID >= 1114;


BEGIN
  DBMS_DATA_MINING.DROP_MODEL('MD_REG_MODEL4');
END;
/

BEGIN 

   DBMS_DATA_MINING.CREATE_MODEL(
      MODEL_NAME            => 'MD_REG_MODEL4',
      MINING_FUNCTION       => DBMS_DATA_MINING.REGRESSION,
      DATA_TABLE_NAME       => 'INSURANCE_TRAINING',
      CASE_ID_COLUMN_NAME   => 'ID',
      TARGET_COLUMN_NAME    => 'EXPENSES',
      SETTINGS_TABLE_NAME   => 'SETTINGS_REG2');
END;
/



SELECT MODEL_NAME,
          ALGORITHM,
          CREATION_DATE,
          MINING_FUNCTION
  FROM ALL_MINING_MODELS
  WHERE MODEL_NAME = 'MD_REG_MODEL4';



SELECT ATTRIBUTE_NAME, ATTRIBUTE_VALUE, ROUND(COEFFICIENT)
  FROM 
  TABLE (DBMS_DATA_MINING.GET_MODEL_DETAILS_GLM ('MD_REG_MODEL4'));


SELECT GLOBAL_DETAIL_NAME, ROUND(GLOBAL_DETAIL_VALUE,3)
  FROM TABLE (DBMS_DATA_MINING.GET_MODEL_DETAILS_GLOBAL(MODEL_NAME => 'MD_REG_MODEL4'))
  WHERE GLOBAL_DETAIL_NAME IN ('R_SQ','ADJUSTED_R_SQUARE');

-- EXAM197
DROP TABLE MARKET_TABLE; 

CREATE TABLE MARKET_TABLE
  ( CUST_ID         NUMBER(10),
    STOCK_CODE      NUMBER(10),
    STOCK_NAME      VARCHAR2(30),
    QUANTITY        NUMBER(10),
    STOCK_PRICE     NUMBER(10,2),
    BUY_DATE        DATE  );
        

select count(*) from market_table;


select * from market_table;


DROP TABLE SETTINGS_ASSOCIATION_RULES;

CREATE TABLE SETTINGS_ASSOCIATION_RULES
AS
   SELECT *
     FROM TABLE (DBMS_DATA_MINING.GET_DEFAULT_SETTINGS)
     WHERE SETTING_NAME LIKE 'ASSO_%';

BEGIN
   UPDATE SETTINGS_ASSOCIATION_RULES
      SET SETTING_VALUE = 3
      WHERE SETTING_NAME = DBMS_DATA_MINING.ASSO_MAX_RULE_LENGTH;

   UPDATE SETTINGS_ASSOCIATION_RULES
      SET SETTING_VALUE = 0.03
      WHERE SETTING_NAME = DBMS_DATA_MINING.ASSO_MIN_SUPPORT;

    UPDATE SETTINGS_ASSOCIATION_RULES
      SET SETTING_VALUE = 0.03
      WHERE SETTING_NAME = DBMS_DATA_MINING.ASSO_MIN_CONFIDENCE;

   INSERT INTO SETTINGS_ASSOCIATION_RULES
        VALUES (DBMS_DATA_MINING.ODMS_ITEM_ID_COLUMN_NAME, 'STOCK_CODE');

   COMMIT;
END;
/


BEGIN
  DBMS_DATA_MINING.DROP_MODEL('MD_ASSOC_ANLYSIS');
END;
/

CREATE OR REPLACE VIEW VW_MARKET_TABLE 
AS 
SELECT CUST_ID, STOCK_CODE 
  FROM MARKET_TABLE;


BEGIN 
   DBMS_DATA_MINING.CREATE_MODEL(
      MODEL_NAME            => 'MD_ASSOC_ANLYSIS',
      MINING_FUNCTION       => DBMS_DATA_MINING.ASSOCIATION,
      DATA_TABLE_NAME       => 'VW_MARKET_TABLE',
      CASE_ID_COLUMN_NAME   => 'CUST_ID',
      TARGET_COLUMN_NAME    => NULL,
      SETTINGS_TABLE_NAME   => 'SETTINGS_ASSOCIATION_RULES');
END;
/



SELECT MODEL_NAME,
          ALGORITHM,
          MINING_FUNCTION
  FROM ALL_MINING_MODELS
  WHERE MODEL_NAME = 'MD_ASSOC_ANLYSIS';



SELECT SETTING_NAME, SETTING_VALUE
  FROM ALL_MINING_MODEL_SETTINGS
  WHERE MODEL_NAME = 'MD_ASSOC_ANLYSIS';


SELECT A.ATTRIBUTE_SUBNAME as ANTECEDENT,
          C.ATTRIBUTE_SUBNAME as CONSEQUENT,
          ROUND(RULE_SUPPORT,3) as SUPPORT,
          ROUND(RULE_CONFIDENCE,3) as CONFIDENCE,
          ROUND(RULE_LIFT,3) as LIFT
  FROM  TABLE(DBMS_DATA_MINING.GET_ASSOCIATION_RULES('MD_ASSOC_ANLYSIS',10)) T,
            TABLE(T.CONSEQUENT) C,
            TABLE(T.ANTECEDENT) A
  ORDER BY SUPPORT DESC,LIFT  DESC;


-- EXAM 198
DROP TABLE ONLINE_RETAIL; 

CREATE TABLE ONLINE_RETAIL
( INVOICENO    VARCHAR2(100),
  STOCKCODE    VARCHAR2(100),
  DESCRIPTION  VARCHAR2(200),
  QUANTITY     NUMBER(10,2),
  INVOICEDATE  DATE,
  UNITPRICE    NUMBER(10,2),
  CUSTOMERID  NUMBER(10,2),
  COUNTRY     VARCHAR2(100) );



SELECT COUNT(*)  FROM ONLINE_RETAIL;


DROP TABLE SETTINGS_ASSOCIATION_RULES2;

CREATE TABLE SETTINGS_ASSOCIATION_RULES2
AS
   SELECT *
     FROM TABLE (DBMS_DATA_MINING.GET_DEFAULT_SETTINGS)
     WHERE SETTING_NAME LIKE 'ASSO_%';

BEGIN
   UPDATE SETTINGS_ASSOCIATION_RULES2
     SET SETTING_VALUE = 3
     WHERE SETTING_NAME = DBMS_DATA_MINING.ASSO_MAX_RULE_LENGTH;

   UPDATE SETTINGS_ASSOCIATION_RULES2
      SET SETTING_VALUE = 0.03
      WHERE SETTING_NAME = DBMS_DATA_MINING.ASSO_MIN_SUPPORT;

    UPDATE SETTINGS_ASSOCIATION_RULES2
      SET SETTING_VALUE = 0.03
      WHERE SETTING_NAME = DBMS_DATA_MINING.ASSO_MIN_CONFIDENCE;

   INSERT INTO SETTINGS_ASSOCIATION_RULES2
      VALUES (DBMS_DATA_MINING.ODMS_ITEM_ID_COLUMN_NAME, ' INVOICENO');
   COMMIT;
END;
/



BEGIN
  DBMS_DATA_MINING.DROP_MODEL('MD_ASSOC_ANLYSIS2');
END;
/

CREATE OR REPLACE VIEW VW_ONLINE_RETAIL
 AS 
   SELECT INVOICENO, STOCKCODE
       FROM ONLINE_RETAIL;

BEGIN 
   DBMS_DATA_MINING.CREATE_MODEL(
      MODEL_NAME            => 'MD_ASSOC_ANLYSIS2',
      MINING_FUNCTION       => DBMS_DATA_MINING.ASSOCIATION,
      DATA_TABLE_NAME       => 'VW_ONLINE_RETAIL',
      CASE_ID_COLUMN_NAME   => 'STOCKCODE',
      TARGET_COLUMN_NAME    => NULL,
      SETTINGS_TABLE_NAME   => 'SETTINGS_ASSOCIATION_RULES2');
END;
/


SELECT MODEL_NAME,
          ALGORITHM,
          MINING_FUNCTION
  FROM ALL_MINING_MODELS
  WHERE MODEL_NAME = 'MD_ASSOC_ANLYSIS2';


SELECT SETTING_NAME, SETTING_VALUE
  FROM ALL_MINING_MODEL_SETTINGS
  WHERE MODEL_NAME = 'MD_ASSOC_ANLYSIS2';


SELECT A.ATTRIBUTE_SUBNAME as ANTECEDENT,
       C.ATTRIBUTE_SUBNAME as CONSEQUENT,
       ROUND(RULE_SUPPORT,3) as SUPPORT,
       ROUND(RULE_CONFIDENCE,3) as CONFIDENCE,
       ROUND(RULE_LIFT,3) as LIFT
  FROM  TABLE(DBMS_DATA_MINING.GET_ASSOCIATION_RULES('MD_ASSOC_ANLYSIS2',10)) T,
            TABLE(T.CONSEQUENT) C,
            TABLE(T.ANTECEDENT) A
  ORDER BY SUPPORT DESC, LIFT DESC;


-- EXAM199
DROP TABLE FRUIT;

CREATE TABLE FRUIT
( F_ID    NUMBER(10),
 F_NAME  VARCHAR2(10),
 SWEET   NUMBER(10),
 CRISPY  NUMBER(10),
 F_CLASS  VARCHAR2(10) );

INSERT INTO FRUIT VALUES( 1, '사과', 10, 9, '과일');
INSERT INTO FRUIT VALUES( 2, '베이컨', 1, 4, '단백질');
INSERT INTO FRUIT VALUES( 3, '바나나', 10, 1, '과일');
INSERT INTO FRUIT VALUES( 4, '당근', 7, 10, '채소');
INSERT INTO FRUIT VALUES( 5, '셀러리', 3, 10, '채소');
INSERT INTO FRUIT VALUES( 6, '치즈', 1, 1, '단백질');
INSERT INTO FRUIT VALUES( 7, '토마토', 6, 7, NULL);
COMMIT;



DROP TABLE SETTINGS_KM1;

CREATE TABLE SETTINGS_KM1
AS
SELECT *
   FROM TABLE (DBMS_DATA_MINING.GET_DEFAULT_SETTINGS)
   WHERE SETTING_NAME LIKE '%GLM%';

BEGIN

   INSERT INTO SETTINGS_KM1
      VALUES (DBMS_DATA_MINING.ALGO_NAME, 'ALGO_KMEANS');

   INSERT INTO SETTINGS_KM1
      VALUES (DBMS_DATA_MINING.PREP_AUTO, 'ON');

    INSERT INTO SETTINGS_KM1
      VALUES (DBMS_DATA_MINING.CLUS_NUM_CLUSTERS, 3);

   COMMIT;

END;
/



BEGIN
 DBMS_DATA_MINING.DROP_MODEL('MD_KM_MODEL1');
END;
/

BEGIN 

   DBMS_DATA_MINING.CREATE_MODEL(
      MODEL_NAME            => 'MD_KM_MODEL1',
      MINING_FUNCTION       => DBMS_DATA_MINING.CLUSTERING,
      DATA_TABLE_NAME       => 'FRUIT',
      CASE_ID_COLUMN_NAME   => 'F_ID',
      TARGET_COLUMN_NAME    => NULL,
      SETTINGS_TABLE_NAME   => 'SETTINGS_KM1');
END;
/

DROP TABLE KMEANS_RESULT1;

BEGIN
   DBMS_DATA_MINING.APPLY (MODEL_NAME => 'MD_KM_MODEL1',
                                          DATA_TABLE_NAME => 'FRUIT',
                                          CASE_ID_COLUMN_NAME => 'F_ID',
                                          RESULT_TABLE_NAME => 'KMEANS_RESULT1');
END;
/



SELECT T2.F_NAME,
          T2.F_CLASS,
          T1.CLUSTER_ID,
          T1.PROBABILITY,
          T2.SWEET,
          T2.CRISPY
  FROM (SELECT F_ID, CLUSTER_ID, PROBABILITY
              FROM (SELECT T.*,
                                  MAX (PROBABILITY)  OVER (PARTITION BY F_ID 
                                                                       ORDER BY PROBABILITY DESC) MAXP
                          FROM KMEANS_RESULT1 T)
                          WHERE MAXP = PROBABILITY) T1, FRUIT T2
  WHERE T1.F_ID = T2.F_ID 
  ORDER BY CLUSTER_ID;


-- EXAM200	
DROP TABLE CHICAGO_CRIME; 

CREATE TABLE CHICAGO_CRIME
( C_ID	                NUMBER(10),
 CASE_NUMBER            VARCHAR2(10),
 CRIME_DATE             VARCHAR2(40), 
 PRIMARY_TYPE           VARCHAR2(40),
 DESCRIPTION            VARCHAR2(80),
 LOCATION_DESCRIPTION   VARCHAR2(50),	
 ARREST_YN              VARCHAR2(10),
 DOMESTIC               VARCHAR2(10),
 FBI_CODE               VARCHAR2(10),
 CRIME_YEAR             VARCHAR2(10),	
 LATITUDE               NUMBER(20,10),	
 LONGITUDE              NUMBER(20,10) 
);


SELECT COUNT(*) FROM CHICAGO_CRIME;


DROP TABLE SETTINGS_KM2;

CREATE TABLE SETTINGS_KM2
AS
SELECT *
   FROM TABLE (DBMS_DATA_MINING.GET_DEFAULT_SETTINGS)
   WHERE SETTING_NAME LIKE '%GLM%';

BEGIN

   INSERT INTO SETTINGS_KM2
      VALUES (DBMS_DATA_MINING.ALGO_NAME, 'ALGO_KMEANS');

   INSERT INTO SETTINGS_KM2
      VALUES (DBMS_DATA_MINING.PREP_AUTO, 'ON');

    INSERT INTO SETTINGS_KM2
      VALUES (DBMS_DATA_MINING.CLUS_NUM_CLUSTERS, 14);

   COMMIT;

END;
/



BEGIN
  DBMS_DATA_MINING.DROP_MODEL('MD_GLM_MODEL2');
END;
/


DROP TABLE KMEANS_RESULT2;

CREATE OR REPLACE VIEW VW_CHICAGO_CRIME
AS 
  SELECT C_ID, LATITUDE, LONGITUDE
    FROM CHICAGO_CRIME;

BEGIN 

   DBMS_DATA_MINING.CREATE_MODEL(
      MODEL_NAME            => 'MD_GLM_MODEL2',
      MINING_FUNCTION       => DBMS_DATA_MINING.CLUSTERING,
      DATA_TABLE_NAME       => 'VW_CHICAGO_CRIME',
      CASE_ID_COLUMN_NAME   => 'C_ID',
      TARGET_COLUMN_NAME    => NULL,
      SETTINGS_TABLE_NAME   => 'SETTINGS_KM2');
END;
/


BEGIN
   DBMS_DATA_MINING.APPLY (MODEL_NAME => 'MD_GLM_MODEL2',
                                         DATA_TABLE_NAME => 'VW_CHICAGO_CRIME',
                                         CASE_ID_COLUMN_NAME => 'C_ID',
                                         RESULT_TABLE_NAME => 'KMEANS_RESULT2');
END;
/


SELECT T1.C_ID,
          T1.CLUSTER_ID,
          T1.PROBABILITY,
          T2.LATITUDE,
          T2.LONGITUDE
  FROM (SELECT C_ID, CLUSTER_ID, PROBABILITY
              FROM (SELECT T.*,
                                  MAX (PROBABILITY) OVER (PARTITION BY C_ID 
                                                                    ORDER BY PROBABILITY DESC) MAXP
                          FROM KMEANS_RESULT2 T)
            WHERE MAXP = PROBABILITY) T1, CHICAGO_CRIME T2
 WHERE T1.C_ID = T2.C_ID ORDER BY CLUSTER_ID;


SELECT   T1.CLUSTER_ID , COUNT(*)
FROM (SELECT C_ID, CLUSTER_ID, PROBABILITY
            FROM (SELECT T.*,
                                MAX (PROBABILITY) OVER (PARTITION BY C_ID 
                                                                    ORDER BY PROBABILITY DESC) MAXP
                        FROM KMEANS_RESULT2 T)
           WHERE MAXP = PROBABILITY) T1, CHICAGO_CRIME T2
  WHERE T1.C_ID = T2.C_ID 
  GROUP BY T1.CLUSTER_ID;


-- EXAM201
DROP  TABLE TITANIC;

CREATE TABLE TITANIC
(PASSENGERID	NUMBER(5),
 SURVIVED	    NUMBER(5),
 PCLASS	        NUMBER(5),
 NAME	        VARCHAR2(100),
 SEX	        VARCHAR2(20),
 AGE	        NUMBER(5,2),
 SIBSP	        NUMBER(5), 
 PARCH	        NUMBER(5),
 TICKET	        VARCHAR2(20),
 FARE	        NUMBER(18,5),
 CABIN	        VARCHAR2(50),
 EMBARKED      VARCHAR2(5) );



SELECT COUNT(*) FROM TITANIC;

DROP TABLE SETTINGS_GLM;

CREATE TABLE SETTINGS_GLM
AS
SELECT *
     FROM TABLE (DBMS_DATA_MINING.GET_DEFAULT_SETTINGS)
    WHERE SETTING_NAME LIKE '%GLM%';

BEGIN

   INSERT INTO SETTINGS_GLM
        VALUES (DBMS_DATA_MINING.ALGO_NAME, 'ALGO_RANDOM_FOREST');

   INSERT INTO SETTINGS_GLM
        VALUES (DBMS_DATA_MINING.PREP_AUTO, 'ON');

   INSERT INTO SETTINGS_GLM
        VALUES (
                  DBMS_DATA_MINING.GLMS_REFERENCE_CLASS_NAME,
                  'GLMS_RIDGE_REG_DISABLE');

   INSERT INTO SETTINGS_GLM
        VALUES (
                  DBMS_DATA_MINING.ODMS_MISSING_VALUE_TREATMENT,
                  'ODMS_MISSING_VALUE_MEAN_MODE');

   COMMIT;
END;
/



BEGIN
   DBMS_DATA_MINING.DROP_MODEL( 'MD_CLASSIFICATION_MODEL');
END;
/



BEGIN 
   DBMS_DATA_MINING.CREATE_MODEL(
      model_name            => 'MD_CLASSIFICATION_MODEL',
      mining_function       =>  DBMS_DATA_MINING.CLASSIFICATION,
      data_table_name       => 'TITANIC',
      case_id_column_name   => 'PASSENGERID',
      target_column_name    =>  'SURVIVED',
      settings_table_name   => 'SETTINGS_GLM');
END;
/



SELECT MODEL_NAME,
       ALGORITHM,
       MINING_FUNCTION
  FROM ALL_MINING_MODELS
 WHERE MODEL_NAME = 'MD_CLASSIFICATION_MODEL';




SELECT SETTING_NAME, SETTING_VALUE
FROM ALL_MINING_MODEL_SETTINGS
WHERE MODEL_NAME = 'MD_CLASSIFICATION_MODEL';



DROP TABLE TITANIC_TEST;

CREATE TABLE TITANIC_TEST
(PASSENGERID	NUMBER(5),
 PCLASS	        NUMBER(5),
 NAME	        VARCHAR2(100),
 SEX	        VARCHAR2(20),
 AGE	        NUMBER(5,2),
 SIBSP	        NUMBER(5), 
 PARCH	        NUMBER(5),
 TICKET	        VARCHAR2(20),
 FARE	        NUMBER(18,5),
 CABIN	        VARCHAR2(50),
 EMBARKED       VARCHAR2(5) );



SELECT COUNT(*) FROM TITANIC_TEST;


SELECT passengerid ,
 PREDICTION (MD_CLASSIFICATION_MODEL USING *) MODEL_PREDICT_RESPONSE
FROM titanic_test 
order by passengerid;

-- EXAM202
ALTER TABLE TITANIC
  ADD WOMEN_CHILD NUMBER(5);



UPDATE TITANIC T1
SET WOMEN_CHILD = ( SELECT CASE WHEN AGE < 10 OR SEX='FEMALE'  
                                         THEN 1 ELSE 0 END    
                                 FROM TITANIC T2
                                 WHERE T2.PASSENGERID = T1.PASSENGERID ); 
                           
COMMIT;



ALTER TABLE TITANIC_TEST
  ADD WOMEN_CHILD NUMBER(5);



UPDATE TITANIC_TEST T1
SET WOMEN_CHILD = ( SELECT CASE  WHEN  AGE < 10  OR  SEX='FEMALE'  THEN  1  ELSE 0  END  
                                  FROM   TITANIC_TEST   T2
                                  WHERE  T2.PASSENGERID = T1.PASSENGERID  ); 
                           
COMMIT;



SELECT WOMEN_CHILD, COUNT(*)
 FROM TITANIC
 GROUP BY WOMEN_CHILD;


SELECT COUNT(*) FROM TITANIC WHERE AGE IS NULL;


SELECT name, SUBSTR(name, (instr(name, ',')+1), instr(name, '.')-instr(name, ',')-1) as 호칭 
  FROM titanic;



ALTER TABLE TITANIC
  ADD TITLE VARCHAR2(20);



MERGE INTO TITANIC T
USING ( SELECT PASSENGERID, NAME, 
                  SUBSTR( NAME, INSTR( NAME, ',')+2, 
                                 INSTR( NAME, '.')-INSTR( NAME, ',')-2 ) AS 호칭
            FROM TITANIC ) A
  ON ( T.PASSENGERID = A.PASSENGERID )
  WHEN MATCHED THEN
  UPDATE SET T.TITLE = A.호칭 ;

COMMIT;




SELECT name, title FROM titanic;



ALTER TABLE TITANIC
 ADD TITLE2 VARCHAR2(20);



SELECT title,
       CASE WHEN title in ('Mlle','Mme','Ms') then 'Miss'
              WHEN title in ('Dr','Major','Rev','Sir','Don','Master','Capt') then 'Mr'
              WHEN title in('Lady','the Countess') then 'Mrs'
              WHEN title in ('Jonkheer','Col') then 'Other'
              ELSE title END 호칭2
 FROM titanic;



MERGE INTO titanic t
USING titanic i
On (t.passengerid = i.passengerid)
WHEN MATCHED Then
UPDATE SET title2 =  CASE WHEN title in ('Mlle','Mme','Ms') then 'Miss'
                                   WHEN title in ('Dr','Major','Capt', 'Sir' , 'Don' , 'Master') 
                                   THEN 'Mr'
                                   WHEN title in ('the Countess', 'Lady') then 'Mrs'
                                   WHEN title in ('Jonkheer', 'Col' , 'Rev') then 'Other'
                                   ELSE title END;

COMMIT;


SELECT  title2, round(avg(age))
  FROM  titanic
  GROUP  BY  title2;



SELECT title2 ,count(*)
   FROM  titanic
   WHERE age is null
   GROUP BY title2;



MERGE INTO titanic t
USING ( SELECT title2, round(avg(age)) 평균나이 
            FROM titanic 
            GROUP BY title2 ) tt
ON ( t.title2 = tt.title2 )
WHEN MATCHED THEN
UPDATE SET t.age = tt.평균나이
WHERE  t.age is null ;

COMMIT;



ALTER TABLE TITANIC_TEST
 ADD TITLE  VARCHAR2(20);



MERGE INTO titanic_test t
USING ( SELECT passengerid, name, 
                  SUBSTR( name, instr( name, ',')+2, 
                                     instr( name, '.')-instr( name, ',')-2 ) as 호칭
            FROM titanic_test ) a
  ON ( t.passengerid = a.passengerid )
  WHEN MATCHED THEN
  UPDATE SET t.title = a.호칭 ;

COMMIT;


ALTER TABLE TITANIC_TEST
 ADD TITLE2  VARCHAR2(20);



MERGE INTO titanic_test t
USING titanic_test i
ON (t.passengerid = i.passengerid)
WHEN MATCHED THEN
UPDATE SET title2 =  CASE WHEN title in ('Mlle','Mme','Ms') then 'Miss'
                                   WHEN title in ('Dr','Major','Capt', 'Sir' , 'Don' , 'Master') 
                                   THEN 'Mr'
                                   WHEN title in ('the Countess', 'Lady') then 'Mrs'
                                   WHEN title in ('Jonkheer', 'Col' , 'Rev') then 'Other'
                                   ELSE title END;

COMMIT;


MERGE INTO titanic_test t
USING ( SELECT title2, round(avg(age)) 평균나이 
            FROM titanic_test 
            GROUP BY title2 ) tt
ON ( t.title2 = tt.title2 )
WHEN MATCHED THEN
UPDATE SET t.age = tt.평균나이
WHERE t.age is null ;

COMMIT;



SELECT PASSENGERID, FARE, 이상치기준
  FROM( SELECT T.*,
                     ROUND( AVG(FARE) OVER () + 5 * STDDEV(FARE) OVER ()) "이상치기준"
              FROM TITANIC  T
        )
   WHERE FARE > 이상치기준;




CREATE OR REPLACE VIEW TT_VIEW
AS
SELECT *
    FROM( SELECT T.*,
                      ROUND( AVG(FARE) OVER () + 5 * STDDEV(FARE) OVER ()) "이상치기준"
                FROM TITANIC  T
        )
    WHERE FARE < 이상치기준;



DROP TABLE SETTINGS_GLM3;

CREATE TABLE SETTINGS_GLM3
AS
SELECT *
     FROM TABLE (DBMS_DATA_MINING.GET_DEFAULT_SETTINGS)
     WHERE SETTING_NAME LIKE '%GLM%';

BEGIN

   INSERT INTO SETTINGS_GLM3
        VALUES (DBMS_DATA_MINING.ALGO_NAME, 'ALGO_RANDOM_FOREST');

   INSERT INTO SETTINGS_GLM3
        VALUES (DBMS_DATA_MINING.PREP_AUTO, 'ON');

  INSERT INTO SETTINGS_GLM3
     VALUES (DBMS_DATA_MINING.CLAS_MAX_SUP_BINS, 254);

   COMMIT;

END;
/



BEGIN
   DBMS_DATA_MINING.DROP_MODEL( 'MD_CLASSIFICATION_MODEL3');
END;
/



BEGIN 
   DBMS_DATA_MINING.CREATE_MODEL(
      MODEL_NAME         => 'MD_CLASSIFICATION_MODEL3',
      MINING_FUNCTION       => DBMS_DATA_MINING.CLASSIFICATION,
      DATA_TABLE_NAME       => 'TT_VIEW',
      CASE_ID_COLUMN_NAME   => 'PASSENGERID',
      TARGET_COLUMN_NAME    => 'SURVIVED',
      SETTINGS_TABLE_NAME   => 'SETTINGS_GLM3');
END;
/



SELECT MODEL_NAME,
       ALGORITHM,
       MINING_FUNCTION
 FROM ALL_MINING_MODELS
 WHERE MODEL_NAME = 'MD_CLASSIFICATION_MODEL3';



SELECT PASSENGERID,
          PREDICTION (MD_CLASSIFICATION_MODEL3 USING *) MODEL_PREDICT_RESPONSE
FROM TITANIC_TEST 
ORDER BY PASSENGERID;




