-- EXAM144
SET SERVEROUTPUT ON
DECLARE
    V_COUNT NUMBER(10) := 0;
BEGIN
    WHILE V_COUNT < 9 LOOP
        V_COUNT := V_COUNT + 1;
        DBMS_OUTPUT.PUT_LINE ( '2 X ' || V_COUNT || ' = ' || 2 * V_COUNT);
    END LOOP;
END;
/

-- EXAM145
BEGIN
    FOR I IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE ( '2 X ' || I || ' = ' || 2 * I);
    END LOOP;
END;
/

-- EXAM146
PROMPT ������ ��ü�� ����մϴ�
BEGIN
    FOR I IN 2 .. 9 LOOP
        FOR J IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE ( I || ' X ' || J || ' = ' || I * J);
        END LOOP;
    END LOOP;
END;
/

-- EXAM147
DECLARE
    V_ENAME  EMP.ENAME%TYPE;
    V_SAL    EMP.SAL%TYPE;
    V_DEPTNO EMP.DEPTNO%TYPE;
    
    CURSOR EMP_CURSOR IS
        SELECT ENAME, SAL, DEPTNO
            FROM EMP
            WHERE DEPTNO = &P_DEPTNO;
BEGIN
    OPEN EMP_CURSOR;
        LOOP
            FETCH EMP_CURSOR INTO V_ENAME, V_SAL, V_DEPTNO;
            EXIT WHEN EMP_CURSOR%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(V_ENAME || ' ' || V_SAL || ' ' || V_DEPTNO);
        END LOOP;
    CLOSE EMP_CURSOR;
END;
/

-- EXAM148
ACCEPT P_DEPTNO PROMPT '�μ� ��ȣ�� �Է��ϼ��� ~'
DECLARE
        CURSOR EMP_CURSOR IS
            SELECT ENAME, SAL, DEPTNO
                FROM EMP
                WHERE DEPTNO = &P_DEPTNO;
BEGIN
    FOR EMP_RECORD IN EMP_CURSOR LOOP
         DBMS_OUTPUT.PUT_LINE(EMP_RECORD.ENAME || ' ' || EMP_RECORD.SAL || ' ' || EMP_RECORD.DEPTNO);
    END LOOP;
END;
/

-- EXAM149
ACCEPT P_DEPTNO PROMPT '�μ� ��ȣ�� �Է��ϼ��� ~'
BEGIN
    FOR EMP_RECORD IN (SELECT ENAME, SAL, DEPTNO
                            FROM EMP
                            WHERE DEPTNO = &P_DEPTNO) LOOP
        DBMS_OUTPUT.PUT_LINE(EMP_RECORD.ENAME || ' ' || EMP_RECORD.SAL || ' ' || EMP_RECORD.DEPTNO);
    END LOOP;
END;
/

-- EXAM150
CREATE OR REPLACE PROCEDURE PRO_ENAME_SAL
 (P_ENAME IN EMP.ENAME%TYPE)
IS
        V_SAL   EMP.SAL%TYPE;
BEGIN
        SELECT SAL INTO V_SAL
            FROM EMP
            WHERE ENAME = P_ENAME;
    DBMS_OUTPUT.PUT_LINE(V_SAL || '�Դϴ�');

END;
/

-- EXAM151
CREATE OR REPLACE FUNCTION GET_LOC
(P_DEPTNO IN DEPT.DEPTNO%TYPE)
RETURN DEPT.LOC%TYPE
IS
    V_LOC   DEPT.LOC%TYPE;
BEGIN
    SELECT LOC INTO V_LOC
        FROM DEPT
        WHERE DEPTNO = P_DEPTNO;
    RETURN V_LOC;
END;
/

-- EXAM152
SET SERVEROUTPUT ON
ACCEPT P_NUM PROMPT '���ڸ� �Է��ϼ��� ~ '

DECLARE
    V_NUM NUMBER(10) := &P_NUM;
    
