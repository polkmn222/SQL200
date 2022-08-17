-- EXAM168
SET SERVEROUTPUT ON

ACCEPT P_NUM PROMPT '���ڸ� �Է��ϼ��� ~ '
DECLARE
    V_CNT   NUMBER(10) := 0;
BEGIN
    WHILE V_CNT < &P_NUM LOOP
        V_CNT := V_CNT + 1;
        DBMS_OUTPUT.PUT_LINE(LPAD('*', V_CNT, '*'));
    END LOOP;
END;
/

-- EXAM169
SET SERVEROUTPUT ON

ACCEPT P_A PROMPT '������ ���ڸ� �Է��ϼ��� ~ '
ACCEPT P_B PROMPT '������ ���ڸ� �Է��ϼ��� ~ '

BEGIN
    FOR I IN 1 .. &P_B LOOP
        DBMS_OUTPUT.PUT_LINE(LPAD('*', &P_A, '*'));
    END LOOP;
END;
/

-- EXAM170
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_NUM1 PROMPT '�غ��� ���̸� �Է��ϼ��� ~ '
ACCEPT P_NUM2 PROMPT '���̸� �Է��ϼ��� ~ '
ACCEPT P_NUM3 PROMPT '������ ���̸� �Է��ϼ��� ~ '

DECLARE
    V_NUM1  NUMBER(10) := &P_NUM1;
    V_NUM2  NUMBER(10) := &P_NUM2;
    V_NUM3  NUMBER(10) := &P_NUM3;
BEGIN
IF (V_NUM1) ** 2 + (V_NUM2) ** 2 = (V_NUM3) ** 2 THEN
    DBMS_OUTPUT.PUT_LINE('�����ﰢ���� �½��ϴ�');
ELSE
    DBMS_OUTPUT.PUT_LINE('�����ﰢ���� �ƴմϴ�'); 
END IF;
END;
/

-- EXAM171
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_NUM PROMPT '���ڸ� �Է��ϼ���'
DECLARE
    V_NUM1  NUMBER(10) := &P_NUM1;
    V_NUM2  NUMBER(10) := &P_NUM2;
    
BEGIN
    LOOP
        V_NUM1 := V_NUM1 - 1;
        V_NUM2 := V_NUM2 * V_NUM1;
        EXIT WHEN V_NUM1 = 1;
END LOOP;
    DBMS_OUTPUT.PUT_LINE(V_NUM2);
END;
/

-- EXAM172
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_NUM1 PROMPT 'ù ��° ���ڸ� �Է��ϼ���'
ACCEPT P_NUM2 PROMPT '�� ��° ���ڸ� �Է��ϼ���'

DECLARE
    V_CNT   NUMBER(10);
    V_MOD   NUMBER(10);
BEGIN
    FOR I IN REVERSE 1 .. &P_NUM1 LOOP
        V_MOD := MOD(&P_NUM1, I) + MOD(&P_NUM2, I);
        V_CNT := I;
        EXIT WHEN V_MOD = 0;
    END LOOP;
        DBMS_OUTPUT.PUT_LINE(V_CNT);
    END;
/

-- EXAM173
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_NUM1 PROMPT 'ù ��° ���ڸ� �Է��ϼ��� ~ '
ACCEPT P_NUM2 PROMPT '�� ��° ���ڸ� �Է��ϼ��� ~ '
DECLARE
    V_NUM1  NUMBER(10) := &P_NUM1;
    V_NUM2  NUMBER(10) := &P_NUM2;
    V_CNT   NUMBER(10);
    V_MOD   NUMBER(10);
    V_RESULT    NUMBER(10);
BEGIN
    FOR I IN REVERSE 1 .. V_NUM1 LOOP
        V_MOD := MOD(V_NUM1, I) + MOD(V_NUM2, I);
        V_CNT := I;
        EXIT WHEN V_MOD = 0;
    END LOOP;
        V_RESULT := (V_NUM1 / V_CNT) * (V_NUM2 / V_CNT) * V_CNT;
        DBMS_OUTPUT.PUT_LINE(V_RESULT);
    END;
/

-- EXAM174
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_NUM PROMPT '������ 5���� ���ڸ� �Է��ϼ��� ~ '

DECLARE
    TYPE ARRAY_T IS VARRAY(10) OF NUMBER(10);
    ARRAY ARRAY_T := ARRAY_T();
    TMP NUMBER := 0;
    V_NUM VARCHAR2(50) := '&P_NUM';
    V_CNT NUMBER := REGEXP_COUNT(V_NUM, ' ') + 1;
    
BEGIN
    ARRAY.EXTEND(V_CNT);
    DBMS_OUTPUT.PUT('���� �� ���� : ');
    
    FOR I IN 1 .. ARRAY.COUNT LOOP
        ARRAY(I) := REGEXP_SUBSTR('&P_NUM', '[^ ]+', 1, I);
        DBMS_OUTPUT.PUT(ARRAY(I) || ' ');
    END LOOP;
    
    DBMS_OUTPUT.NEW_LINE;
    
    FOR I IN 1 .. ARRAY.COUNT -1 LOOP
        FOR J IN I + 1.. ARRAY.COUNT LOOP
            IF ARRAY(I) > ARRAY(J) THEN
                TMP := ARRAY(I);
                ARRAY(I) := ARRAY(J);
                ARRAY(J) := TMP;
            END IF;
        END LOOP;
    END LOOP;
        DBMS_OUTPUT.PUT('���� �� ���� : ');
    FOR I IN 1.. ARRAY.COUNT LOOP
        DBMS_OUTPUT.PUT(ARRAY(I) || ' ');
    END LOOP;
        DBMS_OUTPUT.NEW_LINE;
