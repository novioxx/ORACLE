--1.DML
--1-1. INSERT INTO
INSERT INTO EMP(ENO,ENAME, JOB, HDATE, SAL)
            VALUES(3006, '홍길동', '개발', SYSDATE, 3000);
COMMIT;

--모든 컬럼의 데이터를 저장하는 
INSERT INTO EMP
VALUES('3007', '임꺽정', '설계', '2008',SYSDATEM, 3000, 200, '30'); 
COMMIT;

--COMMIT,ROLLBACK
--COMMIT은 작업의 완료
--ROLLBACK은 작업의 취소, COMMIT되기 전의 변경사항을 모두 취소.
INSERT INTO EMP
VALUES('3008', '장길산', '분석', '2008', SYSDATE, 3000, 100, '20');
COMMIT;

INSERT INTO EMP
VALUES('3008', '장길산', '분석', '2008', SYSDATE, 3000, 100, '20');
ROLLBACK;

--1-2. INSERT INTO 다량의 데이터 한번에 저장
CREATE TABLE EMP_COPY1(
        ENO VARCHAR2(4), ENAME VARCHAR(20), JOB VARCHAR(10), MGR VARCHAR2(4),
        HDATE DATE, SAL NUMBER(5), COMM NUMBER(5),DNO VARCHAR(2));

--EMP 테이블에서 DNO이 30인 데이터들만 가져와서 저장
INSERT INTO EMP_COPY1
SELECT *
FROM EMP
WHERE DNO = 30;
COMMIT;

--COURSE_PRFESS 테이블
CREATE TABLE COURSE_PRFESS(
    CNO VARCHAR2(8), CNAME VARCHAR2(20), ST_NUM NUMBER(1, 0),
    PNO VARCHAR2(8), PNAME VARCHAR2(20));

--COURSE_PRFESS 테이블에 COURSE,PROFESSOR 조인해서 PNAME까지 저장
INSERT INTO COURSE_PRFESS
SELECT C.*, P.PNAME
FROM COURSE C
JOIN PROFESSOR P
ON C.PNO = P.PNO;
COMMIT;

SELECT* FROM COURSE_PRFESS;
        
--1-3. UPDATE SET
-- 전체 데이터 수정
UPDATE EMP_COPY1
    SET
    MGR = '0001';
    
ROLLBACK;

--사원번호 3005번 보너스 COMM *3으로 수정
UPDATE EMP_COPY1
    SET
        COMM = 1800
        WHERE ENO = 3005;
ROLLBACK;

SELECT * 
        FROM EMP_COPY1;
        
--사원번호 3005번 보너스 COMM *3으로 수정(연산사용)
UPDATE EMP_COPY1
    SET
        COMM = COMM * 3
        WHERE ENO = 3005;
        
SELECT * 
        FROM EMP_COPY1;
        
--PROFESSOR 테이블의 HIREDATE + 20년 업데이트
UPDATE PROFESSOR
    SET
       --HIREDATE = ADD_MONTHS(HIREDATE, 20*12);
        HIREDATE = HIREDATE + (365 * 20);
ROLLBACK;
SELECT * 
        FROM PROFESSOR;

--EMP_COPY1의 데이터 삭제
DELETE FROM EMP_COPY1;

--삭제 했지만 COMMIT을 안했기때문에 완전삭제가 안됨. 저장하면 다시 불러온다
--EMP의 전체 데이터를 EMP_COPY에 저장
INSERT INTO EMP_COPY1
SELECT * FROM EMP;

SELECT*FROM EMP_COPY1;

-- 20,30번 부서 사원들 60부서로 통합 보너스가 현재 보너스의 * 1.5 변경
UPDATE EMP_COPY1
    SET 
        DNO = '60',
        COMM = COMM *1.5
        WHERE DNO IN ('20','30');
        
--DEPT_COPY 테이블 생성  =>DEPT에 있는 타입들 내용들 다 복사 저장한다
CREATE TABLE DEPT_COPY
        AS SELECT * FROM DEPT;
        
SELECT * FROM DEPT_COPY;

--서브쿼리를 이용한 데이터 수정
--변경될 컬럼들이랑 수정될 데이터의 순서를 일치해줘야 한다
UPDATE DEPT_COPY
        SET
            (DNO,DNAME,LOC) = ( SELECT DNO, DNAME, LOC
                            FROM DEPT
                            WHERE DNO = '50'
                            )
    WHERE DNO IN('20','30');

ROLLBACK;

SELECT * FROM DEPT;

--40번 부서의 DIRECTOR를 EMP테이블의 급여가 제일 높은 사운으로 업데이트
UPDATE DEPT
        SET     
            (DIRECTOR) = (
                                SELECT  MAX(SAL)
                                    FROM EMP E
                                   WHERE DNO = '40'         
                                    )
    WHERE DNO ='40';     
    
    SELECT * FROM DEPT;

UPDATE EMP_COPY1
    SET
        DIRETOR = ( SELECT ENO 
                    FROM EMP 
                    WHERE SAL
                                    = ( SELECT MAX(SAL)
                                            FROM EMP
                                            WHERE DNO = '40'
                                          ))
        WHERE DNO = '40';
        
SELECT * FROM DEPT_COPY;


--1-4. DELETE FROM
-- 전체 데이터 삭재 => 조건절 생략 
DELETE FROM EMP_COPY1;

SELECT * FROM EMP_COPY1;

ROLLBACK;

--일부 데이터만 삭제
--WHERE 절로 조건을 추가
DELETE FROM EMP_COPY1
    WHERE JOB = '지원';

ROLLBACK;    

SELECT * FROM  EMP_COPY1;

--WHERE절에 서브쿼리를 사용하여 특정 데이터 삭제
--EMP_SOPY1에서 급여가 4000이상 되는 사원 정보 삭제
DELETE FROM EMP_COPY1
WHERE ENO IN (
                        SELECT ENO
                        FROM EMP_COPY1
                        WHERE SAL >= 4000
                        );
   ROLLBACK;
   
--STUDENT 테이블 참조하여 ST_COPY 테이블 생성
CREATE TABLE ST_COPY
        AS SELECT * FROM STUDENT;
        
SELECT * FROM ST_COPY;


--SCORE 학생별 기말고사 성적 평균이 60점 이상인 학생정보 ST_COPY에서 삭제
DELETE ST_COPY
      WHERE (SNO) IN (       SELECT  SNO
                             FROM SCORE 
                             GROUP BY SNO
                             HAVING AVG(RESULT) >= 60   
                                    );
ROLLBACK;        

SELECT * FROM STUDENT;

SELECT * 
    FROM ST_COPY
    WHERE SNO IN('935602','915301');
    
--1-5. LOCK
--수정 후 트랜젝션 완료 안함
UPDATE EMP_COPY1
    SET
        ENAME = 'rrr'
        WHERE DNO = '60';

ROLLBACK;
SELECT * FROM EMP_COPY1;

--SELECT DEAD LOCK 구문(데이터가 많을 경우 하지 말 것)
SELECT A.*, B.*, C.* FROM STUDENT A, SCORE B, PROFESSOR C;


--DDL(CREAT, ALTER,DROP,TRUNCATE)