--<단일 행 함수를 이용하세요>
--1) 교수들이 부임한 달에 근무한 일수는 몇 일인지 검색하세요
SELECT
  P.PNO,
  P.HIREDATE,
  P.PNAME,
  TRUNC(LAST_DAY(HIREDATE)) - TRUNC(HIREDATE)
    FROM PROFESSOR P;

--2) 교수들의 오늘까지 근무한 주가 몇 주인지 검색하세요
SELECT P.PNO,
       P.PNAME,
  TRUNC((SYSDATE - P.HIREDATE)/7)
FROM
  PROFESSOR P;
--3) 1991년에서 1995년 사이에 부임한 교수를 검색하세요
SELECT  PNAME,
        SECTION,
        HIREDATE  
    FROM PROFESSOR
    WHERE HIREDATE 
        BETWEEN TO_DATE('19940101 00:00:00', 'yyyyMMdd HH24:mi:ss')
            AND TO_DATE('19951231 23:59:59', 'yyyyMMdd HH24:mi:ss');
            
 -- WHERE TRUNC(HIREDATE, 'YYYY') BETWEEN TO_DATE('1991', 'YYYY') AND TO_DATE('1995', 'YYYY');           
--4) 학생들의 4.5 환산 평점을 검색하세요(단 소수 이하 둘째자리까지)
SELECT SNO, 
       SNAME, 
       ROUND(AVR * 4.5 /4.0, 2)
FROM STUDENT;

--5) 사원들의 오늘까지 근무 기간이 몇 년 몇 개월 며칠인지 검색하세요
SELECT 
  ENAME
  ,TRUNC(MONTHS_BETWEEN(SYSDATE, HDATE) / 12) 
  ,TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, HDATE), 12)) 
  ,TRUNC(MOD(SYSDATE - ADD_MONTHS(HDATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HDATE) / 12) * 12), 30))
FROM EMP;

--SELECT ENO,
--       ENAME,
--       TRUNC(MONTHS_BETWEEN(SYSDATE, HDATE) / 12) || '년'
--    || MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, HDATE)), 12) || '개월'
--    || TRUNC(SYSDATE - ADD_MONTHS(HDATE, MONTHS_BETWEEN(SYSDATE, HDATE)) || '일'
--    FROM EMP;