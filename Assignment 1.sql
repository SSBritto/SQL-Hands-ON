create database DEMO;
use DEMO;


--CREATE TABLE AND ADD COLUMN :

create table EMP_SAL
(EID CHAR(5), DEPT VARCHAR(15), DESI VARCHAR(20), DOJ DATE, SALARY INT);
insert into EMP_SAL
values('E0001', 'IT', 'ASSOCIATE', '10 January 2007', '36000');
insert into EMP_SAL
values('E0002', 'MIS', 'SR.ENGINEER', '16 January 2008', '45000');
insert into EMP_SAL
values('E0003', 'HR', 'MANAGER', '10 May 2010', '55000');
insert into EMP_SAL
values('E0004', 'OPS', 'OPERATION HEAD', '21 June 2005', '50000');
insert into EMP_SAL
values('E0005', 'IT', 'ASSOCIATE', '10 November 2007', '36000');
insert into EMP_SAL
values('E0006', 'MECH', 'TRAINEE', '08 March 2006', '24500');
insert into EMP_SAL
values('E0007', 'CIVIL', 'TRAINEE', '14 August 2009', '25000');

select * from EMP_SAL;

alter table EMP_SAL
add NAME VARCHAR(30);

select * from EMP_SAL;

update EMP_SAL set NAME = 'ROHIT SHARMA'
where EID = 'E0001';
update EMP_SAL set NAME = 'MISHAL SHARMA'
where EID = 'E0002';
update EMP_SAL set NAME = 'RANJITH KUMAR'
where EID = 'E0003';
update EMP_SAL set NAME = 'PRATAP VARMA'
where EID = 'E0004';
update EMP_SAL set NAME = 'KUSHAL'
where EID = 'E0005';
update EMP_SAL set NAME = 'LOHITH'
where EID = 'E0006';
update EMP_SAL set NAME = 'BOBBY SHARMA'
where EID = 'E0007';

select * from EMP_SAL;

--FILTER OUT THE NAMES HAVING "SHARMA" :

select * from EMP_SAL
where NAME LIKE '%SHARMA%';

--INCREASE THE SALARY BY 10% :

update EMP_SAL set salary = salary + salary*0.1
where desi = 'MANAGER';

select * from EMP_SAL;