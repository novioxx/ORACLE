--1) �� �л��� ������ �˻��϶�(��Ī�� ���)
SELECT substr(AVR, 0 ,3) AS STUDENT_NO
        , SNAME AS
    FROM STUDENT;

--2) �� ������ �������� �˻��϶�(��Ī�� ���)
SELECT ST_NUM AS ����
    , CNAME AS ����
    FROM COURSE;

--3) �� ������ ������ �˻��϶�(��Ī�� ���)
SELECT PNAME AS ����
    ,  ORDERS AS ����
    FROM PROFESSOR;
    

--4) �޿��� 10%�λ����� �� ���� ���޵Ǵ� �޿��� �˻��϶�(��Ī�� ���)
SELECT SAL * 1.1  AS �޿�
    FROM EMP;
    
--5) ���� �л��� ��� ������ 4.0�����̴�. �̸� 4.5�������� ȯ���ؼ� �˻��϶�(��Ī�� ���)
SELECT ST.SNO, ST.SNAME, ST.AVR * 4.5 / 4.0 FROM STUDENT ST;