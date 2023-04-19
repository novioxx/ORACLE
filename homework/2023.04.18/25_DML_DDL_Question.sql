--1) STUDENT 테이블을 참조하여 ST_TEMP 테이블을 만들고 모든 학생의 성적을 4.5만점 기준으로 수정하세요
CREATE TABLE ST_TEMP
    AS SELECT * FROM STUDENT;

UPDATE ST_TEMP
    SET
       AVR = AVR *4.5 / 4.0;
       
       COMMIT;

SELECT * FROM ST_TEMP;
--2) PROFESSOR 테이블을 참조하여 PF_TEMP 테이블을 만들고 모든 교수의 부임일자를 100일 앞으로 수정하세요
CREATE TABLE PF_TEMP
    AS SELECT * FROM PROFESSOR;
    
UPDATE PF_TEMP
    SET
         HIREDATE = HIREDATE - 100; 

SELECT * FROM PF_TEMP;
ROLLBACK;
--3) ST_TEMP 테이블에서 화학과 2학년 학생의 정보를 삭제하세요
DELETE FROM ST_TEMP
WHERE SYEAR IN (
                        SELECT SYAER
                        FROM ST_TEMP
                        WHERE MAJOR = '화학' AND SYEAR = 2
                        );
   ROLLBACK;
--4) PF_TEMP 테이블에서 조교수의 정보를 삭제하세요
DELETE FROM PF_TEMP
WHERE ORDERS IN (
                        SELECT ORDERS
                        FROM PF_TEMP
                        WHERE ORDERS = '조교수'
                        );
    COMMIT;                    
          
SELECT * FROM PF_TEMP;
--5) EMP 테이블을 참조하여 EMP2 테이블을 만들고 DNO = 30인 사원의 보너스를 15프로 상승시킨 값으로 변경하시고 
--   DNO = 20인 사원의 급여를 10프로 상승시킨 값으로 변경하세요.
CREATE TABLE EMP2
      AS SELECT * FROM EMP;
      
UPDATE EMP2
        SET
           DNO = '30',
        COMM = COMM *1.15;
UPDATE EMP2       
         SET DNO = '20',
        SAL = SAL * 1.1;  
        
--6) 화학과 2학년 학생중 기말고사 성적의 등급이 A, B인 정보를 갖는 테이블 SCORE_STGR을 생성하세요.(SNO, SNAME, MAJOR, SYEAR, RESULT, GRADE)
CREATE TABLE SCORE_STGR (SNO, SNAME, MAJOR, SYEAR, RESULT, GRADE)
      AS SELECT SC.SNO, ST.SNAME, ST.MAJOR, ST.SYEAR, SC.RESULT, SG.GRADE
      FROM SCORE SC
      JOIN SCGRADE SG
      ON SC.RESULT BETWEEN SG.LOSCORE AND SG.HISCORE
      JOIN ST_TEMP ST
      ON ST.SNO = SC.SNO
      WHERE SG.GRADE IN ('A','B') AND ST.MAJOR = '화학';

SELECT * FROM SCORE_STGR;
      
--7) 생물학과 학생중 평점이 2.7이상인 학생이 수강중인 과목의 정보를 갖는 테이블 ST_COURSEPF를 생성하세요.
--  (SNO, SNAME, CNO, CNAME, PNO, PNAME, AVR)
CREATE TABLE ST_COURSEPF (SNO, SNAME, CNO, CNAME, PNO, PNAME, AVR, RESULT)
    AS SELECT SC.SNO, ST.SNAME, C.CNO, C.CNAME, P.PNO, P.PNAME, ST.AVR,SC.RESULT
    FROM COURSE C
    JOIN PROFESSOR P ON C.PNO = P.PNO
    JOIN SCORE SC ON SC.CNO = C.CNO
    JOIN STUDENT ST ON ST.SNO = SC.SNO
    WHERE ST.AVR >= 2.7 AND ST.MAJOR = '생물';

DROP TABLE ST_COURSEPF;

SELECT * FROM ST_COURSEPF;

--NATURAL JOIN 사용
CREATE TABLE ST_COURSEPF
    AS SELECT SNO,ST.SNAME, CNO, C.CNAME, PNO, P.PNAME, SC.RESULT, ST.AVR
    FROM STUDENT ST
    NATURAL JOIN SCORE SC
    NATURAL JOIN COURSE C
    NATURAL JOIN PROFESSOR P
    WHERE ST.MAJOR = '생물'
    AND ST.AVR >= 2.7;