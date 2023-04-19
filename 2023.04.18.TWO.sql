--1. DDL
--1-1. 다른 테이블 참조하여 테이블 생성
CREATE TABLE COURSE_PROFESSOR (CNO, CNAME, PNO, PNAME, AVGRES)
    AS SELECT CNO, C.CNAME, PNO, P.PNAME, ROUND(AVG(RESULT),2)
    FROM COURSE C
    NATURAL JOIN SCORE SC
    NATURAL JOIN PROFESSOR P
    GROUP BY CNO, C.CNAME, PNO, P.PNAME;
    SELECT * FROM COURSE_PROFESSOR;
    
--STUDENT의 SNO, SNAME, MAJOR,SYEAR,SCORE의 학생별 RESULT, SCGRADE의 GRADE
--SCORE_GRADE
CREATE TABLE SCORE_GRADE (SNO,SNAME,MAJOR,SYEAR,RESULT,GRADE)
    AS SELECT ST.SNO, ST.SNAME, ST.MAJOR, ST.SYEAR, SC.RESULT, G.GRADE
    FROM STUDENT ST
     JOIN SCORE SC
     ON ST.SNO = SC.SNO
     JOIN SCGRADE G
     ON SC.RESULT BETWEEN LOSCORE AND HISCORE; --비등가 조인
    
    SELECT * FROM SCORE_GRADE;


--강사님 답안
CREATE TABLE SCORE_GRADE (SNO,SNAME,MAJOR,SYEAR,RESULT,GRADE)
    AS SELECT ST.SNO, ST.SNAME,ST.MAJOR, ST.SYEAR, SC.RESULT,G.GRADE
    FROM STUDENT ST
    NATURAL JOIN SCORE SC
    JOIN SCGRADE G
    ON SC.RESULT BETWEEN SC.LOSCORE AND SC.HISCORE; --위에 만들어서 조회안됨.
    
--1-2. ALTER
-- 컬럼을 추가하는 ADD

--EMP_COPY 테이블에 ADDR컬럼 추가
ALTER TABLE EMP_COPY1
    ADD ADDR VARCHAR2(50);
    
SELECT * FROM EMP_COPY1;

--컬럼명을 변경하는 RENAME
--EMP_COPY 테이블의 SAL 컬럼을 SALARY 변경
ALTER TABLE EMP_COPY1
    RENAME COLUMN SAL TO SALARY;
    
    SELECT * FROM EMP_COPY1;
    
--컬럼의 데이터타입을 변경하는 MODIFY
--EMP_COPY1 의 ENO 컬럼의 데이터타입을 VARCHAR2(4) -> VARCHAR(10)
ALTER TABLE EMP_COPY1
    MODIFY ENO VARCHAR2(10);
    
--컬럼을 삭제하는 DROP
----EMP_COPY1 테이블에 ADDR컬럼 삭제
ALTER TABLE EMP_COPY1
    DROP COLUMN ADDR;

--1-3. 테이블을 삭제하는 DROP 테이블
CREATE TABLE SCORE_COPY
    AS SELECT * FROM SCORE;
    
SELECT * FROM SCORE_COPY;
--SCORE_COPY 테이블 삭제
DROP TABLE SCORE_COPY;

--DELETE로 삭제된 데이터를 조회하는 TIMESTAMP
--ENTERPRISE 버전에서는 FLASHBACK 이라는 기능으로 DROP한 테이블 복구 가능
SELECT * FROM SCORE_COPY
    AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '180' MINUTE);

DELETE FROM EMP_COPY1;
    
SELECT * FROM EMP_COPY1;
--TIMESTAMP 이용해서 삭제된 데이터 복구
INSERT INTO EMP_COPY1
SELECT * FROM EMP_COPY1 
    AS OF TIMESTAMP(SYSTIMESTAMP - INTERVAL '14' MINUTE);
    
--1-4. RENAME
RENAME EMP_TEMP1 TO EMP_TEMP;

SELECT * FROM EMP_TEMP;


--1-5. 테이블의 데이터를 삭제하는 TRUNCATE
--ROLLBACK하면 컬럼명은 복구되지만 데이터는 복구 불가능
TRUNCATE TABLE EMP_TEMP;
ROLLBACK;

SELECT * FROM EMP_TEMP;
