-- EXAM162
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_ARR1 PROMPT ' 키를 입력하세요 ~ '
ACCEPT P_ARR2 PROMPT ' 체중을 입력하세요 ~ '

DECLARE
    TYPE ARR_TYPE IS VARRAY(10) OF NUMBER(10, 2);
    V_NUM_ARR1  ARR_TYPE := ARR_TYPE(&P_ARR1);
    V_SUM1      NUMBER(10, 2) := 0;
    V_AVG1      NUMBER(10, 2) := 0;
    
    V_NUM_ARR2  ARR_TYPE := ARR_TYPE(&P_ARR2);
    V_SUM2      NUMBER(10, 2) := 0;
    V_AVG2      NUMBER(10, 2) := 0;
    
    V_CNT       NUMBER(10, 2);
    V_VAR       NUMBER(10, 2) := 0;
    
BEGIN

    V_CNT := V_NUM_ARR1.COUNT;
    
    FOR I IN 1 .. V_NUM_ARR1.COUNT LOOP
        V_SUM1 := V_SUM1 + V_NUM_ARR1(I);
    END LOOP;
    V_AVG1 := V_SUM1 / V_CNT;
    
    FOR I IN 1 .. V_NUM_ARR2.COUNT LOOP
        V_SUM2 := V_SUM2 + V_NUM_ARR2(I);
    END LOOP;
    
    V_AVG2 := V_SUM2 / V_CNT;
    
    FOR I IN 1 .. V_CNT LOOP
        V_VAR := V_VAR + (V_NUM_ARR1(I) - V_AVG1) * (V_NUM_ARR2(I) - V_AVG2) / V_CNT;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('공분산 값은: ' || V_VAR);
END;
/

-- EXAM163
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_ARR1 PROMPT ' 키를 입력하세요 ~ '
ACCEPT P_ARR2 PROMPT ' 체중을 입력하세요 ~ '

DECLARE
    TYPE ARR_TYPE IS VARRAY(10) OF NUMBER(10, 2);
    V_NUM_ARR1  ARR_TYPE := ARR_TYPE(&P_ARR1);
    V_SUM1      NUMBER(10, 2) := 0;
    V_AVG1      NUMBER(10, 2) := 0;
    
    V_NUM_ARR2  ARR_TYPE := ARR_TYPE(&P_ARR2);
    V_SUM2      NUMBER(10, 2) := 0;
    V_AVG2      NUMBER(10, 2) := 0;
    
    V_CNT       NUMBER(10, 2);
    COV_VAR       NUMBER(10, 2) := 0;
    
    V_NUM_ARR1_VAR      NUMBER(10, 2) := 0;
    V_NUM_ARR2_VAR      NUMBER(10, 2) := 0;
    V_CORR              NUMBER(10, 2);
    
BEGIN

    V_CNT := V_NUM_ARR1.COUNT;
    
    FOR I IN 1 .. V_NUM_ARR1.COUNT LOOP
        V_SUM1 := V_SUM1 + V_NUM_ARR1(I);
    END LOOP;
    V_AVG1 := V_SUM1 / V_CNT;
    
    FOR I IN 1 .. V_NUM_ARR2.COUNT LOOP
        V_SUM2 := V_SUM2 + V_NUM_ARR2(I);
    END LOOP;
    
    V_AVG2 := V_SUM2 / V_CNT;
    
    FOR I IN 1 .. V_CNT LOOP
        COV_VAR := COV_VAR + (V_NUM_ARR1(I) - V_AVG1) * (V_NUM_ARR2(I) - V_AVG2) / V_CNT;
        V_NUM_ARR1_VAR := V_NUM_ARR1_VAR + POWER(V_NUM_ARR1(I) - V_AVG1, 2);
        V_NUM_ARR2_VAR := V_NUM_ARR2_VAR + POWER(V_NUM_ARR2(I) - V_AVG2, 2);
    END LOOP;
    
    V_CORR := COV_VAR / SQRT(V_NUM_ARR1_VAR * V_NUM_ARR2_VAR);
    DBMS_OUTPUT.PUT_LINE('공분산 값은: ' || V_CORR);
END;
/

-- EXAM164
DECLARE
    V_LOOP NUMBER(10) := 10000;
    V_COIN NUMBER(10);
    V_0    NUMBER(10) := 0; 
    V_1    NUMBER(10) := 0;
    
BEGIN
    FOR I IN 1 .. V_LOOP LOOP
    
        SELECT ROUND (DBMS_RANDOM.VALUE(1, 2)) INTO V_COIN
            FROM DUAL;
            
        IF V_COIN = 1 THEN
            V_0 := V_0 + 1;
        ELSE
            V_1 := V_1 + 1;
        END IF;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('동전이 앞면이 나올 확률: ' || ROUND((V_0 / V_LOOP), 2));
    DBMS_OUTPUT.PUT_LINE('동전이 뒷면이 나올 확률: ' || ROUND((V_1 / V_LOOP), 2));
END;
/

-- EXAM165
DECLARE
    V_LOOP      NUMBER(10) := 10000;
    V_COIN1     NUMBER(10);
    V_COIN2     NUMBER(10);
    V_0         NUMBER(10) := 10;
    V_1         NUMBER(10) := 10;
    V_2         NUMBER(10) := 10;
BEGIN
    FOR I IN 1 .. V_LOOP LOOP
        SELECT ROUND(DBMS_RANDOM.VALUE(0, 1)), ROUND(DBMS_RANDOM.VALUE(0, 1))
                        INTO V_COIN1, V_COIN2
                    FROM DUAL;
        IF V_COIN1 = 0 AND V_COIN2 = 0 THEN
            V_0 := V_1 + 1;
        ELSIF V_COIN1 = 1 AND V_COIN2 = 1 THEN
            V_1 := V_1 + 1;
        ELSE
            V_2 := V_2 + 1;
        END IF;
    END LOOP;
