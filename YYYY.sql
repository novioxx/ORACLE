CREATE TABLE NETFLIX (

    VIDEO_NAME  VARCHAR2(50),--영어 한글자가 1BYTE
    CATEGORY    VARCHAR2(30),
    VIEW_CNT    VARCHAR2(7),
    REG_DATE    DATE

SELECT * FROM NETFLIX   --NETFLIX 라는 테이블 생성
)

1. ALTER 
    - 기존에 생성 해놓은 컬럼을 변경할 때 사용

ALTER TABLE NETFLIX ADD(CAST_MEMBER VARCHAR2(20));

ALTER TABLE NETFLIX NODIF(CAST_MEMBER VARCHAR2(50));

ALTER TABLE NETFLIX MODIFY(CAST_MEMBER NUMBER(2)); --NUMBER로 변경

ALTER TABLE NETFLIX DROP (CAST_MEMBER);  --DROP을 통해 삭제


2. DROP --기존 테이블을 삭제할 때 사용
   CREATE TABLE CODELION(

                COL1  VARCHAR2(3),
                COL2  VARCHAR2(3)
   );

   SELECT * FROM CODELION;


INSERT INTO CODELION VALUES ( 'AAA','BBB')
INSERT INTO CODELION VALUES ( 'CCC','DDD')

COMMIT;

INSERT 문은 완벽하게 완료하기 위해서 COMMIT을 해야 한다.

DROP TABLE CODELION; --삭제

TRUNCATE TABLE CODELION;  --테이블은 그대로 있지만 데이터가 다 삭제된다
--TRUNCATE는 데이터를 초기화 할 때 사용한다.

3. INSERT 데이터를 테이블에 입력

SELECT * FROM NETFLIX;

INSERT INTO NETFLIX VALUES ('나의 아저씨', '드라마',50,SYSDATE);

COMMIT;

INSERT INTO NETFLIX (VIDEO_NAME, VIEW_CNT) VALUES('시그널',42);

INSERT INTO NETFLIX VALUES ('응답하라1988','드라마',35,SYSDATE -30);

INSERT INTO NETFLIX VALUES ('이태원클라쓰','드라마',30,SYSDATE-40);
INSERT INTO NETFLIX VALUES ('미스터 션샤인','드라마',22,SYSDATE-300);

4. UPDATE 데이터를 변경

SELECT * FROM NETFLIX;

UPDATE NETFLIX SET VIEW_CNT = 70
WHERE VIDEO_NAME = '나의 아저씨';
COMMIT;

--변경될 내용을 완벽하게 반영하기 위해서는 COMMIT을 해줘야한다.

UPDATE NETFLIX 
SET CATEGORY = '드라마',REG_DATE = TO_DATE('20210101', 'YYYYMMDD')
WHERE VIDEO_NAME = '시그널';

UPDATE 문을 사용할 때는 WHERE을 생략하면 모든 데이터가 변경되기 때문에
주의해야 한다.

5.DELETE 데이터를 삭제한다.
- 제가 원하는 데이터만 삭제할 수 있다. 
TRUNCATE는 삭제하면 복구가 불가능 하지만 DELETE는 ROLLBACK으로 복구할 수 있다.

DELETE FROM NETFLIX WHERE CATEGORY = '드라마', AND VIEW_CNT < 35;

DELETE FROM NETFLIX WHERE VIDEO_NAME IN('시그널', '나의 아저씨');\

DELETE FROM NETFLIX ; -- 모든 데이터 삭제

6. SELECT 데이터를 조회하는 쿼리

INSERT , UPDATE, DELETE -> SELECT(DATE) -> 화면에 반영

SELECT * FROM NETFLIX ;

SELECT VIDEO_NAME,CATEGORY,VIEW_CNT,REG_DATE FROM NETFLIX;

SELECT * FROM NETFLIX WHERE VIDEO_NAME = '나의 아저씨';

SELECT * FROM NETFLIX WHERE VIDEO_NAME <> '나의 아저씨'

SELECT DISTINCT CATEGORY FROM NETFLIX --DISTINCT를 사용해서 중복제거 조회

