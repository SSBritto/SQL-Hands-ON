use PRACTICE;

--USER DEFINED FUNCTIONS

-- These are functions which SQL allows the user to create
--These are the names given to a pre written codes.


CREATE FUNCTION MYSUM (@A as INT, @B as INT)
RETURNS INT
AS
BEGIN
		DECLARE @R as INT;
		SET @R = @A + @B;
		RETURN @R;

END;

--Now,

select DBO.MYSUM(20,50);

--As its a user defined function, while using SELECT,
--DBO. is used near the function.


create function MYCAL (@A as INT, @B as INT, @O as CHAR(1))
RETURNS INT
as
BEGIN

		DECLARE @C as INT
		if @O = '+'
		SET @C = @A + @B;
		else if @O = '-'
		SET @C = @A - @B;
		else if @O = '*'
		SET @C = @A*@B;
		else if @O = '/'
		SET @C = @A/@B;

		else
		SET @C = 0;

		RETURN @C

END;

--Therefore,		

select DBO.MYCAL (20,20,'/');
select DBO.MYCAL (20,20,'+');
select DBO.MYCAL (20,20,'-');
select DBO.MYCAL(20,20,'*');
select DBO.MYCAL(20,20,'>'); -- Here this operator is not gn in the func, so it retrns 0.



--Creating an Email id with f letter of fNAME, last name, EID(last 3 digits),Domain of Email


create function DMAIL (@ID as CHAR(5),@N as VARCHAR(30), @E as VARCHAR(50))
RETURNS VARCHAR(100)
as
BEGIN

			DECLARE @CM as VARCHAR(100)
			DECLARE @L as INT;
			DECLARE @S as INT;
			DECLARE @LN as VARCHAR(20);

			SET @L = LEN(@N);
			SET @S = CHARINDEX(' ', @N);
			SET @LN = RIGHT(@N,LEN(@N) - @S);
			SET @CM = UPPER(CONCAT(LEFT(@N,1), @LN, RIGHT(@ID,3),'@',@E,'.COM'));
			RETURN @CM;

END;

select EID,NAME,DBO.DMAIL('E0001',NAME,'OUTLOOK')as 'CORPORATE_MAIL'
from EMP;

--There are two types in User defined functions.
--SCALAR 
--TABLE VALUED


select * from EMP;
select * from EMP_SAL;

select EMP.EID,NAME,CITY,DEPT,DESI,BASIC from EMP
INNER JOIN EMP_SAL
on EMP.EID = EMP_SAL.EID;

--Creating an User defined function for displaying a joined table :

create function EMP_BAS()
RETURNS TABLE
as

	RETURN(select EMP.EID,NAME,CITY,DEPT,DESI,BASIC from EMP
	INNER JOIN EMP_SAL
	on EMP.EID = EMP_SAL.EID);

select * from EMP_BAS();

-- In TABLE VALUED we can have only RETURN statement. And there is no DECLARE, BEGIN and END.

-- instead of only using "DBO." we can use the FROM clause. The DBO. query is applicable only in SCALAR function.

select * from EMP;
select * from EMP_SAL;

--Now ,need the details only Bangalore employees with EID,NAME,CITY,DEPT,DESI,BASIC

select EMP.EID,NAME,CITY,DEPT,DESI,DOJ,BASIC as 'SALARY',BASIC*.15 as 'PF', BASIC*.09 as 'HRA'
from EMP
INNER JOIN EMP_SAL
on EMP.EID = EMP_SAL.EID
where CITY = 'BANGALORE';

--Now, creating User defined func for this

create function EMP_CITY()
RETURNS TABLE
as
	RETURN(select EMP.EID,NAME,CITY,DEPT,DESI,DOJ,BASIC as 'SALARY',BASIC*.15 as 'PF', BASIC*.09 as 'HRA'
			from EMP
			INNER JOIN EMP_SAL
			on EMP.EID = EMP_SAL.EID
			where CITY = 'BANGALORE');

select * from EMP_CITY();

--Thiis func is used for only Bangalore employees. If I need to change the cities everytime,

drop function EMP_CITY;

--Now for any cities mentioned,

create function EMP_CITY(@C as VARCHAR(30))
RETURNS TABLE
as
	RETURN(select EMP.EID,NAME,CITY,DEPT,DESI,DOJ,BASIC as 'SALARY',BASIC*.15 as 'PF', BASIC*.09 as 'HRA'
			from EMP
			INNER JOIN EMP_SAL
			on EMP.EID = EMP_SAL.EID
			where CITY = @C);


select * from EMP_CITY('BANGALORE');
select * from EMP_CITY('DELHI');


select * from EMP;

--Creating an Email id with f letter of fNAME, last name, EID(last 3 digits),Domain of Email


create function DMAIL (@ID as CHAR(5),@N as VARCHAR(30), @E as VARCHAR(50))
RETURNS VARCHAR(100)
as
BEGIN

			DECLARE @CM as VARCHAR(100)
			DECLARE @L as INT;
			DECLARE @S as INT;
			DECLARE @LN as VARCHAR(20);

			SET @L = LEN(@N);
			SET @S = CHARINDEX(' ', @N);
			SET @LN = RIGHT(@N,LEN(@N) - @S);
			SET @CM = UPPER(CONCAT(LEFT(@N,1), @LN, RIGHT(@ID,3),'@',@E,'.COM'));
			RETURN @CM;

END;


--I need to create a Corporate mail for the employees,
--with fname first letter
--with lname first letter
--with EID
--with @OUTLOOK.COM

--SCALAR--
create function MYMAIL(@I as CHAR(5), @N as VARCHAR(30), @MAIL as VARCHAR(50))
RETURNS VARCHAR(50)
as
BEGIN 

				DECLARE @M as VARCHAR(50);
				DECLARE @L as INT
				DECLARE @S as INT;
				DECLARE @LN as VARCHAR(20);

				SET @L = LEN(@N);
				SET @S = CHARINDEX(' ',@N);
				SET @LN = SUBSTRING(RIGHT(@N,LEN(@N) - @S),1,1);
				SET @M = UPPER(CONCAT(LEFT(@N,1), @LN, @I, '@', @MAIL, '.COM'));
				RETURN @M;

END;

select * from EMP;	

select EID,NAME,DBO.MYMAIL('E0001', 'ANISH BABU', '@OUTLOOK.COM') as 'MYMAIL'
from EMP;


