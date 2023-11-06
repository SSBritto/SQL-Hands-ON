use DEMO;

--Need to execute a corporate email id for the employees, which include
--1st character of name
--last name
--last three digits of EID
--atlast with '@OUTLOOK.COM'.

select * from EMP_SAL;

select EID,NAME,UPPER(CONCAT(LEFT(NAME,1),RIGHT(NAME,LEN(NAME)-CHARINDEX(' ',NAME)),RIGHT(EID,3),
'@OUTLOOK.COM')) as 'CORPORATE EMAIL'
from EMP_SAL;

--DEPT wise TEAM size and AVG salary of all employees

select * from EMP_SAL;

select count(EID) as 'TOTAL EMPLOYEES',DEPT,AVG(SALARY) as 'AVG SALARY'
from EMP_SAL
group by DEPT
order by DEPT;


--Count of Managers in the company

select * from EMP_SAL;

select count(EID) as 'NO.OF MANAGERS'
from EMP_SAL
where DESI = 'MANAGER';


--Maximum and Minimum salary of an ASSOCIATE

select * from EMP_SAL;

select MAX(SALARY)as 'MAX SALARY', MIN(SALARY) as 'MIN SALARY'
from EMP_SAL
where DESI = 'ASSOCIATE';

-- Dept wise Team Size & Avg salary of DELHI employees

select * from EMP_SAL;
select * from EMP;

select DEPT, count(EID) as 'NO.OF EMPLOYEES',AVG(SALARY) as 'AVG SALARY'
from EMP_SAL
where EID in (select EID from EMP where CITY ='DELHI')
group by DEPT;

create table E_1
(EID CHAR(5), NAME VARCHAR(30), CITY VARCHAR(20), EMAIL VARCHAR(50));

insert into E_1
values('E0001', 'ANISH BABU', 'NOIDA', 'ANISH@GMAIL.COM');
insert into E_1
values('E0002', 'ASWIN', 'DELHI', 'ASWIN@OUTLOOK.COM');
insert into E_1
values('E0003', 'ANISHA', 'NOIDA', 'ANISHA@GMAIL.COM');
insert into E_1
values('E0004', 'AJAY KRISHNA', 'DELHI', 'AJAY@YAHOO.COM');
insert into E_1
values('E0005', 'BENNY', 'DELHI', 'BENNY@GMAIL.COM');

create table E_SAL
(EID CHAR(5), DEPT VARCHAR(10), DESI VARCHAR(20), SALARY INT);

insert into E_SAL
values('E0001', 'IT', 'ASSOCIATE', 33000)

insert into E_SAL
values('E0002', 'MIS', 'ASSOCIATE', 35000);

insert into E_SAL
values('E0003', 'OPS', 'ASSISTANT', 44000);

insert into E_SAL
values('E0004', 'IT', 'MANAGER', 50000);

insert into E_SAL
values('E0005', 'OPS', 'OPERATION MANAGER', 45000);

select * from E_1;
select * from E_SAL;

-- Dept wise Team Size & Avg salary of DELHI employees

select DEPT, count(EID) as 'NO.OF EMPLOYEES', AVG(SALARY) as 'AVG SALARY'
from E_SAL
where EID in (select EID from E_1 where CITY = 'DELHI')
group by DEPT;

--Generate official Mail id with
--1st char of fname
--1st char of lname
--last 3 digits of EID
--followed by '@RCG.COM'
--should be in UPPER case

CREATE FUNCTION CMAIL (@ID AS CHAR(5),@N AS VARCHAR(30))
RETURNS VARCHAR(100)
AS
BEGIN

			DECLARE @EM AS VARCHAR(100);
			DECLARE @LN AS INT;
			DECLARE @S AS INT;
			DECLARE @LL AS CHAR(1);

			SET @LN = LEN(@N);
			SET @S = CHARINDEX(' ' ,@N);
			SET @LL = SUBSTRING(RIGHT(@N,@LN-@S),1,1);
			SET @EM = UPPER(CONCAT(LEFT(@N,1),@LL,RIGHT(@ID,3),'@RCG.COM'));

			RETURN @EM;

END;

SELECT DBO.CMAIL('E0001','ABHISHEK GUPTA');


--CREATION OF CORPORATE MAIL IDS FOR NEW EMPLOYEES :

ALTER TABLE E_1
ADD CORPMAIL VARCHAR(100);

SELECT * FROM E_1;

UPDATE E_1 SET CORPMAIL = UPPER(CONCAT(LEFT(NAME,1),SUBSTRING(RIGHT(NAME,LEN(NAME)-CHARINDEX(' ', NAME)),1,1),
						RIGHT(EID,3),'@OUTLOOK.COM'))
WHERE EID BETWEEN 'E0001' AND 'E0008';

SELECT * FROM E_1;
SELECT * FROM E_SAL;




CREATE PROCEDURE C_MAIL (@ID AS CHAR(5),@N AS VARCHAR(30), @C AS VARCHAR(10),@M AS VARCHAR(100),@DB AS DATE,@DJ AS DATE,
						@DPT AS VARCHAR(10),@DSI AS VARCHAR(20),@SAL AS INT)
AS
BEGIN

				DECLARE @EM AS VARCHAR(100);
				DECLARE @LN AS INT;
				DECLARE @S AS INT;
				DECLARE @LL AS CHAR(1);

				SET @LN = LEN(@N);
				SET @S = CHARINDEX(' ' ,@N);
				SET @LL = SUBSTRING(RIGHT(@N,@LN-@S),1,1);
				SET @EM = UPPER(CONCAT(LEFT(@N,1),@LL,RIGHT(@ID,3),'@OUTLOOK.COM'));


				INSERT INTO E_1(EID,NAME,CITY,EMAIL,DOB,DOJ,CORPMAIL)
				VALUES(@ID,@N,@C,@M,@DB,@DJ,@EM);
				
				SELECT * FROM E_1;

				INSERT INTO E_SAL
				VALUES(@ID,@DPT,@DSI,@SAL);

				SELECT * FROM E_SAL;

END;

SELECT * FROM E_SAL;

DROP PROCEDURE C_MAIL;

C_MAIL 'E0009','PETER DAMIAN','MUMBAI','PETER@GMAIL.COM', '19 NOVEMBER 1998', '21 DECEMBER 2021',
		'IT','ASSOCIATE','26000';


				



