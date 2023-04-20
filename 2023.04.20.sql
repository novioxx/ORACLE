--1-2. FOREIGN KEY(테이블간의 관계를 맺어줌)
--DEOT PK1의 DNO을 참조하여 EMP_PK1의 DNO을 FK로 생성
DROP TABLE EMP_PK1;

CREATE TABLE EMP_PK_FK1(
        ENO NUMBER PRIMARY KEY,
        ENAME VARCHAR2(20),
        JOB VARCHAR2(10),
        MGR NUMBER,
        HDATE DATE,
        SAL NUMBER(10, 3),
        COMM NUMBER(5, 2),
        DNO NUMBER CONSTRAINT FK_EMP_DNO
                REFERENCES DEPT_PK1(DNO)
                );
        
-- FK에 데이터 추가
--FK는 NULL(X) 중복데이터 허용, INDEX도 아님
INSERT INTO EMP_PK_FK1
VALUES(1,'홍길동', '개발', 0, SYSDATE, 3000, 300,1);

INSERT INTO EMP_PK_FK1
VALUES(2,'장길산', '개발', 0, SYSDATE, 3200, 320,2);

INSERT INTO EMP_PK_FK1
VALUES(3,'임꺽정', '개발', 0, SYSDATE, 3000, 300,1);

--부모테이블에 없는 값은 저장 할 수 없다.
INSERT INTO EMP_PK_FK1
VALUES(4,'황진이', '관리', 0, SYSDATE, 3000, 300,3);

SELECT A.*, B.DANEM, B.LOC, B.DIRECTOR
    FROM EMP_PK_FK1 A
    JOIN DEPT_PK1 B
    ON A.DNO = B.DNO;
    
--CASDAE 옵션이 없을 때 부모테이블의 데이터의 수정이나 삭제나 불가능(자식테이블에서 부모테이블에 데이터를 점유)
--점유된 데이터를 자식테이블에서 제거하면 
--부모테이블의 데이터는 자식테이블에서 사용중이기 때문에 함부로 삭제/수정을 할 수 없도록 막아놓음
--자식테이블의 데이터를 먼저 삭제하고 다른 데이터로 변경을 진행하고 부모테이블의 데이터를 삭제/수정을 해야한다.
DELETE FROM DEPT_PK1
    WHERE DNO = 1;
    
UPDATE DEPT_PK1
    SET
            DNO = 3
        WHERE DNO = 2
        AND JOB = '개발';
        
UPDATE EMP_PK_FK1
    SET
        DNO = 2
        WHERE DNO =1;
        

UPDATE DEPT_PK
    SET
        LOC ='천안',
        DNAME = '개발3'
        WHERE DNO = 3;
        
INSERT INTO DEPT_PK1
VALUES(1, '개발1', '서울', 1);

--DEPT_PK1(부모) DNO 2,3은 EMP_PK_FK1(자식)에서 점유, DNO 1은 점유되어 있지 않기 때문에
--DNO 2 ,3은 수정/삭제 불가능, DNO 1은 수정/삭제가 가능
--DNO 3의 데이터 점유를 해지(DNO로보내고) DNO3 데이터 부모테이블(DEPT_PK1)에서 삭제
DELETE FROM DEPT_PK1
    WHERE DNO = 1;
    
UPDATE DEPT_PK
    SET
            DNO = 3
            WHERE DNO = 1;





CREATE TABLE EMP_PK_FK1(
        ENO	NUMBER PRIMARY KEY,
        ENAME VARCHAR2(20 BYTE),
        JOB	VARCHAR2(10 BYTE),
        MGR	NUMBER,
        HDATE DATE,
        SAL	NUMBER(10,3),
        COMM NUMBER(5,2),
        DNO	NUMBER CONSTRAINT FK_EMP_DNO
                REFERENCES DEPT_PK1(DNO)
        );


SELECT * FROM EMP_PK1;

