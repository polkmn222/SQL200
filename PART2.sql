-- EXAM016
SELECT UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
    FROM EMP;
    
-- EXAM016-2
SELECT ENAME, SAL
    FROM EMP
    WHERE LOWER(ENAME) = 'scott';
    
-- EXAM017
SELECT SUBSTR('SMITH', 1, 3)
    FROM DUAL;
    
-- EXAM018
SELECT ENAME, LENGTH(ENAME)
    FROM EMP;
    
-- EXAM018-2
SELECT LENGTH('�����ٶ�')
    FROM DUAL;

-- EXAM018-3
SELECT LENGTHB('�����ٶ�')
    FROM DUAL;
    
-- EXAM019
SELECT INSTR('SMITH', 'M')
    FROM DUAL;
    
-- EXAM019-2
SELECT INSTR('abcdefg@naver.com', '@')
    FROM DUAL;
    
-- EXAM019-3
SELECT SUBSTR('abcdefgh@naver.com', INSTR('abcdefgh@naver.com', '@') + 1)
    FROM DUAL;    

-- EXAM019-4
SELECT RTRIM(SUBSTR('abcdefgh@naver.com', INSTR('abcdefgh@naver.com', '@') + 1), '.com')
    FROM DUAL;
    
-- EXAM020
SELECT ENAME, REPLACE(SAL, 0, '*')
    FROM EMP;
    
-- EXAM020-2
SELECT ENAME, REGEXP_REPLACE(SAL, '[0-3]', '*') AS SALARY
    FROM EMP;

CREATE TABLE TEST_ENAME
(ENAME  VARCHAR2(10));

INSERT INTO TEST_ENAME VALUES('����ȣ');
INSERT INTO TEST_ENAME VALUES('�Ȼ��');
INSERT INTO TEST_ENAME VALUES('�ֿ���');
COMMIT;

-- EXAM020-3
SELECT REPLACE(ENAME, SUBSTR(ENAME, 2, 1), '*') AS "������_�̸�"
    FROM TEST_ENAME;
    
-- EXAM021
SELECT ENAME, LPAD(SAL, 10, '*') AS SALARY1, RPAD(SAL, 10, '*') AS SALARY2
    FROM EMP;
    
-- EXAM021-2
SELECT ENAME, SAL, LPAD('%', ROUND(SAL/100), '%') AS BAR_CHART
    FROM EMP;
    
-- EXAM022
SELECT 'SMITH', LTRIM('SMITH', 'S'), RTRIM('SMITH', 'H'), TRIM('S' FROM 'SMITHS')
    FROM DUAL;
    
-- EXAM022-2
INSERT INTO EMP(EMPNO, ENAME, SAL, JOB, DEPTNO) VALUES(8291, 'JACK   ', 3000, 'SALESMAN', 30);
COMMIT;

-- EXAM022-3
SELECT ENAME, SAL
    FROM EMP
    WHERE ENAME = 'JACK';
    
-- EXAM022-4
SELECT ENAME, SAL
    FROM EMP
    WHERE RTRIM(ENAME) = 'JACK';
    
-- EXAM022-5
DELETE FROM EMP WHERE TRIM(ENAME) = 'JACK';
COMMIT;

-- EXAM023
SELECT '876.567' AS ����, ROUND(876.567, 1)
    FROM DUAL;
    
-- EXAM024
SELECT '876.567' AS ����, TRUNC(876.567, 1)
    FROM DUAL;
    
-- EXAM025
SELECT MOD(10, 3)
    FROM DUAL;
    
-- EXAM025-2
SELECT EMPNO, MOD(EMPNO, 2)
    FROM EMP;
    
-- EXAM025-3
SELECT EMPNO, ENAME
    FROM EMP
    WHERE MOD(EMPNO, 2) = 0;
    
-- EXAM025-4
SELECT FLOOR(10/3)
    FROM DUAL;
    