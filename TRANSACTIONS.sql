
use PRACTICE;

--TRANSACTIONS
			--Its an "unit of work" that is done against a database. If we insert, update/delete
			--something in the table, we are performing a transaction.

--Properties of TRANSACTION :

		--A			C			I			D

		--ATOMICITY,CONSISTENCY,ISOLATION,DURABILITY

--THREE COMMANDS used in transactions :

--COMMIT	-- To save the changes
--ROLLBACK	-- To get back to the beginning ( To roll back to the changes)
--SAVEPOINT -- Creates points within a transaction group which get to be ROLLBACK.


--ROLLBACK :

		--Can be rolled back to the older one
		
--eg:

create table TEMP
(ID VARCHAR(2), NAME VARCHAR(20));

insert into TEMP
values('1', 'ANISH');
insert into TEMP
values('2', 'AKAASH');
insert into TEMP
values('3', 'BALA');
insert into TEMP
values('4', 'BENNY');
insert into TEMP
values('5', 'CHARLIE');
insert into TEMP
values('6', 'DEEBAK');
insert into TEMP
values('7', 'EDGAR');
insert into TEMP
values('8', 'FRANK');
insert into TEMP
values('9', 'GEOS');
insert into TEMP
values('10', 'HARINI');

select * from TEMP;


BEGIN TRANSACTION

	DELETE FROM TEMP WHERE ID = '2';

	select * from TEMP;

	--But when we use ROLLBACK:

	ROLLBACK;

	select * from TEMP;  -- The datas got added back.


--SAVEPOINT :

		-- Here we can make a "group formed" using SAVEPOINT and we can ROLLBACK that group alone.
--Eg:

BEGIN TRANSACTION;

		DELETE FROM TEMP WHERE ID = '2';
		DELETE FROM TEMP WHERE ID = '4';
		SAVE TRANSACTION T1;
		
		DELETE FROM TEMP WHERE ID = '6';
		DELETE FROM TEMP WHERE ID = '8';
		SAVE TRANSACTION T2;

		select * from TEMP; -- Here the mentioned IDs are been deleted. Now, when we give ROLLBACK
							-- with the SAVED TRANSACTION NAME,

		ROLLBACK TRANSACTION T1;
		select * from TEMP;
		ROLLBACK;


--COMMIT :

		-- To save the changes.

--eg :

BEGIN TRANSACTION;

		DELETE FROM TEMP WHERE ID = '2';
		DELETE FROM TEMP WHERE ID = '4';
		COMMIT;

		select * from TEMP;

		ROLLBACK; -- Throws an error, becoz as the transaction is saved, it can't be rolled back.





