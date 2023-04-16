--1) 각 학생의 평점을 검색하라(별칭을 사용)
SELECT ST.SNAME, ST.AVR FROM STUDENT ST;

--2) 각 과목의 학점수를 검색하라(별칭을 사용)
SELECT C.CNAME, C.ST_NUM FROM COURSE C;

--3) 각 교수의 지위를 검색하라(별칭을 사용)
SELECT P.ORDERS, P.PNAME FROM PROFESSOR P; 

--4) 급여를 10%인상했을 때 연간 지급되는 급여를 검색하라(별칭을 사용)
SELECT E.SAL * 1.1 FROM EMP E;

--5) 현재 학생의 평균 평점은 4.0만점이다. 이를 4.5만점으로 환산해서 검색하라(별칭을 사용)
SELECT ST.SNO, ST.SNAME, ST.AVR * 4.5 / 4.0 FROM STUDENT ST;




