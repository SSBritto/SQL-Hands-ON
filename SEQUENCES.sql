

--SEQUENCES :

		-- Sequences are the "database objects" which are used to generate "sequential numbers".

		--Query :
create sequence MYSEQ
as int
start with 1
increment by 1;

--Now,

select next value for myseq; --IN sequences, NEXT VALUE is used for the  FETCHING OF DATA.


-- MAXVALUE :

drop sequence MYSEQ;

create sequence myseq
as int
start with 1
increment by 1
MAXVALUE 10;

select next value for myseq;

--CYCLE :

drop sequence MYSEQ;

create sequence MYSEQ
as  int
start with 1
increment by 1
MAXVALUE 10
CYCLE;			

--MINVALUE :

drop sequence MYSEQ;
create sequence MYSEQ
as  int
start with 1
increment by 1
MAXVALUE 10
MINVALUE 1
CYCLE;		

select next value for myseq;  

--CACHE :

drop sequence MYSEQ;
create sequence MYSEQ
as int
start with 1
increment by 1
MAXVALUE 10
MINVALUE 1
CYCLE
CACHE 5; 

select next value for myseq;

drop sequence MYSEQ;

create sequence MYSEQ
as int
start with 1
increment by 1;

create table E(EID INT, NAME VARCHAR(20), AGE INT);

insert into E values(next value for MYSEQ, 'ABAASH', 29);
select * from E;

drop sequence MYSEQ;

create sequence MYSEQ
as int
start with 1
increment by 1;

--Now, creating a procedure,

CREATE PROCEDURE SEQ @N as VARCHAR(30), @A as INT
as

		insert into E
		values(next value for MYSEQ,@N,@A);

		select * from E;

--Now,

SEQ 'BALA', 22; 

--But there is a method to create an alphanumeric ID using SEQUENCE & PROCEDURE,


drop sequence MYSEQ;
drop procedure SEQ;
drop table EMP_3;

create sequence MYSEQ
as int
start with 1
increment by 1;

create table EMP_3
(EID CHAR(5), NAME VARCHAR(30), AGE INT);

create procedure SEQ @N as VARCHAR(30), @A as INT
as

BEGIN
		DECLARE @I as INT;
		DECLARE @ID as CHAR(5);

		SET @I = (NEXT VALUE FOR MYSEQ);

		IF @I<10
		SET @ID = CONCAT('E000',@I);

		ELSE IF @I<100
		SET @ID = CONCAT('E00',@I);

		ELSE IF @I<1000
		SET @ID = CONCAT('E0',@I);

		ELSE IF @I<10000
		SET @ID = CONCAT('E',@I);

		ELSE
		SET @ID = 'NA';


		INSERT INTO EMP_3
		values(@ID, @N, @A);

		select * from EMP_3;

END;

SEQ 'ABISHEK', 23;
SEQ 'BALA', 22;

-----------------------------------------------------------------------------------------------

create function CID (@C as CHAR(1), @I as INT)
RETURNS CHAR(5)
as
BEGIN

		DECLARE @ID AS CHAR(5);

		IF @I<10
		SET @ID = CONCAT(@C, '000', @I);

		ELSE IF @I<100
		SET @ID = CONCAT(@C, '00', @I);

		ELSE IF @I<1000
		SET @ID = CONCAT(@C, '0', @I);

		ELSE 
		SET @ID = 'NA';

		RETURN @ID;

END;

--Now, if we give,

select DBO.CID ('E','1');
select DBO.CID ('C', '1')
select DBO.CID ('S', '1');
select DBO.CID ('O', '1');

--Now, we can see that, incorporate PROCEDURE with USER DEFINED FUNCTION

drop procedure SEQ;

CREATE PROCEDURE CIDSEQ @N as VARCHAR(30), @A as INT
as

BEGIN

		DECLARE @I as INT;
		DECLARE @ID as CHAR(5);

		SET @I = (NEXT VALUE FOR MYSEQ);
		SET @ID = DBO.CID('E',@I);

		INSERT INTO EMP_3
		VALUES(@ID,@N,@A);

		SELECT * FROM EMP_3;

END;

CIDSEQ 'ABISHEK','22';
CIDSEQ 'CHARLIE','25';

drop sequence MYSEQ;
drop function CID;
drop procedure CIDSEQ;


--------------------------------------------------------------------------------------------------

--SEQUENCE:

CREATE SEQUENCE MYSEQ AS INT
START WITH 1
INCREMENT BY 1;

CREATE TABLE EMP_4
(EID CHAR(5), NAME VARCHAR(30), AGE INT);

SELECT * FROM EMP_4;

--USER DEFINED FUNCTION

CREATE FUNCTION CID (@C as CHAR(1), @I as INT)
RETURNS CHAR(5)
as

BEGIN

			DECLARE @ID as CHAR(5);

			IF @I<10
			SET @ID = CONCAT(@C,'000',@I);

			ELSE IF @I<100
			SET @ID = CONCAT(@C,'00',@I);

			ELSE IF @I<1000
			SET @ID = CONCAT(@C,'0',@I);

			ELSE 
			SET @ID = 'NA';

			RETURN @ID;

END;

select DBO.CID('E',2);
select DBO.CID('S',267);

--PROCEDURE :

CREATE PROCEDURE PRCID @N as VARCHAR(30), @A as INT
as

BEGIN

			DECLARE @I as INT;
			DECLARE @ID as CHAR(5);

			SET @I = (NEXT VALUE FOR MYSEQ);
			SET @ID = DBO.CID('S',@I);

			INSERT INTO EMP_4
			VALUES(@ID,@N,@A);

			SELECT * FROM EMP_4;

END;

PRCID 'SHALIN BRITTO',25;
PRCID 'MATHIVAANAN',26;
PRCID 'ANTO MATHI', 22;
PRCID 'RETHIN CHARLES', 20;
PRCID 'YASHVANTHINI' ,24;

