--뷰 이름은 자유
--1) 학생의 평점 4.5 만점으로 환산된 정보를 검색할 수 있는 뷰를 생성하세요.
CREATE OR REPLACE VIEW V_AVG_SNAME(
                 SNO,SNAME,MAJOR,AVGAVR
         )AS (
        SELECT SNO, ST.SNAME, ST.MAJOR, ST.AVR*4.5/4.0 AS RR
        FROM STUDENT ST
        );
SELECT * FROM V_AVG_SNAME;
--2) 각 과목별 기말고사 평균 점수를 검색할 수 있는 뷰를 생성하세요.
CREATE OR REPLACE VIEW V_AVG_RESULT(
        CNO,CNAME,AVGRESULT)
        AS( SELECT C.CNO,C.CNAME, AVG(S.RESULT) AS REE
        FROM COURSE C
        JOIN SCORE S ON C.CNO = S.CNO
        );

--3) 각 사원과 관리자의 이름을 검색할 수 있는 뷰를 생성하세요.
CREATE OR REPLACE VIEW V_ENAME(ENO,ENAME,MGR)AS(
            SELECT P.ENO,P.ENAME,E.MGR
                FROM EMP P
                JOIN EMP E ON P.ENO = E.MGR);
                
   SELECT * FROM  V_ENAME;            
--4) 각 과목별 기말고사 평가 등급(A~F)까지와 해당 학생 정보를 검색할 수 있는 뷰를 생성하세요.
CREATE OR REPLACE VIEW V_C_RESULT_GRADE(
    SNO,MAJOR,RESULT,GRADE
    )AS ( SELECT ST.SNO,ST.MAJOR,SC.RESULT, G.GRADE
            FROM STUDENT ST
            JOIN SCORE SC
            ON ST.SNO = SC.SNO
            JOIN SCGRADE G ON SC.RESULT BETWEEN LOSCORE AND HISCORE );

SELECT * FROM V_C_RESULT_GRADE;
--5) 물리학과 교수의 과목을 수강하는 학생의 명단을 검색할 뷰를 생성하세요.(SNO,SNAME,CNO,PNO,PNAME,SECTION)
CREATE OR REPLACE VIEW V_SECTION_SNAME(SNO,SNAME,CNO,PNO,PNAME,SECTION)
AS ( SELECT ST.SNO,ST.SNAME,SC.CNO,P.PNO,P.PNAME,P.SECTION
            FROM STUDENT ST
            JOIN SCORE SC ON ST.SNO = SC.SNO
            JOIN COURSE C ON C.CNO = SC.CNO
            JOIN PROFESSOR P ON C.PNO = P.PNO 
             WHERE SECTION = '물리'
            ) ;
SELECT * FROM V_SECTION_SNAME;            
        