END;
/

-- EXAM175
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_NUM PROMPT '������ 5���� ���ڸ� �Է��ϼ��� ~ '

DECLARE
    TYPE ARRAY_T IS VARRAY(100) OF NUMBER(10);
    VARRAY ARRAY_T := ARRAY_T();
    V_TEMP NUMBER(10);
       
BEGIN
    VARRAY.EXTEND(REGEXP_COUNT('&P_NUM', ' ') +1 );
   
    FOR I IN 1 .. VARRAY.COUNT LOOP
        VARRAY(I) := TO_NUMBER(REGEXP_SUBSTR('&P_NUM', '[^ ]+', 1, I));
    END LOOP;
    
    
    FOR J IN 1 .. VARRAY.COUNT  LOOP
        FOR K IN 1 .. J - 1 LOOP
            IF VARRAY(K) > VARRAY(J) THEN
                V_TEMP := VARRAY(J);
        FOR Z IN REVERSE K .. J - 1 LOOP
            VARRAY(Z+1) := VARRAY(Z);
        END LOOP;
    
        VARRAY(K) := V_TEMP;
        END IF;
    END LOOP;
END LOOP;
        
    FOR I IN 1.. VARRAY.COUNT LOOP
        DBMS_OUTPUT.PUT(VARRAY(I) || ' ');
    END LOOP;
        DBMS_OUTPUT.NEW_LINE;
END;
/

-- EXAM176
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_NUM PROMPT '�������� ������ ���ڵ��� ������ �Է��ϼ��� ~ '
ACCEPT P_A PROMPT '�˻��� ���ڸ� �Է��ϼ��� ~ '

DECLARE
    TYPE ARRAY_T IS VARRAY(100) OF NUMBER(30);
    ARRAY_S     ARRAY_T := ARRAY_T();
    V_CNT   NUMBER(10) := &P_NUM;
    V_A     NUMBER(10) := &P_A;
    V_CHK   NUMBER(10) := 0;
    
BEGIN

ARRAY_S.EXTEND(V_CNT);

FOR I IN 1 .. V_CNT LOOP
    ARRAY_S(I) := ROUND(DBMS_RANDOM.VALUE(1, V_CNT));
    DBMS_OUTPUT.PUT(ARRAY_S(I) || ',');
END LOOP;
    DBMS_OUTPUT.NEW_LINE;
    
FOR I IN ARRAY_S.FIRST .. ARRAY_S.LAST LOOP

IF V_A = ARRAY_S(I) THEN
    V_CHK := 1;
    DBMS_OUTPUT.PUT(I || '��°���� ���� ' || V_A || '�� �߰��߽��ϴ�.');
END IF;

END LOOP;

    DBMS_OUTPUT.NEW_LINE;
    
IF V_CHK = 0 THEN
    DBMS_OUTPUT.PUT_LINE('���ڸ� �߰����� ���߽��ϴ�.');
END IF;

END;
/

-- EXAM177
SET SERVEROUTPUT ON

DECLARE
    V_CNT   NUMBER(10, 2) := 0;
    V_A     NUMBER(10, 2);
    V_B     NUMBER(10, 2);
    V_PI    NUMBER(10, 2);
    
BEGIN
    FOR I IN 1 .. 1000000 LOOP
        V_A := DBMS_RANDOM.VALUE(0, 1);
        V_B := DBMS_RANDOM.VALUE(0, 1);
        
        IF POWER(V_A, 2) + POWER(V_B, 2) <= 1 THEN
            V_CNT := V_CNT + 1;
        END IF;
    END LOOP;
    
        V_PI := (V_CNT/1000000) * 4;
        DBMS_OUTPUT.PUT_LINE(V_PI);
END;
/

-- EXAM178
SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT P_MONEY PROMPT '�ܵ� ��ü �ݾ��� �Է��ϼ��� ~ '
ACCEPT P_COIN PROMPT '�ܵ� ������ �Է��ϼ��� ~ '

DECLARE
    V_MONEY NUMBER(10) := &P_MONEY;
    TYPE ARRAY_T IS VARRAY(3) OF NUMBER(10);
    V_ARRAY ARRAY_T := ARRAY_T(&P_COIN);
    V_NUM ARRAY_T := ARRAY_T(0, 0, 0);
    
BEGIN
    FOR I IN 1 .. V_ARRAY.COUNT LOOP
        IF V_MONEY >= V_ARRAY(I) THEN
            V_NUM(I) := TRUNC(V_MONEY / V_ARRAY(I));
            V_MONEY := MOD(V_MONEY, V_ARRAY(I));
        END IF;
        DBMS_OUTPUT.PUT(V_ARRAY(I) || '���� ����: ' || V_NUM(I) || '��, ');
    END LOOP;
DBMS_OUTPUT.NEW_LINE;
END;
/