DBMS_OUTPUT.PUT_LINE('동전 둘다 앞면이 나올 확률: ' || ROUND((V_0/V_LOOP), 2));
DBMS_OUTPUT.PUT_LINE('동전 둘중 하나가 앞면, 다른 하나는 뒷면이 나올 확률: ' || ROUND((V_2/V_LOOP), 2));
DBMS_OUTPUT.PUT_LINE('동전 둘다 뒷면이 나올 확률: ' || ROUND((V_1/V_LOOP), 2));
END;
/

-- EXAM166
CREATE OR REPLACE FUNCTION MYBIN
(P_H IN NUMBER)
RETURN NUMBER
IS
    V_H     NUMBER(10) := P_H;
    V_SIM   NUMBER(10) := 100000;
    V_CNT   NUMBER(10) := 0;
    V_CNT2  NUMBER(10) := 0;
    V_RES   NUMBER(10, 2);
    
BEGIN
    FOR N IN 1 .. V_SIM LOOP
    V_CNT := 0;
        FOR I IN 1 .. 10 LOOP
            IF DBMS_RANDOM.VALUE < 0.5 THEN
                V_CNT := V_CNT + 1;
            END IF;
        END LOOP;
        IF V_CNT = V_H THEN
            V_CNT2 := V_CNT2 + 1;
        END IF;
    END LOOP;
    
    V_RES := V_CNT2 / V_SIM;
    RETURN V_RES;
END;
/

-- EXAM166-2
SELECT LEVEL-1 GRAGE, MYBIN(LEVEL-1) 확률, LPAD('*', MYBIN(LEVEL - 1) * 100, '*') "막대그래프"
FROM DUAL
CONNECT BY LEVEL< 12;

-- EXAM167
CREATE OR REPLACE PROCEDURE PROBN
(P_MU IN NUMBER,
 P_SIG IN NUMBER,
 P_BIN NUMBER)
IS

    TYPE ARR_TYPE IS VARRAY(9) OF NUMBER(30);
    
    V_SIM   NUMBER(10) := 10000;
    V_RV    NUMBER(20, 7);
    V_MU    NUMBER(10) := P_MU;
    V_SIG   NUMBER(10) := P_SIG;
    V_NM ARRAY_TYPE := ARRAY_TYPE('', 0, 0, 0, 0, 0, 0, 0, '');
    V_CNT ARR_TYPE := ARR_TYPE(0, 0, 0, 0, 0, 0, 0, 0);
    V_RG ARR_TYPE := ARR_TYPE(-POWER(2, 31), -3, -2, -1, 0, 1, 2, 3, POWER(2, 32));
    
BEGIN
    FOR I IN V_NM.FIRST + 1 .. V_NM.LAST-1 LOOP
        V_NM(I) := V_MU-3 * P_BIN + (I - 2) * P_BIN;
    END LOOP;
    
    FOR I IN 1 .. V_SIM LOOP
        V_RV := DBMS_RANDOM.NORMAL * V_SIG + V_MU;
        
        FOR I IN 2 .. V_RG.COUNT LOOP
            IF V_RV >= V_MU + V_RG(I-1) * P_BIN AND V_RV < V_MU + V_RG(I) * P_BIN THEN
                        V_CNT(I-1) := V_CNT(I-1) + 1;
            END IF;
        END LOOP;
    END LOOP;
    
    FOR I IN 1 .. V_CNT.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(V_NM(I) || '~' || V_NM(I + 1), 10, ' ') || LPAD('*', TRUNC((V_CNT(I) / V_SIM) * 100), '*'));
    END LOOP;
END;
/

-- EXAM167
SET SERVEROUTPUT ON
SET VERIFY OFF
CREATE OR REPLACE PROCEDURE PROBN
(P_MU IN NUMBER,
 P_SIG IN NUMBER,
 P_BIN NUMBER)
IS

    TYPE ARR_TYPE IS VARRAY(9) OF NUMBER(30);
    
    V_SIM   NUMBER(10) := 10000;
    V_RV    NUMBER(20, 7);
    V_MU    NUMBER(10) := P_MU;
    V_SIG   NUMBER(10) := P_SIG;
    V_NM ARR_TYPE := ARR_TYPE('', 0, 0, 0, 0, 0, 0, 0, '');
    V_CNT ARR_TYPE := ARR_TYPE(0, 0, 0, 0, 0, 0, 0, 0);
    V_RG ARR_TYPE := ARR_TYPE(-POWER(2, 31), -3, -2, -1, 0, 1, 2, 3, POWER(2, 32));
    
BEGIN
    FOR I IN V_NM.FIRST + 1 .. V_NM.LAST-1 LOOP
        V_NM(I) := V_MU-3 * P_BIN + (I - 2) * P_BIN;
    END LOOP;
    
    FOR I IN 1 .. V_SIM LOOP
        V_RV := DBMS_RANDOM.NORMAL * V_SIG + V_MU;
        
        FOR I IN 2 .. V_RG.COUNT LOOP
            IF V_RV >= V_MU + V_RG(I-1) * P_BIN AND V_RV < V_MU + V_RG(I) * P_BIN THEN
                        V_CNT(I-1) := V_CNT(I-1) + 1;
            END IF;
        END LOOP;
    END LOOP;
    
    FOR I IN 1 .. V_CNT.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(V_NM(I) || '~' || V_NM(I + 1), 10, ' ') || LPAD('*', TRUNC((V_CNT(I) / V_SIM) * 100), '*'));
    END LOOP;
END;
/
