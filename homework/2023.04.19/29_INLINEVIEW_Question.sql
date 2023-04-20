--1) 4.5 환산 평점이 가장 높은 3인의 학생을 검색하세요.
SELECT ROWNUM, A.SNO, A.SNAME, A.RR
            FROM ( SELECT SNO,SNAME, AVR * 4.5 / 4.0 AS RR
                        FROM STUDENT  
                        ORDER BY RR DESC
                  )A
                  WHERE ROWNUM <= 3;

--2) 기말고사 과목별 평균이 높은 3과목을 검색하세요.(
SELECT ROWNUM, C.CNO, C.CNAME, A.SER
FROM COURSE C
JOIN ( SELECT S.CNO, AVG(S.RESULT) AS SER
        FROM SCORE S
        GROUP BY S.CNO
        ORDER BY AVG(RESULT) DESC
        )A
        ON C.CNO = A.CNO
        WHERE ROWNUM <= 3;

SELECT ROWNUM, A.CNO, A.CNAME ,A.AVGRES
FROM    ( SELECT  CNO,C.CNAME,ROUND(AVG(SC.RESULT),2)AS AVGRES
            FROM COURSE C
            NATURAL JOIN SCORE SC
            GROUP BY CNO, C.CNAME
            ORDER BY AVGRES DESC
            )A
            WHERE ROWNUM <= 3;
--3) 학과별, 학년별, 기말고사 평균이 순위 3까지를 검색하세요.(학과, 학년, 평균점수 검색)
SELECT ROWNUM, ST.MAJOR,ST.SYEAR, A.SER
FROM STUDENT ST
JOIN ( SELECT SS.MAJOR, SS.SYEAR, AVG(C.RESULT) AS SER
        FROM STUDENT SS
        JOIN SCORE C ON C.SNO = SS.SNO
        GROUP BY SS.MAJOR,SS.SYEAR
        ORDER BY AVG(RESULT) DESC 
        )A
        ON ST.MAJOR = A.MAJOR
        WHERE ROWNUM <= 3;
        
--4) 기말고사 성적이 높은 과목을 담당하는 교수 3인을 검색하세요.(교수이름, 과목명, 평균점수 검색)
SELECT ROWNUM,PNAME,CNAME,RR
    FROM ( SELECT P.PNAME,C.CNAME,AVG(S.RESULT) AS RR
            FROM PROFESSOR P 
            NATURAL JOIN COURSE C
            JOIN SCORE S ON C.CNO = S.CNO
            GROUP BY P.PNAME,C.CNAME
            ORDER BY RR DESC
            ) WHERE ROWNUM <=3;


--5) 교수별로 현재 수강중인 학생의 수를 검색하세요.
SELECT ROWNUM, PNO, PNAME, SNO, COUNT(*)
                FROM ( SELECT PNO, P.PNAME, SNO, COUNT(*)
                            FROM PROFESSOR P 
                            NATURAL JOIN SCORE SC
                            NATURAL JOIN STUDENT 
                            GROUP BY PNO, P.PNAME, SNO
                            );
  
  
  SELECT P.PNO,P.PNAME, COUNT(*)
  FROM SCORE SC
  JOIN STUDENT ST
  ON SC.SNO = ST.SNO
  JOIN COURSE C
  ON C.CNO = SC.CNO
  JOIN PROFESSOR P 
  ON P.PNO = C.PNO
  GROUP BY P.PNO, P.PNAME;