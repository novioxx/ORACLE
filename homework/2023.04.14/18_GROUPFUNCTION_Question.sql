--1) 화학과를 제외하고 학과별로 학생들의 평점 평균을 검색하세요
SELECT MAJOR,
       AVG(AVR)
       FROM STUDENT
       WHERE MAJOR != '화학'
       GROUP BY MAJOR;
       
SELECT MAJOR,
       ROUND(AVG(AVR),2)
       FROM STUDENT
       WHERE MAJOR != '화학'
       GROUP BY MAJOR;       

--2) 화학과를 제외한 각 학과별 평균 평점 중에 평점이 2.0 이상인 정보를 검색하세요
SELECT MAJOR,
       AVG(AVR)
       FROM STUDENT
       WHERE AVR >= 2.0
       AND MAJOR != '화학'
       GROUP BY MAJOR;
       
SELECT MAJOR,
       ROUND(AVG(AVR),2)
       FROM STUDENT
       GROUP BY MAJOR
       HAVING MAJOR != '화학'
       AND ROUND(AVG(AVR),2) >= 2.0;
    
--3) 기말고사 평균이 60점 이상인 학생의 정보를 검색하세요
SELECT ST.SNO,
       ST.SNAME,
       AVG(SC.RESULT)
       FROM STUDENT ST
       JOIN SCORE SC
       ON ST.SNO = SC.SNO
       GROUP BY ST.SNAME, ST.SNO
       HAVING AVG(SC.RESULT) >= 60;
              
--4) 강의 학점이 3학점 이상인 교수의 정보를 검색하세요
SELECT P.PNO,
       P.PNAME
       FROM PROFESSOR P
       JOIN COURSE CS
       ON CS.PNO = P.PNO
       WHERE CS.ST_NUM >= 3
       GROUP BY P.PNO, P.PNAME;
       
SELECT P.PNO,
       P.PNAME,
       SUM(CS.ST_NUM)
       FROM PROFESSOR P
       JOIN COURSE CS
       ON CS.PNO = P.PNO
       GROUP BY P.PNO, P.PNAME
       HAVING SUM(CS.ST_NUM)>= 3;
       
--5) 기말고사 평균 성적이 핵 화학과목보다 우수한 과목의 과목명과 담당 교수명을 검색하세요(과목명,교수명)
SELECT C.CNAME, P.PNAME, AVG(S.RESULT)
    FROM COURSE C
    JOIN PROFESSOR P ON C.PNO = P.PNO
    JOIN SCORE S ON S.CNO = C.CNO
    GROUP BY C.CNAME, P.PNAME
    HAVING AVG(S.RESULT) > (
                               SELECT AVG(S2.RESULT)
                               FROM SCORE S2
                               JOIN COURSE C2 ON S2.CNO = C2.CNO
                               WHERE C2.CNAME = '핵화학'
                            );
                                    
--6) 근무 중인 직원이 4명 이상인 부서를 검색하세요(부서번호,부서명,인원수)
SELECT D.DNO,
       D.DNAME,
       COUNT(*) AS "인원수" --''를 사용해서 별칭을 하면 오류가 났음, ""로 바꾸니 정상 실행함
       FROM DEPT D
       JOIN EMP E
       ON D.DNO = E.DNO
       GROUP BY D.DNO, D.DNAME
       HAVING COUNT(*) >= 4;


--7) 업무별 평균 연봉이 3000 이상인 업무를 검색하세요
SELECT AVG(SAL),
       JOB
    FROM EMP
    GROUP BY JOB
    HAVING AVG(SAL) > 3000;
    
SELECT JOB, ROUND(AVG(SAL),2)
    FROM EMP
    GROUP BY JOB
    HAVING  ROUND(AVG(SAL),2) > 3000;

--8) 각 학과의 학년별 인원중 인원이 5명 이상인 학년을 검색하세요
SELECT MAJOR,
       SYEAR,
       COUNT(*)
       FROM STUDENT 
       GROUP BY MAJOR, SYEAR
       HAVING COUNT(*) >= 5;