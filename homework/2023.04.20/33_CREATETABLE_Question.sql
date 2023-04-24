--1) 다음 구조를 갖는 테이블을 생성하세요.
--PRODUCT 테이블 - PNO NUMBER PK              : 제품번호
--                PNMAE VARCHAR2(50)          : 제품이름
--                PRI NUMBER                  : 제품단가
--PAYMENT 테이블 - MNO NUMBER PK              : 전표번호
--               PDATE DATE NOT NULL         : 판매일자
--                CNAME VARCHAR2(50) NOT NULL : 고객명
--                TOTAL NUMBER TOTAL > 0      : 총액
--PAYMENT_DETAIL - MNO NUMBER PK FK           : 전표번호
--                PNO NUMBER PK FK            : 제품번호
--                AMOUNT NUMBER NOT NULL      : 수량
--                PRICE NUMBER NOT NULL       : 단가
--                TOTAL_PRICE NUMBER NOT NULL TOTAL_PRICE > 0 : 금액


CREATE TABLE PRODUCT (
  PNO NUMBER PRIMARY KEY,
  PNMAE VARCHAR2(50),
  PRI NUMBER
);
DROP TABLE PRODUCT;

CREATE TABLE PAYMENT (
  MNO NUMBER PRIMARY KEY,
  PDATE DATE NOT NULL,
  CNAME VARCHAR2(50) NOT NULL,
  TOTAL NUMBER CHECK(TOTAL > 0),
  CONSTRAINT FK_PAYMENT_PNO FOREIGN KEY(MNO) REFERENCES PRODUCT(PNO)
);
DROP TABLE PAYMENT;

CREATE TABLE PAYMENT_DETAIL (
  MNO NUMBER,
  PNO NUMBER,
  AMOUNT NUMBER NOT NULL,
  PRICE NUMBER NOT NULL,
  TOTAL_PRICE NUMBER CHECK(TOTAL_PRICE > 0),
  CONSTRAINT FK_PRODUCT_PNO FOREIGN KEY(PNO) REFERENCES PRODUCT(PNO),
  CONSTRAINT FK_PAYMENT_MNO FOREIGN KEY(MNO) REFERENCES PRODUCT(MNO)
);



DROP TABLE PAYMENT_DETAIL;



CREATE TABLE PRODUCT (
  PNO NUMBER ,
  PNMAE VARCHAR2(50),
  PRI NUMBER,
 CONSTRAINT PK_PRO_PNO PRIMARY KEY(PNO)
);

CREATE TABLE PAYMENT (
  MNO NUMBER,
  PDATE DATE NOT NULL,
  CNAME VARCHAR2(50) NOT NULL,
  TOTAL NUMBER,
  CONSTRAINT PK_PAY_MNO PRIMARY KEY(MNO),
  CONSTRAINT CHK_PAY_CHK CHECK(TATAL >0)
);

CREATE TABLE PAYMENT_DETAIL (
  MNO NUMBER,
  PNO NUMBER,
  AMOUNT NUMBER NOT NULL,
  PRICE NUMBER NOT NULL,
  TOTAL_PRICE NUMBER CHECK(TOTAL_PRICE > 0),
  CONSTRAINT PK_PAY_DEP_PNO PRIMARY KEY(MNO,PNO),
  CONSTRAINT FK_PAY_DEP_MNO FOREIGN KEY(MNO) REFERENCES PAYMENT(MNO),
  CONSTRAINT FK_PAY_DEP_MNO FOREIGN KEY(PNO) REFERENCES PRODUCT(PNO),
  CONSTRAINT CHK_TOTO_CHK CHECK(TOTAL_PRICE > 0)
);
















