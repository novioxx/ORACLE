--1) �������� ������, �Ŀ��� �л��� �˻��϶�
SELECT *
    FROM STUDENT
    WHERE MAJOR = '����'
    OR MAJOR = '����'
    OR MAJOR = '�Ŀ�';


--2) ȭ�а��� �ƴ� �л��߿� 1�г� �л��� �˻��϶�
SELECT *
    FROM STUDENT
    WHERE SYEAR = 1
    AND MAJOR != 'ȭ��';
    
--3) �����а� 3�г� �л��� �˻��϶�
SELECT *
    FROM STUDENT
    WHERE SYEAR = 3
    AND MAJOR = '����';


--4) ������ 2.0���� 3.0������ �л��� �˻��϶�
SELECT *
    FROM STUDENT
    WHERE AVR >= 2.0
    AND AVR <= 3.0;
--������ ���� ã�� WHERE AVR BETWEEN 2.0 AND 3.0

--5) ������ �������� ���� �����߿� ������ 3������ ������ �˻��϶�
SELECT *
    FROM COURSE
    WHERE ST_NUM = 3
    AND PNO IS NULL;

--6) ȭ�а� ���õ� ������ ������ 2���� ������ ������ �˻��϶�
SELECT *
    FROM COURSE
    WHERE ST_NUM <= 2
    AND CNAME LIKE '%ȭ��';
    
--7) ȭ�а� �������� �˻��϶�
SELECT *
    FROM PROFESSOR
    WHERE SECTION = 'ȭ��'
    AND ORDERS = '������';


--8) �����а� �л��߿� ���� �縶���� �л��� �˻��϶�
SELECT *
    FROM STUDENT
    WHERE MAJOR = '����'
    AND SNAME LIKE '�縶%';


--9) ���� �̸��� ���� 1������ ������ �˻��϶�
SELECT *
    FROM PROFESSOR
    WHERE PNAME LIKE '__';