--CASCADE 옵션 추가된 FK 생성
CREATE TABLE EMP_PK_FK100(
        ENO	NUMBER PRIMARY KEY,
        ENAME VARCHAR2(20 BYTE),
        JOB	VARCHAR2(10 BYTE),
        MGR	NUMBER,
        HDATE DATE,
        SAL	NUMBER(10,3),
        COMM NUMBER(5,2),
        DNO	NUMBER,
        CONSTRAINT FK_EMP_DNO FOREIGN KEY(DNO)
            REFERENCES DEPT_PK1(DNO)
        );

DROP TABLE EMP_PK_FK2;

--제약조건 목록 조회
SELECT * FROM ALL CONSTRAINTS

--데이터 저장
INSERT INTO DEPT_PK1
VALUE(1,'개발1', '서울', 0)
INSERT INTO DEPT_PK1
VALUE(2,'개발2', '부산', 0);

INSERT INTO EMP_PK_FK1
VALUES(1,'홍길동', '개발', 0, SYSDATE, 3000, 300,1);

INSERT INTO EMP_PK_FK1
VALUES(2,'장길산', '개발', 0, SYSDATE, 3200, 320,2);
        
        
--DLETET CASCADE 옵션일 때 부모데이터 삭제
--오라클에서는 UPDATE CASCADE는 지원안됨
--DELETE CASCADE 옵션은 부모테이블 데이터를 삭제할 수 있게해주는데
--부모테이블에서 삭제되는 데이터를 참조하고 있는 자식테이블의 데이터도 같이 삭제된다.
--UPDATE CASCADE 옵션은 부모테이블의 데이터를 수정할 수 있다.
--부모테이블에서 수정되는 데이터를 참조하고 있는 자식테이블의 데이터도 같이 수정된다. <- CASCADE 옵션
DELETE FROM DEPT_PK1;
      WHERE  DNO = 1; 

ALTER TABLE EMP_PK_FK1
DROP CONSTRAINT FK_EMP_DNO;

--FK 관계의 종류
--1-1 부모테이블 데이터 1개당 자식테이블 1개가 생성되는 구조
--부모테이블의 PK,UK 컬럼이 자식테이블의 FK면서 PK,UK
CREATE TABLE T_USER(
    USER_ID VARCHAR2(20) PRIMARY KEY,
    PASSWORD VARCHAR(50),
    JOIN_DATE DATE
    );
    
    INSERT INTO T_USER
    VALUES('GOGI', '1234', SYSDATE);
    
    CREATE TABLE T_USER_DETAIL(
         USER_ID VARCHAR2(20) PRIMARY KEY,
         USER_NAME VARCHAR2(20),
         USER_EMAIL VARCHAR2(100),
         USER_TEL NUMBER(11),
        CONSTRAINT FK_USER_ID FOREIGN KEY(USER_ID)
        REFERENCE T_USER(USER_ID)
         
    );
    
INSERT INTO T_USER_DETAIL
VALUES('GOGI', NULL, NULL, NULL);

--1 : N 관계 =  1 대 다 관계
--DEPT_PK1과 EMP_PK_FK100는 1:N관계
--DEPT_PK1의 PK인 DNO으로 EMP_PK_FK100에서는 여러개의 데이터(중복)를 생성할 수 있기 때문에 1:N관계
--T_BOARD와 T_BOARD_FILE을 1:N 관계로 만들어보기
DROP TABLE T_BOARD_FILE;
    
CREATE TABLE T_BOARD_FILE (
  BOARD_NO NUMBER,
  BOARD_FILE_NO NUMBER ,
  BOARD_FILE_NM VARCHAR2(200),
  BOARD_FILE_PATH VARCHAR2(2000),
  ORIGIN_FILE_NM VARCHAR2(200), 
  CONSTRAINT PK_BF_BOARD_FILE_NO PRIMARY KEY(BOARD_NO,BOARD_FILE_NO),
  CONSTRAINT FK_BOARF_BOARD_NO FOREIGN KEY(BOARD_NO) REFERENCES T_BOARD(BOARD_NO)
);

INSERT INTO T_BOARD
VALUES(1, NULL,NULL,NULL,NULL,NULL);

INSERT INTO T_BOARD_FILE
VALUES(1,5, NULL,NULL,NULL);

