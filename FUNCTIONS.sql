use PRACTICE;

--SQL Functions

--COUNT() --Used to count the no. of rows in a database

		select count(*) EMP;

--MAX() -- Used to give the max no. of the specified field

		select * from EMP_SAL;
		select MAX(BASIC) from EMP_SAL;

--MIN() -- Used to give the min no. of the specified field

		select MIN(BASIC) from EMP_SAL;

--AVG() -- Used to give the avg of the field mentioned.

		select AVG(BASIC) from EMP_SAL;


--SUM() -- Used to give the 'total' of the field

		select SUM(BASIC) from EMP_SAL;
		
--SQRT() --Used to give the sq root of a number

		select SQRT(25);

--RAND() --Used to give a random number. Everytime when we execut, gives numbers btwn 0 and 1

		select RAND();

--CONCAT() -- Used to 'concatenate' ie 'join multiple characters together'.

		select CONCAT('HELLO', 'THIS', 'IS', 'BRITTO');

		--If we need space in between the characters, we can give a space at the end of *'* of each wrd.

		select CONCAT('HELLO ', 'THIS ', 'IS ', 'BRITTO');

		--(OR) can give ' ' in between

		select CONCAT('HELLO',' ', 'THIS',' ', 'IS',' ', 'BRITTO');


--RANK() -- Used to assign the rank. If suppose there are students with marks. Can assign a rank based on
		 -- their marks.

		 create table STU_MARKS
		 (RNO INT, NAME VARCHAR(20), MARKS INT);

		 insert into STU_MARKS
		 values('1', 'AJAY', '87');
		 insert into STU_MARKS
		 values('2', 'CHARLIE', '90');
		 insert into STU_MARKS
		 values('3', 'DARREN', '56');
		 insert into STU_MARKS
		 values('4', 'EDGAR', '97');
		 insert into STU_MARKS
		 values('5', 'FRANK', '87');

		 select * from STU_MARKS;

		 --Now if I need to give RANKS to them,
		 
		 select RNO,NAME,MARKS, RANK() 
		 OVER (ORDER BY MARKS DESC) as 'POSITION'
		 FROM STU_MARKS;

		 --**OVER BY** is the keyword used to know 'OVER which field' the RANK to be given.
		 --Here we can notice that two persons have same rank, and so the next rank got 
		 --skipped and the next person is given the 5th rank.


--DENSE_RANK() -- Used to give same as the RANK, but **nothing is skipped**.

				select RNO,NAME,MARKS, DENSE_RANK()
				OVER (ORDER BY MARKS DESC) AS 'POSITION'
				FROM STU_MARKS;

				-- Here we can notice the ranks are not skipped and both are gn with the same rank
				-- and then nxt rank is not skipped.


--ROW_NUMBER() -- Used to give the no. of rows in count in the table.

				select RNO,NAME, MARKS, ROW_NUMBER()
				OVER (ORDER BY MARKS DESC) as 'POSITION'
				FROM STU_MARKS;

				--Here all are alloted with diff numbers. Becoz these are row numbers and 
				-- not the RANKS/DENSE_RANKS.

			--*Note:* In all the three i.e. RANK(), DENSE_RANK(), ROW_NUMBER() 
					-- OVER BY keyword is used and its mandatory.
					

--SQL STRING FUNCTIONS

--ASCII() -- Gives the ascii value for any character value given.

			select ASCII('B');

--CHAR() -- Gives the character when an ascii value is given.

			select CHAR(56);

--CHARINDEX() -- Gives the 'position' of a character in a string.

			select CHARINDEX('T', 'BRITTO');

--LEFT() -- Gives the 'left hand side' of a string with a specified length.

			select LEFT('WELCOME', 3);

			--It gives the 3 letters from the left side.

--RIGHT() -- Gives the 'right hand side' of a string with a specified length.

			select RIGHT('WELCOME', 3);

--LEN() -- Used to find the 'length' of a string.

			select LEN('WELCOME');

--LOWER() -- Gives the lowercase to a string.

			select LOWER('Welcome');

--UPPER() -- Gives the uppercase to a string.

			select UPPER('Welcome');

--SUBSTRING() -- Used to extract 'a part' of a string.

			select SUBSTRING('WELCOME', 4, 4);

