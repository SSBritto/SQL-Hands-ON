


use PRACTICE;

--Stored Procedures -- They are the names gn to the prewritten codes.


				--NOTE : USER DEFINED FUNCS also have the same meaning, but they are quite diff.

-- I need to see the employees of BANGALORE alone

select * from EMP
where CITY = 'BANGALORE';

		--Now if I need this to see everytime, I can create a Procedure for it.

CREATE PROCEDURE PRCITY 
as
BEGIN
		select * from EMP
		where CITY = 'BANGALORE';

END;

--Now,

PRCITY;		--Just by giving the name of the procedure, we can get the employees of BANGALORE


--If I need to see the employees of other cities too. Noneed to create other procedure, can do it in that

drop PROCEDURE PRCITY;
drop procedure PRCITY;
--Now recreating,

create procedure PRCITY @C as VARCHAR(30)
as
BEGIN

		select * from EMP
		where CITY = @C;

END;


--Now,

PRCITY 'NOIDA';
PRCITY 'DELHI';   -- Noneed to give () as like for user defined functions.

--If I need to see the datas of any table in a single procedure


drop procedure PRT;

create procedure PRT @T as VARCHAR(30)
as
BEGIN

			EXECUTE('select * from' +  '@T');
		
END;

--Now, (quite doubtful, see the class)


-- As the table is executed, we need to insert a recrd in the table.

select * from EMP;

--Normally we give as INSERT INTO EMP VALUES(.....)
			--But in use point of view,

create procedure PRINS @I as CHAR(5),@N as VARCHAR(30),@A as VARCHAR(30), @C as VARCHAR(10),
						@P as CHAR(10), @E as VARCHAR(50), @D as DATE
AS

BEGIN

			insert into EMP
			values(@I, @N, @A, @C, @P, @E, @D);

END;

--Now,

PRINS 'E0007', 'SHALIN BRITTO', '44A/4 CROSS ST', 'DELHI', '9789277670', 'SHALINBRITTO@GMAIL.COM',
		'10 APRIL 1997';

		select * from EMP;

		--Now, when the user just enter the details, it gets entered in the table.

		--Now if we no need the SELECT * FROM comnd and straight away get the details.
		

drop procedure PRINS;


create procedure PRINS @I as CHAR(5),@N as VARCHAR(30),@A as VARCHAR(30), @C as VARCHAR(10),
						@P as CHAR(10), @E as VARCHAR(50), @D as DATE
AS

BEGIN

			insert into EMP
			values(@I, @N, @A, @C, @P, @E, @D);
			select * from EMP;

END;

--Now, it gives straight away the table, when just the details are entered.

PRINS 'E0008', 'ALAN NILAN', '4TH AVENUE ST', 'NOIDA', '9980789900', 'ALAN@GMAIL.COM',
		'18 FEBRUARY 1997';


--Now need to insert data in TWO tables

select *from EMP;
select *from EMP_SAL;

drop procedure PRINS;

create procedure PRINS @I as CHAR(5),@N as VARCHAR(30),@A as VARCHAR(50), @C as VARCHAR(10),
						@P as CHAR(10), @E as VARCHAR(70), @D as DATE, @DPT as VARCHAR(10),
						@DSI as VARCHAR(10),@B as INT, @DJ as DATE

as

BEGIN

			insert into EMP
			values (@I,@N,@A,@C,@P,@E,@D);
			select * from EMP;

			insert into EMP_SAL
			values (@I,@DPT,@DSI,@B,@DJ);
			select * from EMP_SAL;

END;

PRINS 'E0009','ABISEK','33TH STR','MUMBAI','9909889070','ABISEK@GMAIL.COM','9 AUGUST 1998',
		'ADMIN', 'MNGR', '82000', '18 FEBRUARY 2020';

		--If the select * from query is not gn inside the procedure, 

		--"1 row(s) affected" -- This msg will be raised two times.

		--To switch off this msg whn creating the procedure without select query,

		--SET NOCOUNT ON -- To switch off it, SET NOCOUNT OFF


--If we need to DELETE a recrd from the table, we need to del them first from EMP_SAL table &
--then in EMP table, becoz they perform a parent child relationship.

DELETE from EMP_SAL
where EID 'E0009';

DELETE from EMP
where EID = 'E0009';

DELETE from EMP
where EID in ('E0006','E0007','E0008');

select * from EMp;
select * from EMP_SAL;

--Insertion of a recrd in both the tables and displaying(checking whether its inserted/not) at once,

drop procedure PRINS;

create procedure PRINS @I as CHAR(5), @N as VARCHAR(20), @A as VARCHAR(20), @C as VARCHAR(10),
						@P as CHAR(10), @E as VARCHAR(50), @D as DATE, @DPT as VARCHAR(10),
						@DSI as VARCHAR(10), @B as INT, @DJ as DATE

as

BEGIN

			insert into EMP
			values(@I,@N,@A,@C,@P,@E,@D);
			select * from EMP
			where EID = @I;

			insert into EMP_SAL
			values(@I,@DPT,@DSI,@B,@DJ);
			select * from EMP_SAL
			where EID = @I;

END;

PRINS 'E0006', 'AAKASH KUMAR', '2ND CROSS STR', 'DELHI', '8890907890', 'AAKASH@GMAIL.COM',
		'27 FEBRUARY 1999', 'MIS', 'ASSO', '37000', '22 MARCH 2019';


		--Here if the where condition is not gn we can see all the datas, as the where condition is gn
		-- we can see only that data in order to chck whether its inserted or not.



--If need to calculate the PF and HRA for the employees when newly inserted,

drop procedure PRINS;

create procedure PRINS @I as CHAR(5), @N as VARCHAR(20), @A as VARCHAR(20), @C as VARCHAR(10),
						@P as CHAR(10), @E as VARCHAR(50), @D as DATE, @DPT as VARCHAR(10),
						@DSI as VARCHAR(10), @B as INT, @DJ as DATE

as

BEGIN

			insert into EMP
			values(@I,@N,@A,@C,@P,@E,@D);
			select * from EMP;

			insert into EMP_SAL
			values(@I,@DPT,@DSI,@B,@DJ);
			select * from EMP_SAL;

			select EMP.EID,NAME,CITY,DEPT,DESI,BASIC as 'SALARY', BASIC*.1 as 'PF',BASIC*.15 as 'HRA'
			from EMP
			INNER JOIN EMP_SAL
			on EMP.EID = EMP_SAL.EID;

END;

PRINS 'E0007', 'PRAVEEN KUMAR', '1/A RD', 'DELHI', '9908997690', 'PRAVEEN@GMAIL.COM',
		'9 APRIL 1998', 'ADMIN', 'MNGR', '55000', '19 APRIL 2019';

		--this gives all the employees' PF and HRA calculated even though new employees are included
		--Their PF and HRA also been calculated.

--If we had mentioned the WHERE condition, with EID mentioned, we would have seen only that newly added
--employees' details in the table.