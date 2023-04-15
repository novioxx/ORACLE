--1) 각 학생의 평점을 검색하라(별칭을 사용)
SELECT substr(AVR, 0 ,3) AS STUDENT_NO
        , SNAME AS
    FROM STUDENT;

--2) 각 과목의 학점수를 검색하라(별칭을 사용)
SELECT ST_NUM AS 학점
    , CNAME AS 과목
    FROM COURSE;

--3) 각 교수의 지위를 검색하라(별칭을 사용)
SELECT PNAME AS 교수
    ,  ORDERS AS 직위
    FROM PROFESSOR;
    

--4) 급여를 10%인상했을 때 연간 지급되는 급여를 검색하라(별칭을 사용)
SELECT SAL * 1.1  AS 급여
    FROM EMP;
    
--5) 현재 학생의 평균 평점은 4.0만점이다. 이를 4.5만점으로 환산해서 검색하라(별칭을 사용)
SELECT ST.SNO, ST.SNAME, ST.AVR * 4.5 / 4.0 FROM STUDENT ST;