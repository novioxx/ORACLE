--1) 학생의 평균 평점을 다음 형식에 따라 소수점 이하 2자리까지 검색하세요
--'OOO 학생의 평균 평점은 O.OO입니다.'
SELECT SNAME || '학생의 평균 평점은' || ROUND(AVR, 2) || '입니다'
    FROM STUDENT;

--2) 교수의 부임일을 다음 형식으로 표현하세요
--'OOO 교수의 부임일은 YYYY년 MM월 DD일입니다.'
SELECT P.PNAME,
       P.HIREDATE,
    TO_CHAR(HIREDATE, 'YYYY"년"MM"월"DD"일입니다"')
        FROM PROFESSOR P;
        
-- SELECT PNAME || ' 교수의 부임일은' || TO_CHAR(HIREDATE, 'YYYY) || '년' || TO_CHAR(HIREDATE, 'MM') ||
--   '월' || TO_CHAR(HIREDATE, 'DD') || '일입니다'
--   FROM PROFESSOR;

--SELECT PANAME || TO_CHAR(HIREDATE, '"교수의 부임일은 "YYYY년 "MM"월 "DD"일입니다."')
--  FROM PROFESSOR;

--3) 교수중에 3월에 부임한 교수의 명단을 검색하세요
SELECT PNAME, 
       HIREDATE,
       PNO
    FROM PROFESSOR
    WHERE EXTRACT(MONTH FROM HIREDATE) = 3
    ORDER BY HIREDATE;
-- EXTRACT 날짜/시간을 추출(추출하고자 하는 요소 FROM 추출대상)
--HIREDATE 에서 '월'을 추출