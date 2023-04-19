--1) CNO이 PK인 COURSE_PK 테이블을 생성하세요.(1번 방식으로)
CREATE TABLE COURSE_PK (
    CNO VARCHAR2(8) PRIMARY KEY,
    CNAME VARCHAR2(20),
    ST_NUM NUMBER,
    PNO VARCHAR2(8)
    );

--2) PNO이 PK인 PROFESSOR_PK 테이블을 생성하세요.(2번 방식으로)
CREATE TABLE PROFESSOR_PK(
    PNO VARCHAR2(8),
    PNAME VARCHAR2(20),
    SECTION VARCHAR2(20),
    HDATE DATE,
    ORDERS VARCHAR2(10),
   CONSTRAINT PK_PROFESSOR_PNO PRIMARY KEY(PNO)
   );

--3) PF_TEMP 테이블에 PNO을 PK로 추가하세요.
ALTER TABLE PF_TEMP
    ADD CONSTRAINT PF_TEMP_PNO PRIMARY KEY(PNO);

--4) COURSE_PROFESSOR 테이블에 CNO, PNO을 PK로 추가하세요.
ALTER TABLE COURSE_PROFESSOR
    ADD CONSTRAINT CR_PROFESSOR_CNO_PNO PRIMARY KEY(CNO,PNO);

--5) BOARD_NO(NUMBER)를 PK로 갖으면서 BOARD_TITLE(VARCHAR2(200)), BOARD_CONTENT(VARCHAR2(2000)), 
--   BOARD_WRITER(VARCHAR2(20)), BOARD_FRGT_DATE(DATE), BOARD_LMDF_DATE(DATE) 컬럼을 갖는 T_BOARD 테이블을 생성하세요.
CREATE TABLE T_BOARD(
    BOARD_NO NUMBER PRIMARY KEY,
    BOARD_TITLE VARCHAR2(200),
    BOARD_CONTENT VARCHAR2(2000),
    BOARD_WRITER VARCHAR2(20),
    BOARD_FRGT_DATE DATE,
    BOARD_LMDF_DATE DATE
   );

--6) BOARD_NO(NUMBER), BOARD_FILE_NO(NUMBER)를 PK로 갖으면서 BOARD_FILE_NM(VARCHAR2(200)), BOARD_FILE_PATH(VARCHAR2(2000)),
--   ORIGIN_FILE_NM(VARCHAR2(200)) 컬럼을 갖는 T_BOARD_FILE 테이블을 생성하세요.
CREATE TABLE T_BOARD_FILE (
        BOARD_NO NUMBER,
        BOARD_FILE_NO NUMBER ,
        BOARD_FILE_NM VARCHAR2(200),
        BOARD_FILE_PATH VARCHAR2(2000),
        ORIGIN_FILE_NM VARCHAR2(200), 
        CONSTRAINT T_BOARD_FILE PRIMARY KEY(BOARD_NO,BOARD_FILE_NO)
        );