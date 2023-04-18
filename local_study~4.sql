--1. 단일 함수
--1-1. 문자함수
-- LOWER, UPPER, INITCAP
SELECT DNO
    , LOWER(DNAME)
    , UPPER(DNAME)
    ,  INITCAP(DNAME)
    FROM DEPT;
    
SELECT * FROM DEPT;

--부서명이 erp인 정보를 조회
--부서명의 대,소문자를 모를 때
SELECT *
    FROM DEPT
    WHERE LOWER(DNAME) = 'erp';
    
--1-2. 문자 연산 함수
--CONCAT
SELECT CONCAT(DNO, ' : ' || DNAME || ' : ' || LOC)
    FROM DEPT;

SELECT DNO || ' :  ' || DNAME || ' : ' || LOC
FROM DEPT;

--SUBSTR
--오라클은 인덱스가 1부터 시작한다.
--(ORDER, N, CNT) 은 N번째 글자부터 CNT개를 가져온다
SELECT *
     FROM PROFESSOR
    WHERE SUBSTR(ORDERS, 1, 1) = '정';

SELECT ENAME
    ,  SUBSTR(ENAME, 2) --두번째 글자부터 모두
    ,  SUBSTR(ENAME, -2) --뒤에서 두번째 글자부터 모두
    ,  SUBSTR(ENAME,1, 2)--첫번째 글자부터 두 글자
    ,  SUBSTR(ENAME, -2, 2)--뒤에서 2번째 글자부터 두글자
    FROM EMP;

--LENGTH,LENGTHB
SELECT DNAME
    ,  LENGTH(DNAME)
    ,  LENGTHB(DNAME)
    FROM DEPT;
--현재 오라클이 사용중인 문자셋 AL32UTF8 => 한글 3BYTE
SELECT *
    FROM NLS_DATEBASE_PARAMETERS
    WHERE PARAMETER = 'NLS_CHARACTERSET'
    OR PARAMETER = 'NLS_NCHAR_CHARACTERSET';
    
--INSTR
--DUAL 테이블: 오라클에서 제공해주는 가상의 기본 테이블
--          간단하게 날짜나 연산 또는 결과값을 보기 위해 사용
--          원래 DUAL 테이블 소유자는 SYS로 되어있는데 모든 USER에서 접속이 가능.
SELECT INSTR('DATABASE', 'A') -- 1번째 'A'위치
    ,  INSTR('DATABASE', 'A', 3)--3번째 글자인 T 다음의 첫 번째 'A'위치
    ,  INSTR('DATABASE', 'A', 1, 3)--1번째 글자인 D 다음의 3번째 'A'위치
    ,  SYSDATE
    ,  1 + 2
    FROM DUAL;
    
--TRIM
SELECT TRIM('조' FROM '조병조')
    ,  TRIM(leading '조' FROM '조병조')
    ,  TRIM(trailing '조' FROM '조병조')
    ,  TRIM('조 병 조')
    FROM DUAL;
--LPAD, RPAD : CHARSET 한글을 3BYTE로 잡아도 컴퓨터에서는 2BYTE로 사용하기 때문에
-- 한글연산 자체는 2BYTE로 진행된다.
SELECT LPAD(ENAME, 10, '*') --사원명 앞에 *을 붙여서 총 길이를 10으로 만듬
      , RPAD(ENAME, 10, '*') --사원명 뒤에 *을 붙여서 총 길이를 10으로 만듬
       FROM EMP;
       
--직원이름을 출력하는데 마지막 글자만 제거해서 출력
SELECT SUBSTR(ENAME, 1, LENGTH(ENAME)-1)
    FROM EMP;

--1-3. 문자열 치환 함수
--TRANSLATE, REPLACE
SELECT TRANSLATE('World of Warcraft', 'Wo', '--') --문자 단위로 동작하기 때문에 모든 W,O치환
        , REPLACE('World of Warcraft', 'Wo', '--')--문자열 단위로 동작하기 때문에 WO 치환
        FROM DUAL;
        
--1-4. 숫자 함수
--ROUND,
SELECT ROUND(123.45678, 3)--지정한 자리수까지 반올림
    FROM DUAL;
--TRUNC
SELECT TRUNC(123.45678, 3)-- 지정한 자리수 뒤의 숫자 버림
    FROM DUAL;  
--MOD
SELECT MOD(10, 4)--나머지 값
    FROM DUAL;
--POWER
SELECT POWER(10,3) --10의 3승 값 10 X 10 X10
    FROM DUAL;
