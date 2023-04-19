--1 .오라클 객체
-- 1-1. 데이터 사전
--STUDY계정이 사용할 수 있는 데이터 사전 조회
SELECT * FROM DICT;

SELECT * FROM DICTIONARY
    WHERE TABLE_NAME LIKE '%USER%';
    
-- STUDY 계졍이 가지고 있는 객체의 정보를 확인
--소유권이 STUDY에 있는 테이블 목록 조회
SELECT TABLE_NAME
    FROM USER_TABLES;

--OWNER 컬럼이 없음.
--현재 접속한 사용자가 소유한 테이블의 정보만 담고 있어서
SELECT * FROM USER_TABLES;

--STUDY계정이 권한을 가지고 사용할 수 있는 객체 정보
--STUDY계정에 DBA 권한이 있어서 SYS가 소유하고 있는 테이블도 사용할 수 있다.
SELECT OWNER, TABLE_NAME
    FROM ALL_TABLES;
    
--OWNER 컬럼이 존재
--다른 사용자가 소유하고 있는 테이블의 권한만 가지고 있을 수도 있기 때문에
SELECT * FROM ALL_TABLES;

--데이터베이스 시스템 관련 정보들
SELECT * FROM DBA_TABLES;

--현재 데이터베이스에 접속한 세션정보 확인
SELECT SID, OSUSER, SERIAL#, PROGRAM
    FROM V$SESSION;
    
--세션을 KILL해서 접속을 끊어버리는 쿼리(DB 락걸렸을 때) --
ALTER SYSTEM KILL SESSION '128,33497' IMMEDIATE;

--LOCK 걸린 객체를 확인하는 쿼리
SELECT OBJECT_ID, SESSIN_ID,ORACLE_USERNAME, OS_USER_NAME
FROM V$LOKED_OBJECT;

UPDATE PF_TEMP
    SET
        PNAME = 'AAA';
        
--LOCK 걸린 SESSION 조회
SELECT L.OBJECT_ID, S.SID, L.ORACLE_USERNAME, S.SERIAL$, S.OSUSER, S.PROGRAM
FROM V$SESSION S
JOIN V$LOKED_OBJECT L
ON S.SID = L.SESSION_ID;

--1-2. 인덱스
-- 인덱스 생성
--STUDENT 테이블에 SNAME을 INDEX로 생성(비 고유 인덱스)
CREATE INDEX STUDENT_IDX
ON STUDENT(SNAME);

--여러개의 컬럼을 선택하여 복합 인덱스 생성
--PROFESSOR 테이블에 PNO,PNAME을 복합 인덱스로 생성
CREATE INDEX PROFESSOR_PNO_PNAME_INDEX
ON PROFESSOR(PNO,PNAME);

--수식으로 인덱스 생성
--테이블에 여러개의 인덱스 생성 가능
--STUDENT 테이블에 평점을 4.5로 환산한 평점 인덱스로 지정
--수식으로 만든 인덱스는 컬럼명이 표시되지 않고 시스템에서 자동으로 생성한 수식의 이름을 사용한다.
CREATE INDEX STUDENT_CONVERT_AVR_INDEX
ON STUDENT(AVR *4.5 /4.0);

--생성된 인덱스 확인
SELECT UIC.INDEX_NAME, UIC.COLUMN_NAME,UIC.COLUMN_POSITION,UI.UNIQUENESS
FROM USER_INDEXES UI
JOIN USER_IND_COLUMNS UIC
ON UI.INDEX_NAME = UIC.INDEX_NAME
AND UI.TABLE_NAME IN('STUDENT', 'PROFESSOR')
ORDER BY UI.TABLE_NAME, UI.INDEX_NAME, UIC.COLUMN_POSITION;

--INDEX 삭제
DROP INDEX STUDENT_IDX;
DROP INDEX PROFESSOR_PNO_PNAME_INDEX;
DROP INDEX STUDENT_CONVERT_AVR_INDEX;

SELECT * FROM STUDENT;