--1-3. UNIQUE KEY
--
CREATE TABLE EMP_UK(
        ENO NUMBER CONSTRAINT UK_EMP_ENO UNIQUE,
        ENAME VARCHAR2(20)
);
--데이터 저장  중복값 허용이 안됨
INSERT INTO EMP_UK
VALUES(1, '홍길동');
INSERT INTO EMP_UK
VALUES(2, '장길산');

--NULL값을 중복저장 가능하다
INSERT INTO EMP_UK
VALUES(NULL, '홍길동5');

SELECT * FROM EMP_UK;

--1-4. CHECK
--저장되는 데이터에 조건을 달아주는 CHECK
CREATE TABLE EMP_CHK1 (
        ENO NUMBER PRIMARY KEY,
        ENAME VARCHAR2(20),
        JOB VARCHAR2(10),
        MHR NUMBER,
        SAL NUMBER(11,3),
        COMM NUMBER(5,2),
        CONSTRAINT CHK_EMP_SAL1 CHECK(SAL >= 3000),
        CONSTRAINT CHK_EMP_COMM1 CHECK(COMM BETWEEN 100 AND 1000)
);

SELECT * FROM  EMP_CHK1;

--CHECK 조건에 맞지 않는 데이터 저장
INSERT INTO EMP_CHK
VALUES(1, NULL, NULL, 0, 3000, 500);
ROLLBACK;

--1-5. NOT NULL
CREATE TABLE EMP_NOT_NULL(
        ENO NUMBER PRIMARY KEY,
        ENAME VARCHAR2(20) NOT NULL,
        JOB VARCHAR2(10) NOT NULL,
        MGR NUMBER,
        HDATE DATE NOT NULL,
        DNO NUMBER NOT NULL
        );
 
--NOT NULL으로 지정된 컬럼에 NULL을 저장하면 에러가 발생.       
INSERT INTO EMP_NOT_NULL
VALUES(1, '홍길동',NULL, 0, SYSDATE, 0);


--1-6. DEFAULT
CREATE TABLE EMP_DEF(
        ENO NUMBER PRIMARY KEY,
        ENAME VARCHAR2(20) NOT NULL,
        JOB VARCHAR2(10) DEFAULT '개발' NOT NULL,
        MGR NUMBER,
        HDATE DATE DEFAULT SYSDATE NOT NULL,
        DNO NUMBER NOT NULL
        );

--DEFAULT로 지정된 컬럼 제외한 데이터 저장
INSERT INTO EMP_DEF(ENO,ENAME,MGR,DNO)
VALUES(1, '홍길동', 0, 1);

SELECT * FROM EMP_DEF;



--1-7. 모든 제약 조건 추가된 테이블 생성
CREATE TABLE FACTORY(
            FNO NUMBER,
            FNAME VARCHAR2(50) NOT NULL,
            LOC VARCHAR2(10) DEFAULT '서울', 
            CONSTRAINT PK_FAC_FNO PRIMARY KEY(FNO)
            );
                
CREATE TABLE GOODS(
        GNO NUMBER,
        GNAME VARCHAR2(50),
        PRI NUMBER DEFAULT 10000,
        FNO NUMBER NOT NULL,
        CONSTRAINT PK_GOODS_GNO PRIMARY KEY(GNO),
        CONSTRAINT FK_GOODS_FNO FOREIGN KEY(FNO)
                REFERENCES FACTORY(FNO)
        );
        
CREATE TABLE PROD(
        PNO NUMBER,
        GNO NUMBER NOT NULL,
        PRICE NUMBER DEFAULT 7000,
        PDATE DATE,
        CONSTRAINT PK_PROD_PNO PRIMARY KEY(PNO),
        CONSTRAINT FK_PROD_GNO FOREIGN KEY(GNO)
                     REFERENCES GOODS(GNO)
        );

--
SQL> DECLARE
  2     NUM NUMBER:=0;
  3  BEGIN
  4     LOOP
  5             DBMS_OUTPUT.PUT_LINE(NUM);
  6             NUM:=NUM+1;
  7             EXIT WHEN NUM < 61;
  8  END LOOP;
  9  END;
 10  /