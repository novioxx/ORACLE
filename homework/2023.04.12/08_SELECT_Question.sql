--1) 평점이 3.0에서 4.0사이의 학생을 검색하라
SELECT ST.*
    , ST.AVR
FROM STUDENT ST
WHERE AVR BETWEEN 3.0 AND 4.0;

--2) 1994년에서 1995년까지 부임한 교수의 명단을 검색하라
SELECT P.*
    ,  P.HIREDATE
FROM PROFESSOR P
      WHERE HIREDATE
      BETWEEN TO_DATE('19940101 00:00:00', 'yyyyMMdd HH24:mi:ss')
      AND TO_DATE('19951231 23:59:59', 'yyyyMMdd HH24:mi:ss')
      ORDER BY HIREDATE;



--3) 화학과와 물리학과, 생물학과 학생을 검색하라


--4) 정교수와 조교수를 검색하라


--5) 학점수가 1학점, 2학점인 과목을 검색하라


--6) 1, 2학년 학생 중에 평점이 2.0에서 3.0사이인 학생을 검색하라


--7) 화학, 물리학과 학생 중 1, 2 학년 학생을 성적순으로 검색하라


--8) 부임일이 1995년 이전인 정교수를 검색하라