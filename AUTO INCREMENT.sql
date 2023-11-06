

-- AUTO INCREMENT  FIELD:

-- This is used to have an automatic increment of the ID columns in the table.

		-- Its created by giving the IDENTITY() in the specific column with 
		--start & increment values inside the parenthesis.


use PRACTICE;

create table EMP_3
(EID INT IDENTITY(1,1), NAME VARCHAR(20), AGE INT);

insert into EMP_3
values('ABDUL','25');  

insert into EMP_3
values('AJAY','22');
insert into EMP_3
values('BALA','23');
insert into EMP_3
values('CLARETT','24');
insert into EMP_3
values('DANIEL','25');
insert into EMP_3
values('HARINI','24');
insert into EMP_3
values('JACK','23');
insert into EMP_3
values('KALAM','25');
insert into EMP_3
values('MADHU','23');
insert into EMP_3
values('SHALIN','25');


select * from EMP_3;


create procedure INID @N as VARCHAR(30), @A as INT
as
BEGIN

		insert into EMP_3
		values(@N,@A);

END;

INID 'OLIVIA', '24';
select * from EMP_3;
INID 'PETER PAN','23';
select * from EMP_3;


delete from EMP_3
where EID = '7';
select * from EMP_3;

--Now, Inserting a recrd,

INID 'RATAN TATA', '60';

select * from EMP_3;

drop procedure INID;

create procedure INID @N as VARCHAR(30), @A as INT
as
BEGIN
		insert into EMP_3
		values(@N,@A);


END;

INID 'SHALIN BRITTO', '25';

select * from EMP_3;


