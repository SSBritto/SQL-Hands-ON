use PRACTICE;

create table EMP
(EID CHAR(5), NAME VARCHAR(30), ADDR VARCHAR(50), CITY VARCHAR(20),
PHONE CHAR(10), EMAIL VARCHAR(50), DOB DATE);

--ADDING CONSTRAINTS TO THE FIELDS :

alter table EMP
add constraint PK2ID PRIMARY KEY (EID);

alter table EMP
alter column EID CHAR(5) NOT NULL;

alter table EMP
alter column NAME VARCHAR(30) NOT NULL;

alter table EMP
add constraint CHK2 CHECK (ADDR NOT LIKE 'UTTAM NAGAR');

alter table EMP
add constraint CHK3 CHECK (CITY IN ('DELHI', 'BANGALORE', 'NOIDA', 'MUMBAI'));

alter table EMP
add constraint UQ2 UNIQUE (PHONE);

alter table EMP
add constraint CHKE CHECK (EMAIL LIKE '%GMAIL%');

alter table EMP
add constraint CHECKD CHECK (DOB <='01 January 2000');

insert into EMP
values('E0001', 'ANISH BABU', '2ND CROSS ST', 'BANGALORE', '9987685620', 
'ANISH@GMAIL.COM', '09 APRIL 1998');
insert into EMP
values('E0002', 'AJAY KRISH', 'OPP TO HOLIDAY INN', 'BANGALORE', '9879006690', 
'AJAYKRISH@GMAIL.COM', '21 JANUARY 1995');
insert into EMP
values('E0003', 'BALADHANEESH', 'EIFFEL ROAD', 'NOIDA', '9988765430', 
'BALAD@GMAIL.COM', '09 MAY 1997');
insert into EMP
values('E0004', 'CHANDHRU', '1ST PEOPLE RD', 'DELHI', '7889067440', 
'CHANDHRU@GMAIL.COM', '21 JULY 1998');
insert into EMP
values('E0005', 'DANIEL', 'TELEPORT ST', 'MUMBAI', '9789216625', 
'DANIEL@GMAIL.COM', '15 AUGUST 1999');

select * from EMP;


create table EMP_SAL
(EID CHAR(5), DEPT VARCHAR(10), DESI VARCHAR(30), BASIC INT, DOJ DATE);

alter table EMP_SAL
add constraint FK2ID FOREIGN KEY (EID) REFERENCES EMP(EID);

alter table EMP_SAL
add constraint CHKDEPT CHECK (DEPT IN ('HR', 'MIS', 'OPS', 'IT', 'ADMIN', 'TEMP'));

alter table EMP_SAL
add constraint DEF3 DEFAULT 'TEMP' FOR DEPT;

alter table EMP_SAL
add constraint CHKDESI CHECK (DESI IN ('ASSO', 'MNGR', 'VP', 'DIR'));

alter table EMP_SAL
add constraint CHKSAL CHECK (BASIC >='20000');

insert into EMP_SAL(EID,DEPT,DESI,BASIC)
values('E0001', 'HR', 'ASSO', '23000');
insert into EMP_SAL(EID,DEPT,DESI,BASIC)
values('E0002', 'MIS', 'ASSO', '24000');
insert into EMP_SAL(EID,DEPT,DESI,BASIC)
values('E0003', 'OPS', 'MNGR', '75000');
insert into EMP_SAL(EID,DEPT,DESI,BASIC)
values('E0004', 'ADMIN', 'DIR', '88000');
insert into EMP_SAL(EID,DEPT,DESI,BASIC)
values('E0005', 'TEMP', 'VP', '90000');


select * from EMP;
select * from EMP_SAL;

alter table EMP_SAL
drop constraint CHKDEPT;

select * from EMP;
select * from EMP_SAL;