--1-3. VIEW
-- 뷰의 생성
--과목별 학과별 기말고사의 평균을 저장하는 뷰 생성
CREATE OR REPLACE VIEW V_AVG_SCORE(
    CNO,CNAME,MAJOR,AVGRESULT --컬럼명을 커스터마이징해서 사용할 수 있기 때문에 원천테이블의 컬럼명을 노출하지 않을 수 있다.
    )AS (
    --위에서 지정한 컬럼의순서와 개수가 일치해야 한다.
        SELECT CNO, C.CNAME, ST.MAJOR, ROUND(AVG(SC.RESULT),2)
        FROM COURSE C
        NATURAL JOIN SCORE SC
        JOIN STUDENT ST ON SC.SNO = ST.SNO
        GROUP BY CNO, C.CNAME, ST.MAJOR 
        );
SELECT * FROM V_AVG_SCORE;
--원천 테이블의 데이터가 변경되면 뷰의 데이터도 자동으로 변경
UPDATE COURSE
    SET 
        CNAME = '일반화학1'
        WHERE CNAME = '일반화학';
        
UPDATE STUDENT
    SET 
        MAJOR = '유공'
        WHERE MAJOR = '유공1';
    COMMIT;

SELECT * FROM V_AVG_SCORE
ORDER BY CNO, MAJOR;

--단순 뷰 생성(DML의 사용이 가능)
--조회해온 데이터가 SYEAR가 1인 데이터이기 때문에
--DML도 SYEAR가 1인 데이터만 추가,수정 가능
--DML을 사용하면 원천테이블의 데이터가 추가/삭제/수정하는데 
--조회커리가 1학년만 가져오는 쿼리라서 원천테이블에 추가된 2,3,4학년의 데이터는
--표출되지 않는다.
CREATE OR REPLACE VIEW ST_CH(
        SNO,SNAME,SYEAR,AVR)
        AS ( SELECT SNO, SNAME, SYEAR, AVR
            FROM STUDENT
            WHERE SYEAR = 1
            );

SELECT *
    FROM ST_CH;
    
--단순 뷰에서 DML의 사용
INSERT INTO VIEW ST_CH
VALUES( '9001', '홍길동', 1, 4.0);

COMMIT;

ROLLBACK;

--CHECK OPTION 추가하면 제약조건이 생성되어
--조회해온 조건에 맞는 데이터만 추가할 수 있도록 변경
--1학년 데이터만 조회해오기 때문에 1학년 데이터만 입력할 수 있도록 변경
CREATE OR REPLACE VIEW ST_CH(
        SNO,SNAME,SYEAR,AVR)
        AS ( SELECT SNO, SNAME, SYEAR, AVR
            FROM STUDENT
            WHERE SYEAR = 1
            ) WITH CHECK OPTION CONSTRAINT VIEW_ST_CH_CK;

--1-4. 인라인 뷰
-- FROM 절에 사용되는 쿼리
SELECT E.ENO,E.ENAME,E.DNO,B.SAL
FROM EMP E
JOIN ( SELECT DNO, MIN(SAL) AS SAL
            FROM EMP
            GROUP BY DNO
            )B
            ON E.SAL = B.SAL;

--뷰의 삭제 방법
DROP VIEW ST_CH;
DROP VIEW V_AVG_SCORE;


--인라인 뷰와 ROWNUM을 이용해서 최상위 N데이터 조회
--급여 최상위 3명 데이터 조회
SELECT ROWNUM, A.ENO, A.ENAME, A.SAL
FROM (  SELECT ENO,ENAME,SAL
            FROM  EMP
            ORDER BY SAL DESC
        )A
    WHERE ROWNUM <= 3;
    