BEGIN
    IF V_NUM >= 0 THEN
        DBMS_OUTPUT.PUT_LINE(V_NUM);
    ELSE
        DBMS_OUTPUT.PUT_LINE(-1 * V_NUM);
    END IF;
END;
/

-- EXAM153
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_NUM1 PROMPT ' �غ��� �Է��ϼ��� ~ '
ACCEPT P_NUM2 PROMPT ' ������ �Է��ϼ��� ~ '
ACCEPT P_NUM3 PROMPT ' ������ �Է��ϼ��� ~ '

BEGIN
    IF POWER(&P_NUM, 2) + POWER(&P_NUM2, 2) = POWER(&P_NUM3, 2)
    THEN
        DBMS_OUTPUT.PUT_LINE('�����ﰢ���Դϴ�. ');
    ELSE
        DBMS_OUTPUT.PUT_LINE('�����ﰢ���� �ƴմϴ�.');
    END IF;
END;
/

-- EXAM154
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_NUM1 PROMPT ' �ؼ��� �Է��ϼ��� ~ '
ACCEPT P_NUM2 PROMPT ' ������ �Է��ϼ��� ~ '

DECLARE
    V_RESULT    NUMBER(10) := 1;
    V_NUM2      NUMBER(10) := &P_NUM1;
    V_COUNT     NUMBER(10) := 0;
BEGIN
    LOOP
        V_COUNT := V_COUNT + 1;
        V_RESULT := V_RESULT * V_NUM2;
        EXIT WHEN V_COUNT = &P_NUM2;
    END LOOP;
        DBMS_OUTPUT.PUT_LINE(V_RESULT);
END;
/

-- EXAM155
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_NUM1 PROMPT ' �ؼ��� �Է��ϼ��� ~ '
ACCEPT P_NUM2 PROMPT ' ������ �Է��ϼ��� ~ '

DECLARE
    V_NUM1  NUMBER(10) := &P_NUM1;
    V_NUM2  NUMBER(10) := &P_NUM2;
    V_COUNT NUMBER(10) := 0;
    V_RESULT NUMBER(10) := 1;
BEGIN
    LOOP
        V_COUNT := V_COUNT + 1;
        V_RESULT := V_RESULT * V_NUM1;
        EXIT WHEN V_RESULT = V_NUM2;
    END LOOP;
        DBMS_OUTPUT.PUT_LINE(V_COUNT);
END;
/

-- EXAM156
drop table sample;

create table sample
( num  number(10),
 fruit   varchar2(10) );

insert into sample values (1, '���');
insert into sample values (2, '�ٳ���');
insert into sample values (3, '������');
commit;

-- EXAM156-2
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    V_NAME1     SAMPLE.FRUIT%TYPE;
    V_NAME2     SAMPLE.FRUIT%TYPE;
BEGIN
    FOR I IN 1 .. 3 LOOP
        FOR J IN 1 .. 3 LOOP
            SELECT FRUIT INTO V_NAME1 FROM SAMPLE WHERE NUM = I;
            SELECT FRUIT INTO V_NAME2 FROM SAMPLE WHERE NUM = J;
            IF I != J THEN
                DBMS_OUTPUT.PUT_LINE(V_NAME1 || ', ' || V_NAME2);
            END IF;
        END LOOP;
    END LOOP;
END;
/

-- EXAM157
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    V_NAME1     SAMPLE.FRUIT%TYPE;
    V_NAME2     SAMPLE.FRUIT%TYPE;
BEGIN
    FOR I IN 1 .. 3 LOOP
        FOR J IN 1 .. 3 LOOP
            SELECT FRUIT INTO V_NAME1 FROM SAMPLE WHERE NUM = I;
            SELECT FRUIT INTO V_NAME2 FROM SAMPLE WHERE NUM = J;
                DBMS_OUTPUT.PUT_LINE(V_NAME1 || ', ' || V_NAME2);
        END LOOP;
    END LOOP;
END;
/

-- EXAM158
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_ARR PROMPT ' ���ڸ� �Է��ϼ��� ~ '