--REVERSE() -- Used to give a string in reverse as an output.

			select REVERSE('WELCOME');

--STUFF() -- A bunch of letters are replaced with a specified set of letters
		  -- in the specified position and the result is gn as a string.

		  select STUFF('WELCOME', 2, 6, 'ARRIOR');

	-- The above are executed in rows, and now for columns,


	select * from EMP;

	--Now if I need only ADDR and CITY to be executed from the table.

	select EID,NAME,CONCAT(ADDR,' ',CITY) as 'ADDRESS'
	from EMP;

	--If we need the ADDRESS to be in lower case,

	select EID,NAME,LOWER(CONCAT(ADDR,' ',CITY)) as 'ADDRESS'
	from EMP;

	--If need to extract the first letter of everyone's name,

	select EID,NAME,UPPER(CONCAT(ADDR,' ',CITY)) as 'ADDRESS', LEFT(NAME, 1) as 'INITIAL'
	from EMP;

	--If I need to extract the first name from all the names,

	--First I need to find the space between the first & the last name.

	-- Then make it combine with the LEFT FUNCTION

	select EID, NAME, CHARINDEX(' ', NAME) as 'SPACE'
	from EMP;

	--Now we can separate the first name with LEFT function

	select EID,NAME,LEFT(NAME,CHARINDEX(' ',NAME)) as 'FIRST_NAME' 
	from EMP;

	--If I need to have the last name, 'RIGHT Function' is used. But not in the same logic. 
	--Becoz we need to know the 'length of the name' first and then we need to sutract them from the 
	--'space'.

	select EID,NAME,LEN(NAME) as 'LENGTH'
	from EMP;

	select EID,NAME,RIGHT(NAME,LEN(NAME) - CHARINDEX(' ',NAME)) as 'LAST_NAME'
	from EMP;

	select * from EMP;

	create table EMP_2
	(EID CHAR(5), NAME VARCHAR(30), CITY VARCHAR(30));

	insert into EMP_2
	values('E0001', 'AJAY KRISHNA', 'CHENNAI');
	insert into EMP_2
	values('E0002', 'AJAY ATUL', 'MUMBAI');
	insert into EMP_2
	values('E0003', 'BALA KRISHNAN', 'DELHI');
	insert into EMP_2
	values('E0004', 'CHARLIE MATHEW', 'CHENNAI');
	insert into EMP_2
	values('E0005', 'CHENGIZ KHAN', 'MUMBAI');
	insert into EMP_2
	values('E0006', 'DANIEL RADCLIFF', 'NOIDA');
	insert into EMP_2
	values('E0007', 'EDGAR MATHEW', 'CHENNAI');
	insert into EMP_2
	values('E0008', 'FRANKLIN JOHN', 'CHENNAI');
	insert into EMP_2
	values('E0009', 'GEO NITHIN', 'NOIDA');
	insert into EMP_2
	values('E0010', 'HUTCH BRICK', 'DELHI');

	select * from EMP_2;

	--Now extracting the First letter as Initial

	select EID,NAME, LEFT(NAME,1) as 'INITIAL'
	from EMP_2;

	--Now extracting the "First" name alone (Finding the space and then extracting them)

	select EID,NAME, CHARINDEX(' ', NAME) as 'SPACE'
	from EMP_2;

	select EID, NAME, LEFT(NAME, CHARINDEX(' ',NAME)) as 'FIRST_NAME',CITY
	from EMP_2;

	--Now extracting the "Last" name alone (Finding the space and length of the name & extracting them)

	select EID,NAME, LEN(NAME)
	from EMP_2;

	select EID,NAME,RIGHT(NAME,LEN(NAME) - CHARINDEX(' ',NAME)) as 'LAST_NAME', CITY
	from EMP_2;

	--Finally extracting all the three together,

	-- INITIAL, FIRST_NAME, LAST_NAME together.

	select EID,NAME,LEFT(NAME,1) as 'INITIAL', LEFT(NAME,CHARINDEX(' ',NAME)) as 'FIRST_NAME',
	RIGHT(NAME,LEN(NAME) - CHARINDEX(' ',NAME)) as 'LAST_NAME', CITY
	from EMP_2;