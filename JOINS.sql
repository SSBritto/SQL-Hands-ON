use PRACTICE;

select * from EMP_SAL;
select * from EMP;

-- Details of the employees **not** having account in YAHOO

select COUNT(EID), EMAIL from EMP
GROUP BY EMAIL
HAVING (EMAIL LIKE '%YAHOO%');

-- DESI wise the BASIC and EIDs are arranged in DESC with BASIC

select * from EMP_SAL;

select DESI, SUM(BASIC) AS 'TOTAL SALARY', COUNT(EID) AS 'TOTAL NO.OF EMPLOYEES' from EMP_SAL
GROUP BY DESI
ORDER BY DESI DESC;


--JOINS

--INNER JOIN -- This join gives the **common records** among both the tables.

select EMP. EID,NAME, ADDR,CITY, DESI, DEPT, BASIC
from EMP
INNER JOIN EMP_SAL
ON EMP.EID = EMP_SAL.EID;

--LEFT JOIN -- This join gives all recrds from the **left table** no matter 
			-- how the right table is.

select * from EMP;
select * from EMP_SAL;

select EMP.EID,NAME,ADDR,CITY,DEPT,BASIC
from EMP
LEFT JOIN EMP_SAL
ON EMP.EID = EMP_SAL.EID;


--RIGHT JOIN -- This join gives all recrds from the **right table** no matter 
			 -- how the left table is.

select EMP.EID,NAME,ADDR,CITY,DEPT,BASIC
from EMP
RIGHT JOIN EMP_SAL
ON EMP.EID = EMP_SAL.EID;


--FULL JOIN -- This gives the recrd from **both** the tables w.r. to the columns


select EMP.EID,NAME,CITY,DEPT,DESI,BASIC from EMP
FULL JOIN EMP_SAL
ON EMP.EID = EMP_SAL.EID;


--CARTESIAN JOIN -- Also known as **CROSS JOIN** It gives the records from both tables
				 -- crossed with each other.

select EMP.EID,NAME,BASIC from EMP
CROSS JOIN EMP_SAL;



--SELF JOIN -- To achieve SELF JOIN a single table is duplicated. But virtually there
			-- is only one table. 'Aliasing' is mandatory in SELF JOIN. This join is made
			-- using the **LEFT JOIN**


use PRACTICE;

create table SJ 
(ID VARCHAR(2), NAME VARCHAR(1), BOSS_ID VARCHAR(2));

insert into SJ (ID,NAME)
values('1', 'A');
insert into SJ
values('2', 'B', '1');
insert into SJ
values('3', 'C', '1');
insert into SJ
values('4', 'D', '2');
insert into SJ
values('5', 'E', '3');
insert into SJ
values('6', 'F', '3');
insert into SJ
values('7', 'G', '6');


create table BOSS
(BID VARCHAR(2), NAME VARCHAR(2));

insert into BOSS
values('1','A');
insert into BOSS
values('2','B');
insert into BOSS
values('3','C');
insert into BOSS
values('6','F');

select * from SJ;
select * from BOSS;


-- If I need the ID, Name, and Boss Name in a table, used a LEFT JOIN


select SJ.ID, SJ.NAME, BOSS.NAME AS 'BOSS'
from SJ
LEFT JOIN BOSS
ON SJ.BOSS_ID = BOSS.BID;

--As BOSS is also the employee of a company, we have the BOSS id and the employee id 
--same in the second table. This involves in storing the same data in more than one table.
-- which is against **Normalization**

-- So lets take one table and duplicate that single table

select * from SJ;
select * from SJ;

select S1.ID, S1.NAME, S2.NAME AS 'BOSS_NAME' from SJ S1
LEFT JOIN SJ S2
on S1.BOSS_ID = S2.ID;



--SET CLAUSES-- UNION, UNION ALL, INTERSECT, EXCEPT

--A = {1 2 3 4 5}
--B = {4 5 6 7 8 9}
--AUB = {1 2 3 4 5 6 7 8 9}
--A UNION ALL B = {1 2 3 4 5 4 5 6 7 8 9}
--A INTERSECT B = {4 5}
--A EXCEPT B = {1 2 3}


--Similarly done using SET CLAUSES

create table TEST_1
(RNO INT, NAME VARCHAR(10), MARKS INT);
insert into TEST_1
values('1', 'KAPIL' ,'90');
insert into TEST_1
values('2', 'ROHAN' ,'95');
insert into TEST_1
values('3', 'KAJAL' ,'80');
insert into TEST_1(RNO,NAME)
values('4', 'AMIT');
insert into TEST_1(RNO,NAME)
values('5', 'RYAN');

select * from TEST_1;


create table TEST_2
(RNO INT, NAME VARCHAR(20), MARKS INT);

insert into TEST_2
values('1','KAPIL','90');
insert into TEST_2
values('2','ROHAN','95');
insert into TEST_2
values('3','RAJAT','80');
insert into TEST_2(MARKS)
values('79');
insert into TEST_2(MARKS)
values('94');

select * from TEST_1;
select * from TEST_2; 

select T1.RNO,T1.NAME,T2.MARKS FROM TEST_1 T1
LEFT JOIN TEST_2 T2
ON T1.RNO = T2.RNO;

select T1.RNO,T1.NAME,T2.MARKS FROM TEST_1 T1
RIGHT JOIN TEST_2 T2
ON T1.RNO = T2.RNO;


--UNION

select T1.RNO,T1.NAME,T2.MARKS FROM TEST_1 T1
LEFT JOIN TEST_2 T2
ON T1.RNO = T2.RNO;

select T1.RNO,T1.NAME,T2.MARKS FROM TEST_1 T1
RIGHT JOIN TEST_2 T2
ON T1.RNO = T2.RNO;

select T1.RNO,T1.NAME,T2.MARKS FROM TEST_1 T1
LEFT JOIN TEST_2 T2
ON T1.RNO = T2.RNO
UNION
select T1.RNO,T1.NAME,T2.MARKS FROM TEST_1 T1
RIGHT JOIN TEST_2 T2
ON T1.RNO = T2.RNO;

--UNION ALL

select T1.RNO,T1.NAME,T2.MARKS FROM TEST_1 T1
LEFT JOIN TEST_2 T2
ON T1.RNO = T2.RNO
UNION ALL
select T1.RNO,T1.NAME,T2.MARKS FROM TEST_1 T1
RIGHT JOIN TEST_2 T2
ON T1.RNO = T2.RNO;

--INTERSECT

select T1.RNO,T1.NAME,T2.MARKS FROM TEST_1 T1
LEFT JOIN TEST_2 T2
ON T1.RNO = T2.RNO
INTERSECT
select T1.RNO,T1.NAME,T2.MARKS FROM TEST_1 T1
RIGHT JOIN TEST_2 T2
ON T1.RNO = T2.RNO;

--EXCEPT

select T1.RNO,T1.NAME,T2.MARKS FROM TEST_1 T1
LEFT JOIN TEST_2 T2
ON T1.RNO = T2.RNO
EXCEPT
select T1.RNO,T1.NAME,T2.MARKS FROM TEST_1 T1
RIGHT JOIN TEST_2 T2
ON T1.RNO = T2.RNO;
