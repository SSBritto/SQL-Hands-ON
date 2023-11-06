

--SQL DATE FUNCTIONS

--GETDATE -- Gives the "current date & time".

		use PRACTICE;
		select GETDATE();

--DATEADD -- It adds a number to a date. Takes "3" arguments.

		select GETDATE();
		--Now,
		select DATEADD(D, 10, GETDATE());

		--Done in months and years also

		select DATEADD(M, 5, GETDATE());
		select DATEADD(YY, 4, GETDATE());

--DATEDIFF() -- It gives difference value from a number to a date. Takes "3" arguments.

			--Now used in columns

			select * from EMP;

			select EID,NAME,DOB, DATEDIFF(D, DOB, GETDATE()) as 'DATECHANGE'
			from EMP;

			--This gives how many days it got changed from DOB.

			--Done in months and years also.

			select EID,NAME,DOB, DATEDIFF(M,DOB,GETDATE()) as 'MONCHANGE'
			from EMP;

			select EID,NAME,DOB, DATEDIFF(YY,DOB,GETDATE()) as 'YEARCHANGE'
			from EMP;

--DAY() --Just gives the DAY from the current date.

			select GETDATE(), DAY(GETDATE()) as 'NO.OF.DAYS';

			--Done in months & years also.

--MONTH() -- Just gives the MONTH from the current date.

			select GETDATE(), MONTH(GETDATE()) as 'NO.OF MONTHS';

--YEAR() --Just gives the YEAR from the current date.

			select GETDATE(), YEAR(GETDATE()) as 'NO.OF YEARS';

--DATEPART() --This also works as same as the DAY,MONTH,YEAR functions

			select GETDATE(),DATEPART(D,GETDATE()) as 'DAY', DATEPART(M,GETDATE()) as 'MTH',
			DATEPART(YY,GETDATE()) as 'YR';

			--DAY,MONTH & YEAR functions and also DATEPART function gives the same output only.
			-- But here we used only one function (DATEPART) but there we use three diff functions.


--CONVERT() -- Used to convert a data into a datatype.

			select CONVERT(VARCHAR(20), GETDATE());

			--Here the date is changed from its date format to a text format.
			--Here we have an optional parameter which makes the date into a short form.
			--The number is not fixed.

			select CONVERT(VARCHAR(20), GETDATE(), 5);


--FORMAT() -- This used to give the "full form" of the date w.r.to the parameter given.

				select GETDATE(), FORMAT(GETDATE(), 'D');

				--This can be done in MONTH and YEAR also

				select GETDATE(), FORMAT(GETDATE(), 'M');
				select GETDATE(), FORMAT(GETDATE(), 'Y'); -- For FORMAT alone Year is given with "Y" alone.
														  -- Not "YY".

	select * from EMP_SAL;

	update EMP_SAL set DOJ = '01 AUGUST 2019'
	where EID = 'E0001';
	update EMP_SAL set DOJ = '10 SEPTEMBER 2019'
	where EID = 'E0002';
	update EMP_SAL set DOJ = '11 SEPTEMBER 2019'
	where EID = 'E0003';
	update EMP_SAL set DOJ = '21 SEPTEMBER 2019'
	where EID = 'E0004';
	update EMP_SAL set DOJ = '12 DECEMBER 2019'
	where EID = 'E0005';

	select * from EMP_SAL;

--Now if I need to confirm the DOJ of the employees "90 days" from their DOJ
--Use DATEADD

select EID,DEPT,DESI,BASIC,DOJ, DATEADD(D,90,DOJ) as 'CONFIRM_DATE'
from EMP_SAL;

--If I need the list of employees who had joined in the year of 2021. Can be used with month also.
--But the month should be mentioned in "number type".

select EID,DOJ from EMP_SAL
where YEAR(DOJ) = 2019;

select EID,DOJ from EMP_SAL
where MONTH(DOJ) = 8;

--If I need to find the total no. of employees joining in the year of 2019.

select count(EID) as 'YEARLY INTAKE',YEAR(DOJ) as 'YEAR' from EMP_SAL
where YEAR(DOJ) = 2019
group by YEAR(DOJ);

--If I need to arrange no. of employees joining every year in the basis of their joining.

select * from EMP_SAL;

select count(EID) as 'NO.OF INTAKES', YEAR(DOJ) as 'YEAR'
from EMP_SAL
group by YEAR(DOJ)
order by count(EID) DESC;