--학과별 기말고사 성적의 평균이 가장 높은 3개 학과 조회 ( CNO,CNAME,AVG(RESULT)
SELECT ROWNUM, C.CNO, C.CNAME, A.SER
FROM COURSE C
JOIN ( SELECT S.CNO, AVG(S.RESULT) AS SER
        FROM SCORE S
        GROUP BY S.CNO
        ORDER BY AVG(RESULT) DESC
        )A
        ON C.CNO = A.CNO
        WHERE ROWNUM <= 3;
        
SELECT ROWNUM, ST.SNO, ST.MAJOR, A.BBQ
FROM STUDENT ST
JOIN ( SELECT SC.SNO, ROUND(AVG(SC.RESULT),2) AS BBQ
        FROM SCORE SC
        GROUP BY SC.SNO
        ORDER BY BBQ DESC
        )A
        ON ST.SNO = A.SNO
        WHERE ROWNUM <=3;
        

SELECT A.*
        FROM ( SELECT ROWNUM AS RN, ST.*
            FROM STUDENT ST
            )A
            WHERE A.RN > 5;
            
--잘못된 ROWNUM의 사용
--ROWNUM이 붙은 다음 정렬이 일어남
SELECT ENO, ENAME, SAL
    FROM EMP
        WHERE ROWNUM <=3
        ORDER BY SAL DESC;
        
--
SELECT B.* 
FROM (
SELECT ROWNUM AS RN, A.ENO,A.ENAME,A.SAL
    FROM ( SELECT ENO,ENAME,SAL
    FROM EMP
    ORDER BY SAL DESC
    )A
    )B
    WHERE B.RN > 3;


--시퀀스 2개 생성
--옵션추가한 시퀀스 생성
CREATE SEQUENCE EMP_CO_ENO_SEQ
    START WITH 1
    INCREMENT BY 2
    MAXVALUE 10
    NOMINVALUE
    CYCLE
    NOCACHE;
    
--옵션을 하나도 추가하지 않은 시퀀스를 생성
CREATE SEQUENCE DEPT_CO_DNO_SEQ1;

--NEXTVAL 시퀀스가 가르키는 값을 다음값으로 옮긴다.
INSERT INTO EMP_COPY --다음값을 가리킴
VALUES(EMP_CO_ENO_SEQ.NEXTVAL, 'F', '개발', 0, SYSDATE, 3000, 100, 0);

--CURRVAL 시퀀스가 현재 가리키고 있는 값을 가져온다.
INSERT INTO EMP_COPY--현재값을 가리킴
VALUES(EMP_CO_ENO_SEQ.CURRVAL, 'F', '개발', 0, SYSDATE, 3000, 100, 0);

SELECT * FROM EMP_COPY;

CREATE TABLE EMP_COPY
    AS SELECT * FROM EMP;
    
    
--옵션이 하나도 없는 시퀀스 사용
INSERT INTO DEPT_COPY
VALUES(DEPT_CO_DNO_SEQ1.NEXTVAL, '개발', '서울', 0);

SELECT * FROM DEPT_COPY;

--생성된 시퀀스를 조회하는 쿼리
SELECT SEQUENCE_NAME, MAX_VALUE, MIN_VALUE
      INCREMENT_BY, CACHE_SIZE, LAST_NUMBER, CYCLE_FLAG
      FROM USER_SEQUENCES;

--시퀀스의 현재값을 조회
SELECT DEPT_CO_DNO_SEQ1.CURRVAL FROM DUAL;

--시퀀스의 다음 값을 조회
--NEXTVAL 호출시 무조건 시퀀스가 다음값으로 세팅됨
SELECT DEPT_CO_DNO_SEQ1.NEXTVAL FROM DUAL;

-- 시퀀스의 수정
ALTER SEQUENCE DEPT_CO_DNO_SEQ1    
            INCREMENT BY 5 --5씩 증가
            MAXVALUE 100
            CYCLE;
            
SELECT DEPT_CO_DNO_SEQ1.CURRVAL FROM DUAL;

--시퀀스의 삭제
DROP SEQUENCE DEPT_CO_DNO_SEQ1;    


--1-5. SYNONYM 동의어 AKA.별칭
-- 현재 접속한 사용자에서 계속 사용할 수 있는 테이블 별칭 추가
CREATE SYNONYM DC
        FOR DEPT_COPY;
      ROLLBACK;  
      
SELECT * FROM DC;

--SYNONYM 삭제
DROP SYNONYM DC;

-- PUBLIC 모든 사용자가 계속 사용할 수 있는 테이블의 별칭 주기
CREATE PUBLIC SYNONYM EC
        FOR C##STUDY.EMP_COPY;
        
--PUBLIC SYNONYM 삭제
DROP PUBLIC SYNONYM EC;
        
SELECT * FROM EC;