--CEIL, FLOOR(제일 가까운 정수 값)
SELECT CEIL(2.59) --제일 가까운 큰 정수
    ,  FLOOR(2.59)--제일 가까운 작은 정수
    FROM DUAL;
--ABS(절대값)
SELECT ABS(10)
    ,  ABS(-10)
    FROM DUAL;
--SQRT(제곱근 값)
SELECT SQRT(9) --3
    ,  SQRT(25) -- 5
    ,  SQRT(100) -- 10
    FROM DUAL;
-- SIGN(부호판단)
SELECT SIGN(-123) --음수면 -1
    ,  SIGN(52) --양수면 1
    ,  SIGN(0) --0이면 0
    FROM DUAL;

--1.4 날짜 연산
SELECT SYSDATE
    ,  SYSDATE + 100 --100일이후의 날짜
    ,  SYSDATE - 100 --100일이전의 날짜
    ,  SYSDATE + 3 /24 --3시간후의 날짜
    ,  SYSDATE - 5/ 24 --5시간 이전의 날짜
    ,  SYSDATE - TO_DATE('20220413', 'YYYY/MM/DD') --두 날짜간 차이 일수(시간,분,초때문에 정확히 나오지 않음)
    FROM DUAL;
    
--1-5. 날짜 함수
--ROUND
SELECT ROUND(SYSDATE, 'mm')
    FROM DUAL;
--TRUNC
SELECT TRUNC(SYSDATE)
    FROM DUAL;

SELECT TRUNC(SYSDATE, 'YYYY')
    FROM DUAL;
    
--MONTHS BETWEEN
SELECT MONTHS BETWEEN(SYSDATE, TO_DATE('20230213', 'yyyyMMdd'))
    FROM DUAL;
    
--ADD MONTHS
SELECT ADD_MONTHS(SYSDATE, 3)
FROM DUAL;

--NECT_DAY
SELECT NEXT_DAY(SYSDATE, '수요일')
    FROM DUAL;
    
--LAST_DAY
SELECT LAST_DAY(TO_DATE('20210618', 'yyyyMMdd'))
    FROM DUAL;
    
--사원들의 입사일과 입사 100일 후의 날짜와 10년 날짜 조회
SELECT ENAME
    ,  HDATE 
    ,  HDATE + 100 --100일이후의 날짜
    ,  ADD_MONTHS(HDATE, 120)
    FROM DUAL
    ,    EMP;
    
UPDATE STUDENT
    SET SNAME = SNAME || '  ';

UPDATE STUDENT
    SET SNAME = REPLACE(SNAME,' ','');

UPDATE STUDENT
    SET SNAME = SNAME ||' ';
    
COMMIT;

--1-6. 변환 함수
--숫자를 문자로 변환 하는 TO_CHAR
SELECT TO_CHAR(100000000, '999,999,999') --9자리까지 숫자로 ㅍ ㅛ기하되 3자리마다 ( , )를 표출하는 형식
    FROM DUAL;
 
  
SELECT TO_CHAR(1000000, '099,999,999') --9자리까지 숫자를 표기하되 3자리마다, ( , )를 표출하고 앞자리에 0을 붙여서 출력   
    FROM DUAL;

SELECT TO_CHAR(1000000, '099,999,999,999,999') --9자리까지 숫자를 표기하되 3자리마다,( , )를 표출하고 앞자리에 0을 붙여서 출력   
    FROM DUAL;
    
-- 문자를 숫자로 변환 하는 TO_NUMBER
--형식지정자의 자리수를 잘 지정해서 사용해줘야 함. TO_NUMBER(문자열, 형식지정자)
SELECT TO_NUMBER('-123.456', '999.999')-- 출력형식이 지정한 문자보다 짧을 경우 에러발생. 지정한 문자열보다 길게 
    FROM DUAL;
    
SELECT TO_NUMBER('123', '999.99')
    FROM DUAL;
    
SELECT TO_NUMBER('1234') --출력형식 지정자 없이도 사용가능
    FROM DUAL;
    
--날짜를 문자로 변환하는 TO_CHAR
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD'), --대.소문자 상관없이 사용가능
       TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS'),
       TO_CHAR(SYSDATE, 'YYYY/MM/DD AM HH:MI:SS'),
       TO_CHAR(SYSDATE, 'YYYY/MM/DD DAY'),
       TO_CHAR(SYSDATE, '"오늘은 "YYYY"년 "MM"월 "DD"일 " DAY"요일입니다."'), --형식지정자 안에서 문자열을 추가할 때 ""사용
       TO_CHAR(SYSDATE, 'YYYY"년 " MONTH DD"일"')
    FROM DUAL;
    
