--1) 과목번호, 과목이름, 교수번호, 교수이름을 담을 수 있는 변수들을 선언하고 
--   유기화확 과목의 과목번호, 과목이름, 교수번호, 교수이름을 출력하세요.
DECLARE
        CNO COURSE.CNO%TYPE;
        CNAME COURSE.CNAME%TYPE;
        PNO PROFESSOR.PNO%TYPE;
        PNAME PROFESSOR.PNAME%TYPE;
BEGIN
        SELECT C.CNO, C.CNAME, P.PNO, P.PNAME
        INTO CNO,CNAME,PNO,PNAME
        FROM COURSE C, PROFESSOR P
        WHERE C.PNO = P.PNO AND C.CNAME ='유기화학'; 
        
        DBMS_OUTPUT.PUT_LINE(CNO);
        DBMS_OUTPUT.PUT_LINE(CNAME);
        DBMS_OUTPUT.PUT_LINE(PNO);
        DBMS_OUTPUT.PUT_LINE(PNAME);
END;
/
    
--2) 위 데이터들을 레코드로 선언하고 출력하세요.
DECLARE
    TYPE PROFESSOR_REC IS RECORD(
    CNO VARCHAR2(8),
    CNAME VARCHAR2(20),
    ST_NUM NUMBER NOT NULL,
    PNO VARCHAR2(8)
    );
    
    PROFESSOR PROFESSOR_REC;
    
BEGIN    
    DBMS_OUTPUT.PUT_LINE(PROFESSOR_REC.CNO);
    DBMS_OUTPUT.PUT_LINE(PROFESSOR_REC.CNAME);
    DBMS_OUTPUT.PUT_LINE(PROFESSOR_REC.ST_NUM);
    DBMS_OUTPUT.PUT_LINE(PROFESSOR_REC.PNO);
    
    END;
    /

--3) 과목번호, 과목이름, 과목별 평균 기말고사 성적을 갖는 레코드의 배열을 만들고
--   기본 LOOP문을 이용해서 모든 과목의 과목번호, 과목이름, 과목별 평균 기말고사 성적을 출력하세요.


--4) 학생번호, 학생이름과 학생별 평균 기말고사 성적을 갖는 테이블 T_STAVGSC를 만들고
--   커서를 이용하여 학생번호, 학생이름, 학생별 평균 기말고사 성적을 조회하고 
--   조회된 데이터를 생성한 테이블인 T_STAVGSC에 저장하세요.