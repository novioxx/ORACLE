--1) ȭ�а� �л��� �˻��϶�
SELECT *
    FROM STUDENT
    WHERE MAJOR = 'ȭ��';
    
--2) ������ 2.0 �̸��� �л��� �˻��϶�
SELECT *
    FROM STUDENT
    WHERE AVR < 2.0;

--3) ���� �л��� ������ �˻��϶�
SELECT SNAME, AVR
    FROM STUDENT
    WHERE SNAME ='����';
--4) ������ ����� �˻��϶�
SELECT PNAME, ORDERS
    FROM PROFESSOR
    WHERE ORDERS = '������';

--5) ȭ�а� �Ҽ� ������ ����� �˻��϶�
SELECT SECTION, PNAME
    FROM PROFESSOR
    WHERE SECTION = 'ȭ��';


--6) �۰� ������ ������ �˻��϶�
SELECT * 
    FROM PROFESSOR
    WHERE PNAME = '�۰�';


--7) �г⺰�� ȭ�а� �л��� ������ �˻��϶�
SELECT SYEAR
    ,  MAJOR
    , SNAME
    , AVR
    FROM STUDENT
    WHERE MAJOR = 'ȭ��'
    ORDER BY SYEAR ASC;

--8) 2000�� ������ ������ ������ ������ �����ϼ����� �˻��϶�
SELECT *  
    FROM PROFESSOR
   -- WHERE substr(HIREDATE, 0, 4) < 2000 
   -- ���� ���ڿ��� �� ������ ����Ʈ Ÿ������ ��ȯ
   WHERE HIREDATE < TO_DATE('20000101 00:00:00', 'yyyyMMdd hh24:mi:ss)')
    ORDER BY HIREDATE ASC;

--9) ��� ������ ���� ������ ������ �˻��϶�
SELECT *
    FROM COURSE
    WHERE PNO IS NULL;