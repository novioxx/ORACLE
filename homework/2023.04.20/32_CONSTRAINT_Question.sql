--1) SCORE 테이블과 동일한 구조를 갖는 SCORE_CHK를 생성하고 RESULT 60이상 90이하만 입력 가능하도록 하세요.
CREATE TABLE SCORE_CHK (
        SNO	VARCHAR2(8 BYTE),
        CNO	VARCHAR2(8 BYTE),
        RESULT	NUMBER(3,0),
        CONSTRAINT CHK_SC_RESULT CHECK(RESULT BETWEEN 60 AND 90)
        );
--2) STUDENT 테이블과 동일한 구조를 갖는 STUDENT_COPY 테이블을 생성하면서 SNO은 PK로 SNAME은 NOT NULL로 SYEAR의 DEFAULT는 1로 
--   설정하세요.
CREATE TABLE STUDENT_COPY(
    SNO	VARCHAR2(8) PRIMARY KEY,
    SNAME VARCHAR2(20) NOT NULL,
    SEX	VARCHAR2(3),
    SYEAR NUMBER DEFAULT 1,
    MAJOR VARCHAR2(20),
    AVR	NUMBER(4,2)
    );

--3) COURSE 테이블과 동일한 구조를 갖는 COURSE_CONTSRAINT 테이블을 생성하면서 CNO, CNAME을 PK로 PNO은 PROFESSOR_PK의 PNO을 참조하여
--   FK로 설정하고 ST_NUM은 DEFAULT 2로 설정하세요.
CREATE TABLE COURSE_CONTSRAINT(
    CNO VARCHAR2(8),
    CNAME VARCHAR2(20),
    ST_NUM NUMBER DEFAULT 2,
    PNO VARCHAR2(8),
    CONSTRAINT PK_COURSE_PK PRIMARY KEY(CNO, CNAME),
    CONSTRAINT FK_COURSE_PROF FOREIGN KEY(PNO) REFERENCES PROFESSOR_PK(PNO)
);

--4) 다음 구조를 갖는 테이블을 생성하세요.
--   T_SNS                              T_SNS_DETAIL                        T_SNS_UPLOADED
--   SNS_NO(PK)    SNS_NM               SNS_NO(PK, FK)   SNS_BEN            SNS_NO(PK, FK)    SNS_UPL_NO(PK)
--     1            페북                   1               4000                   1                  1
--     2           인스타                  2               10000                  1                  2
--     3           트위터                  3               30000                  2                  1
--                                                                               2                  2=
CREATE TABLE T_SNS (
        SNS_NO NUMBER PRIMARY KEY,
        SNS_NM VARCHAR2(50)
        );

INSERT INTO T_SNS
VALUES (1, '페북');

INSERT INTO T_SNS
VALUES (2, '인스타');

INSERT INTO T_SNS
VALUES (3, '트위터');

 CREATE TABLE T_SNS_DETAIL (
        SNS_NO NUMBER PRIMARY KEY, 
        SNS_BEN NUMBER,
        CONSTRAINT PK_SNS_D_SNS_NO FOREIGN KEY(SNS_NO) REFERENCES T_SNS(SNS_NO)
        );
INSERT INTO T_SNS_DETAIL
VALUES (1, 4000);

INSERT INTO T_SNS_DETAIL
VALUES (2, 10000);

INSERT INTO T_SNS_DETAIL
VALUES (3, 30000);

CREATE TABLE T_SNS_UPLOADED (
SNS_NO NUMBER,
SNS_UPL_NO NUMBER,
CONSTRAINT FK_SNS_UP_SNS_NO FOREIGN KEY(SNS_NO) REFERENCES T_SNS_DETAIL(SNS_NO),
CONSTRAINT PK_SNS_UP_PK PRIMARY KEY(SNS_NO,SNS_UPL_NO)
);
DROP TABLE T_SNS_UPLOADED;

INSERT INTO T_SNS_UPLOADED VALUES (1, 1);
INSERT INTO T_SNS_UPLOADED VALUES (1, 2);
INSERT INTO T_SNS_UPLOADED VALUES (2, 1);
INSERT INTO T_SNS_UPLOADED VALUES (2, 2);
               