--문자를 날짜로 변환하는 TO_DATE
--날짜 출력 형식인 NLS_DATE_FORMAT 기준으로 출력
SELECT TO_DATE('20211201135123', 'YYYY/MM/DD HH24:MI:SS')
    ,  TO_DATE('202304141059', 'YYYYMMDD HH24-MI')
    ,  TO_DATE('20230411', 'YYYY-MM-DD')
    FROM DUAL;
    
--TO_DATE 함수로 입사일이 19920201보다 빠른 사원 목록 조회
SELECT *
    FROM EMP
    WHERE HDATE < TO_DATE('19920201', 'YYYYMMDD');


--송강 교수의 임용일자를 XXXX년 XX월 XX일 XX요일입니다. TO_CHAR
SELECT PNAME,
       PNO,
       TO_CHAR(HIREDATE, 'YYYY"년 "MM"월 " DD"일 "DAY"입니다."')
    FROM PROFESSOR
    WHERE PNAME = '송강';
    
--1-7. NULL값을 처리해주는 NVL
SELECT ENO,
       ENAME,
       NVL(COMM, -1)AS COMM
       FROM EMP;

--PROFRSSOR와 OUTER 조인해서 PNAME이 NULL인 값은 '교수 배정안됨'
SELECT C.CNO,
       P.PNO,
       P.PNAME,
       C.CNAME,
       NVL(C.PNO, 0),
       NVL(P.PNAME, '교수 배정안됨')
       FROM COURSE C
       LEFT JOIN PROFESSOR P 
       ON C.PNO = P.PNO;
    
--1-8. 조건을 처리해주는 DECODE
SELECT ENO,
       ENAME,
       JOB,
       DECODE(JOB, --조건1 'JOB' 
              '개발', SAL *1.5, --50프로 증가, 조건1('개발')이 TRUE일때 실현될 내용(SAL * 1.5)
              '경영', SAL *1.3,
              '지원', SAL *1.1,
              '분석', SAL,  --동결
                     SAL * 0.95 )  --5프로 삭감 조건1()이 공백이여서 FALSE일때 실현될 내용(SAL*0.95) 
                     AS CHANGE_SAL  --별칭을 안 만들어 주면 NAME 길이가 조건1 + 실현될 내용 다 합쳐서 나와서 길어짐
            FROM EMP;
            
--1-9. 조건을 처리해주는 CASE~WHEN
SELECT ENO,
       ENAME,
       JOB,
       SAL,
       CASE JOB
            WHEN '개발' THEN SAL * 1.5
            WHEN '경영' THEN SAL * 1.3
            WHEN '지원' THEN SAL * 1.1
            WHEN '분석' THEN SAL
            ELSE SAL * 0.95 --조건1('개발') ~ 마지막 조건N인('분석')이 아닐 경우
        END AS CHANGE_SAL -- END AS 별칭으로 CASE문의 종결
        FROM EMP;
        
--COMM이 NULL인 사람은 '해당사항 없음', COMM이 0인 사람은 '보너스 없음', 나머지 사람들은 '보너스 : " // COMM
--COM_TXT 조회내용 - ENO, ENAME, COMM
SELECT ENO, 
       ENAME, 
       COMM,
       CASE 
          WHEN COMM IS NULL THEN '해당사항 없음'
          WHEN COMM = 0 THEN '보너스 없음'
          ELSE '보너스 : ' || TO_CHAR(COMM)
          END AS COM_TXT
          FROM EMP;
          
SELECT ENO, 
       ENAME, 
       COMM,
       CASE NVL(COMM, -1) --NUMBER를 문자형식으로 변환 NULL값
          WHEN -1 THEN '해당사항 없음'
          WHEN 0 THEN '보너스 없음'
          ELSE '보너스 : ' || COMM
          END AS COM_TXT
          FROM EMP;
-- DECODE 는 NULL '' 없이 바로 넣을수 가 있음~!!
SELECT ENO,
       ENAME,
       COMM,
       DECODE(COMM,
              NULL, '해당사항 없음',
              '0',  '보너스 없음',
              '보너스' || COMM)
                     AS COMM_TXT  --별칭을 안 만들어 주면 NAME 길이가 조건1 + 실현될 내용 다 합쳐서 나와서 길어짐
            FROM EMP;
            
SELECT ENO,
       ENAME,
       COMM,
       DECODE(NVL(COMM,-1),
              -1, '해당사항 없음',
              '0',  '보너스 없음',
              '보너스' ||  COMM)
            AS COMM_TXT  --별칭을 안 만들어 주면 NAME 길이가 조건1 + 실현될 내용 다 합쳐서 나와서 길어짐
            FROM EMP;
  
 
