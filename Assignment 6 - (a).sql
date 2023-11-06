
--USER DEFINED FUNCTIONS --Assignment


use DEMO;

--Create a func CALC to solve two numbers using specific operations

create function CALC (@A as INT, @B as INT, @O as CHAR(1))
RETURNS INT
as
BEGIN

			DECLARE @R as INT;
			
			IF @O = '+'
				SET @R = @A + @B;
			ELSE IF @O = '-'
				SET @R = @A - @B;
			ELSE 
				SET @R = '0';

			RETURN @R;

END;

select DBO.CALC(20,50,'%');

--Function to generate EMAIL, with f letter of fname, f letter of l name, EID last 3 char and
--@RCG.COM

create function CORPMAIL(@I as CHAR(5), @N as VARCHAR(20), @M as VARCHAR(50))
RETURNS VARCHAR(50)
as
BEGIN

		DECLARE @EM as VARCHAR(50);
		DECLARE @L as INT;
		DECLARE @S as INT;
		DECLARE @LN as VARCHAR(20);

		SET @L = LEN(@N);
		SET @S = CHARINDEX(' ' ,@N);
		SET @LN = SUBSTRING(RIGHT(@N, LEN(@N) - @S),1,1);
		SET @EM = UPPER(CONCAT(LEFT(@N,1),@LN, RIGHT(@I,3),
				'@', @M, '.COM'));

		RETURN @EM;

END;


select DBO.CORPMAIL('E0010', 'BABU JOSE', 'OUTLOOK');

--Also in table

select EID,NAME,DBO.CORPMAIL(EID,NAME,'OUTLOOK') as 'CORPORATE MAIL'
from EMP;


--Function to return EID,NAME,DESI,SALARY of employees of a specified DEPT

select * from EMP_SAL;
create function DPT()
RETURNS TABLE
as

	RETURN(select EID,NAME,DESI,DEPT,SALARY from EMP_SAL
	where DEPT = 'IT');
drop function DPT;
select * from DPT();

--Also if need to change the DEPT everytime,

drop function DPT;

create function DPT(@D as VARCHAR(10))
RETURNS TABLE
as

	RETURN(select EID,NAME,DESI,DEPT,SALARY from EMP_SAL
	where DEPT = @D);

select * from DPT('MIS');
select * from DPT('IT');


select * from EMP;
select * from EMP_SAL;

--I need to create a login passcode for all employees
--with EID 3 characters
--F name First 2 letters
--Last name First 2 letters

create function PCODE (@I as CHAR(5), @N as VARCHAR(30), @C as VARCHAR(20))
RETURNS VARCHAR(60)
as
BEGIN

			DECLARE @P as VARCHAR(60);
			DECLARE @L as INT;
			DECLARE @S as INT;
			DECLARE @LN as VARCHAR(20);

			SET @L = LEN(@N);
			SET @S = CHARINDEX(' ',@N);
			SET @LN = SUBSTRING(RIGHT(@N,LEN(@N) - @S),1,2);
			SET @P = UPPER(CONCAT(LEFT(@I,3),LEFT(@N,1),@LN,@C));

			RETURN @P;

END;


select EID,NAME, DBO.PCODE(EID,NAME,'CODE') as 'PASSCODE'
from EMP;