DECLARE
    TYPE ARR_TYPE IS VARRAY(5) OF NUMBER(10);
    V_NUM_ARR   ARR_TYPE := ARR_TYPE(&P_ARR);
    V_SUM   NUMBER(10) := 0;
    V_CNT   NUMBER(10) := 0;
BEGIN
    FOR I IN 1 .. V_NUM_ARR.COUNT LOOP
        V_SUM := V_SUM + V_NUM_ARR(I);
        V_CNT := V_CNT + 1;
    END LOOP;
    
DBMS_OUTPUT.PUT_LINE(V_SUM / V_CNT);

END;
/

-- EXAM159
ACCEPT P_ARR PROMPT ' ���ڸ� �Է��ϼ��� ~ '

DECLARE
    TYPE ARR_TYPE IS VARRAY(10) OF NUMBER(10);
    V_NUM_ARR   ARR_TYPE := ARR_TYPE(&P_ARR);
    V_N         NUMBER(10);
    V_MEDI      NUMBER(10, 2);
BEGIN
    V_N := V_NUM_ARR.COUNT;
    IF MOD(V_N, 2) = 1 THEN
        V_MEDI := V_NUM_ARR((V_N+1)/2);
    ELSE
        V_MEDI := (V_NUM_ARR(V_N/2) + V_NUM_ARR((V_N/2)+1))/2;
    END IF;
    DBMS_OUTPUT.PUT_LINE(V_MEDI);
END;
/

-- EXAM160
ACCEPT P_NUM1 PROMPT ' �����͸� �Է��ϼ��� ~ '
DECLARE
    TYPE ARRAY_T IS VARRAY(10) OF VARCHAR2(10);
    V_ARRAY ARRAY_T := ARRAY_T(&P_NUM1);
    V_CNT NUMBER(10);
    V_TMP NUMBER(10);
    V_MAX NUMBER(10):=0;
    V_TMP2 NUMBER(10);
    
BEGIN
    FOR I IN 1 .. V_ARRAY.COUNT LOOP
        V_CNT := 1;
        FOR J IN I+1 .. V_ARRAY.COUNT LOOP
            IF V_ARRAY(I) = V_ARRAY(J) THEN
                V_TMP := V_ARRAY(I);
                V_CNT := V_CNT + 1;
            END IF;
        END LOOP;
        
        IF V_MAX <= V_CNT THEN
            V_MAX := V_CNT;
            V_TMP2 := V_TMP;
            END IF;
        END LOOP;
    DBMS_OUTPUT.PUT_LINE('�ֺ��� ' || V_TMP2 || '�̰� ' || V_MAX || '���Դϴ�');
END;
/

-- EXAM161
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_ARR PROMPT ' ���ڸ� �Է��ϼ��� ~ '

DECLARE
    TYPE ARR_TYPE IS VARRAY(10) OF NUMBER(10);
    V_NUM_ARR   ARR_TYPE := ARR_TYPE(&P_ARR);
    V_SUM   NUMBER(10, 2) := 0;
    V_CNT   NUMBER(10, 2) := 0;
    V_AVG   NUMBER(10, 2) := 0;
    V_VAR   NUMBER(10, 2) := 0;
    
BEGIN
    FOR I IN 1 .. V_NUM_ARR.COUNT LOOP
        V_SUM := V_SUM + V_NUM_ARR(I);
        V_CNT := V_CNT + 1;
    END LOOP;
    
    V_AVG := V_SUM / V_CNT;
    
    FOR I IN 1 .. V_NUM_ARR.COUNT LOOP
        V_VAR := V_VAR + POWER(V_NUM_ARR(I) - V_AVG, 2);
    END LOOP;
    
    V_VAR := V_VAR / V_CNT;
    
    DBMS_OUTPUT.PUT_LINE('�л갪��: ' || V_VAR);
    DBMS_OUTPUT.PUT_LINE('ǥ��������: ' || ROUND(SQRT(V_VAR)));
END;
/
