--1) 화학과 학생을 검색하라
SELECT MAJOR, SNAME FROM STUDENT WHERE MAJOR = '화학';

--2) 평점이 2.0 미만인 학생을 검색하라
SELECT AVR, SNAME, SNO FROM STUDENT WHERE AVR >= 2.0;

--3) 관우 학생의 평점을 검색하라
SELECT SNO,SNAME, AVR FROM STUDENT WHERE SNAME LIKE '관%';

--4) 정교수 명단을 검색하라
SELECT ORDERS, PNAME FROM PROFESSOR WHERE ORDERS = '정교수';


--5) 화학과 소속 교수의 명단을 검색하라
SELECT SECTION, PNAME FROM PROFESSOR WHERE SECTION = '화학';

--6) 송강 교수의 정보를 검색하라
SELECT * FROM PROFESSOR WHERE PNAME = '송강';

--7) 학년별로 화학과 학생의 성적을 검색하라
SELECT SYEAR, SNAME, AVR FROM STUDENT ORDER BY SYEAR;

--8) 2000년 이전에 부임한 교수의 정보를 부임일순으로 검색하라
SELECT PNAME,HIREDATE FROM PROFESSOR WHERE HIREDATE < TO_DATE('20000101', 'YYYYMMDD');

--9) 담당 교수가 없는 과목의 정보를 검색하라
SELECT * FROM COURSE WHERE PNO IS NULL;

