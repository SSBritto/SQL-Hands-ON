use PRACTICE;


--Sub Query

--Other names for Sub Queries are "INNER QUERY" / "NESTED QUERY".
-- A query within a query is known as the sub query.

select * from EMP;
select * from EMP_SAL;

-- I need to get the EID,NAME,CITY for the ASSOCIATES.

--In JOINS, we do as,

select EMP.EID,NAME,CITY from EMP
INNER JOIN EMP_SAL
on EMP.EID = EMP_SAL.EID
where DESI ='ASSO';

--JOINS are used to retrieve datas from two tables.But here we need only from one table. 

select EMP.EID,NAME,CITY from EMP
INNER JOIN EMP_SAL
on EMP.EID = EMP_SAL.EID
where DESI ='ASSO';

select EID,NAME,CITY from EMP    -- Here we are displaying the datas from EMP table alone.
where EID in (select EID from EMP_SAL where DESI = 'ASSO');

--This type of writing one query under another query is known as the SUBQUERY.

-- I need to get the EID,DEPT,DESI,SALARY of the BANGALORE employees.

select * from EMP;
select * from EMP_SAL;

select EID,DEPT,DESI,BASIC as 'SALARY' from EMP_SAL    -- Here we display datas from EMP_SAL table alone.
where EID in (select EID from EMP where CITY = 'BANGALORE');



-- I need to get the EID,NAME,DEPT,DESI of HR team members

--Here we need to display datas from "two tables". So here we use JOINS.

select EMP.EID,NAME,DEPT,DESI from EMP
INNER JOIN EMP_SAL
on EMP.EID = EMP_SAL.EID
where DEPT = 'MIS';


--INSERT SUBQUERY

create table TRAINING
(EID CHAR(5), NAME VARCHAR(20), MODULE VARCHAR(3),DEPT VARCHAR(10));

-- Here we can use the SUB query to insert the datas into the training table.
--Normally we write the query as 
--INSERT INTO TRAINING(EID,NAME,DEPT) values(......)
	
--Instead, we can write as,

INSERT into TRAINING (EID,NAME,DEPT)
select EMP.EID,NAME,DEPT from EMP
INNER JOIN EMP_SAL
on EMP.EID = EMP_SAL.EID
where DEPT = 'MIS';

select * from TRAINING;


-- I need to include the MODULE name as "SQL".

update TRAINING set MODULE = 'SQL';

select * from TRAINING;

--DELETE SUBQUERY

select * from EMP;
select * from EMP_SAL;
select * from TRAINING;

insert into TRAINING (EID,NAME,DEPT)
select EMP.EID,NAME,DEPT from EMP
INNER JOIN EMP_SAL
on EMP.EID = EMP_SAL.EID
where DEPT = 'OPS';

select * from TRAINING;
update TRAINING set MODULE = 'SQL';

--DELETE SUBQUERY - explain

--If I no need the MNGR to attend the TRAINING program,

DELETE from TRAINING
where EID in (select EID from EMP_SAL where DESI LIKE '%MNGR');

select * from TRAINING;


-- I need the EID,DESI,DEPT,BASIC,DOJ details of 'BANGALORE' team members

select *from EMP;
select * from EMP_SAL;

select * from EMP_SAL
where EID in (select EID from EMP where CITY ='BANGALORE');

--UPDATE SUB QUERY

--Now if I need to increase the BASIC of the "BANGALORE employees by '5000'

update EMP_SAL set BASIC = BASIC + 5000
where EID in (select EID from EMP where city = 'BANGALORE');

select * from EMP;
select * from EMP_SAL;


--So the types of SUBQUERIES are INSERT,DELETE,UPDATE SUBQUERIES.

--Few rules are there.

--INNER QUERY can't have "multiple fields" to be executed. The inner query can be executed alone with
--multiple fields, but can't be executed as a subquery.

--"ORDER BY" can't be used in SUBQUERY. ( In the inner query it works fine)

--Subqueries can be used with multiple value operators i.e. "IN" when it returns more than one row.

		--eg : I need the employees' EID,NAME,CITY who gets salary more than 50000

		select * from EMP_SAL;
		select EID,NAME,CITY from EMP
		where EID in (select EID from EMP_SAL where BASIC > 50000);


--BETWEEN operator can't be used with a subquery, but can be used inside the subquery.
--i.e. the BETWEEN operator is executed inside the SUBQUERY, but can't be executed along with the
--outer query.

--There are two type of QUERIES,
--SIMPLE, CORRELATED.

--CORRELATED queries are also known as the 'SYNCHRONIZED QUERY', as they are incorporate with the outer
--queries somehow.

	--eg : I need the total employees with their avg salary.

	select count(EID), AVG(BASIC) from EMP_SAL;

	--eg : I need the total employees with their AVG salaries from the city  BANAGALORE.

	select count(EID) as'NO.OF EMPLOYEES', AVG(BASIC) as 'AVG SALARY' from EMP_SAL
	where EID in (select EID from EMP where CITY = 'BANGALORE');

	--eg : I need the total employees of the city = 'BANGALORE' and AVG salary more than 20000


	select count(EID) as 'TOTAL EMPLOYEES', AVG(BASIC) as 'AVG SALARY' from EMP_SAL
	where EID in (select EID from EMP where CITY ='BANGALORE' and EID in
	(select EID from EMP_SAL where BASIC > 20000));
