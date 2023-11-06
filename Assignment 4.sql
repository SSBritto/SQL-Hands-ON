use DEMO;

create table EMP
(EID CHAR(4), NAME VARCHAR(30), CITY VARCHAR(10), DOJ DATE, DEPT VARCHAR(20),
DESI VARCHAR(20), SALARY INT);

alter table EMP
add constraint DF DEFAULT 'DELHI' FOR CITY;

insert into EMP
values('E001','AANAND','MUMBAI','01 FEBRUARY 1996','IT','ASSOCIATE','34000');
insert into EMP
values('E002','AAJITH SHARMA','GURGOAN','05 FEBRUARY 1997','IT','HR','46000');
insert into EMP(EID,NAME,DOJ,DEPT,DESI,SALARY)
values('E003','BOBBY','10 MARCH 1996','MIS','MANAGER','50000');
insert into EMP
values('E004','BUSAN','NOIDA','01 MAY 1995','IT','ASSISTANT','40000');
insert into EMP(EID,NAME,DOJ,DEPT,DESI,SALARY)
values('E005','CHARLIE','10 APRIL 1995','OPS','TRAINEE','55000');
insert into EMP
values('E006','DANIEL BALAJI','MUMBAI','21 JANUARY 1996','IT','ASSOCIATE','34000');
insert into EMP
values('E007','ELLIE','GURGOAN','22 AUGUST 1998','HR','MANAGER','65000');
insert into EMP
values('E008','FRANKLIN JOSEPH','MUMBAI','25 JULY 1996','MIS','ENGINEER','36000');
insert into EMP
values('E009','GEO','NOIDA','18 JUNE 1997','OPS','ASSOCIATE','52000');
insert into EMP
values('E010','HAROLD','NOIDA','27 FEBRUARY 1996','OPS','TRAINEE','34000');

select * from EMP;

select * from EMP
where CITY = 'DELHI';


--INVENTORY MANAGEMENT SYSTEM


create database INVENTORY;
use INVENTORY;

--Supplier table & Constraints applied

create table Supplier
(SID CHAR(5), NAME VARCHAR(30), ADDR VARCHAR(50), 
CITY VARCHAR(20), PHONE CHAR(10), EMAIL VARCHAR(50));

alter table Supplier
alter column NAME VARCHAR(30) NOT NULL;

alter table supplier
alter column ADDR VARCHAR(50) NOT NULL;

alter table supplier
add constraint DF1 DEFAULT 'DELHI' FOR CITY;

alter table supplier
add constraint UQ1 UNIQUE(PHONE);

--Product table & Constraints applied

create table Product
(PID CHAR(5), PDESC VARCHAR(100), PRICE INT, CATEGORY VARCHAR(50), 
SID CHAR(5));

alter table Product
alter column PDESC VARCHAR(100) NOT NULL;

alter table Product
add constraint CHK1 CHECK (PRICE > 0);

alter table Product
add constraint CHK2 CHECK (CATEGORY IN ('IT', 'HA', 'HC'));

--Stock table & Constraints Applied

create table Stock
(PID CHAR(5), SQTY INT, ROL INT, MOQ INT);

alter table Stock
add constraint CHKS CHECK (SQTY >= 0);

alter table Stock
drop constraint CHKS;

alter table Stock
add constraint CHKR CHECK (ROL >= 0);

alter table Stock
drop constraint CHKR;

alter table Stock
add constraint CHKM CHECK (MOQ >= 5);

--Customer Table & Constraints applied

create table Customer
(CID CHAR(5), CNAME VARCHAR(30), CADDR VARCHAR(50), CCITY VARCHAR(20),
CPHONE CHAR(10), CEMAIL VARCHAR(50), CDOB DATE);


alter table Customer
alter column CNAME VARCHAR(30) NOT NULL;

alter table Customer
alter column CADDR VARCHAR(50) NOT NULL;

alter table Customer
alter column CCITY VARCHAR(20) NOT NULL;

alter table Customer
alter column CPHONE CHAR(10) NOT NULL;

alter table Customer
alter column CEMAIL VARCHAR(50) NOT NULL;

--Orders table & Constraints applied

create table Orders
(OID CHAR(5), ODATE DATE, PID CHAR(5), CID CHAR(5), OQTY INT);

alter table Orders
add constraint CHKO CHECK (OQTY >=1);



insert into Supplier
values('S0001','AARON JOSEPH','24TH AVENUE','GURGOAN','9978654320','AARONJOSEPH@GMAIL.COM');
insert into Supplier
values('S0002','BAADSHAH','1ST CROSS ST','GURGOAN','9098767780','BAADSHAH@GMAIL.COM');
insert into Supplier
values('S0003','CHARLIE','22/A STREET','NOIDA','9980007650','CHARLIE098@GMAIL.COM');
insert into Supplier(SID,NAME,ADDR,PHONE,EMAIL)
values('S0004','DANIEL RADCLIFF','165TH AVENUE','9988980070','DANIELRADCLIFF@GMAIL.COM');
insert into Supplier
values('S0005','DALLUS','REGAN STREET','NOIDA','8765432990','DALLUS@GMAIL.COM');

select * from Supplier;


insert into Product
values('P0001', 'DELL KEYBOARD', '250', 'IT', 'S0001');
insert into Product
values('P0002', 'DELL MOUSE', '100', 'IT', 'S0001');
insert into Product
values('P0003', 'PRESTIGE COOKER 5L', '12000', 'HA', 'S0002');
insert into Product
values('P0004', 'BUTTERFLY STOVE 3 BURNER', '25000', 'HA', 'S0002');
insert into Product
values('P0005', 'HP LAPTOP 16INCH 8GB RAM', '40000', 'IT', 'S0001');
insert into Product
values('P0006', 'HP 21INCH MONITOR', '11000', 'IT', 'S0001');
insert into Product
values('P0007', 'PRESTIGE INDUCTION STOVE', '25000', 'HA', 'S0003');
insert into Product
values('P0008', 'PIRITON 250ML', '420', 'HC', 'S0004');
insert into Product
values('P0009', 'AXEOIL', '135', 'HC', 'S0005');
insert into Product
values('P0010', 'PANTOPREZOL TABLETS', '250', 'HC', 'S0005');
insert into Product
values('P0011', 'MICROWAVE OVEN', '32000', 'HA', 'S0003');
insert into Product
values('P0012', 'RABEPREZOL TABLETS', '250', 'HC', 'S0005');

select * from Supplier;
select * from Product;

alter table Supplier
add constraint PK PRIMARY KEY(SID);

alter table Supplier
alter column SID CHAR(5) NOT NULL;

alter table Product
alter column PID CHAR(5) NOT NULL;

alter table Product
add constraint PK2 PRIMARY KEY(PID);

alter table Customer
alter column CID CHAR(5) NOT NULL;

alter table Customer
add constraint PK3 PRIMARY KEY(CID);

alter table Orders
alter column OID CHAR(5) NOT NULL;

alter table Orders
add constraint PK4 PRIMARY KEY(OID);

alter table Product
add constraint FK FOREIGN KEY (SID) REFERENCES Supplier(SID);

alter table Stock
add constraint FK1 FOREIGN KEY (PID) REFERENCES Product(PID);

alter table Orders
add constraint FK2 FOREIGN KEY (CID) REFERENCES Customer (CID);

alter table Orders
add constraint FK3 FOREIGN KEY (PID) REFERENCES Product (PID);


insert into Stock
values('P0001', '25', '10', '50');
insert into Stock
values('P0002', '15', '10', '50');
insert into Stock
values('P0003', '15', '10', '30');
insert into Stock
values('P0004', '5', '15', '50');
insert into Stock
values('P0005', '12', '10', '30');
insert into Stock
values('P0006', '20', '10', '75');
insert into Stock
values('P0007', '12', '10', '50');
insert into Stock
values('P0008', '10', '5', '25');
insert into Stock
values('P0009', '25', '30', '100');
insert into Stock
values('P0010', '22', '15', '50');

select * from Supplier;
select * from Product;
select * from Stock;

insert into Customer
values('C0001', 'AAKASH', '44TH STREET', 'DELHI', '7890221890','AAKASH@GMAIL.COM', '01 MARCH 1987');
insert into Customer
values('C0002', 'BENISH', '44TH CROSS STREET', 'NOIDA', '9908978670','BEN@GMAIL.COM', '06 MARCH 1987');
insert into Customer
values('C0003', 'CLARETT', '21 STRAIGHT RD', 'MUMBAI', '9908988900','CLARETT@GMAIL.COM', '10 JUNE 1990');
insert into Customer
values('C0004', 'DEEBAK', '88 AVENUE STREET', 'DELHI', '9090899010','DEEBAK@GMAIL.COM', '12 APRIL 2000');
insert into Customer
values('C0005', 'HELEN', 'PARK AVENUE', 'NOIDA', '7790890090','HELEN@GMAIL.COM', '15 AUGUST 1996');


update Customer set CEMAIL = 'AAKASH@GMAIL.COM'
where CID = 'C0001';

select * from Supplier;
select * from Product;
select * from Stock;
select * from Customer;

insert into Orders
values('O0001', '09 MARCH 2019', 'P0002', 'C0001', '3');
insert into Orders
values('O0002', '12 JUNE 2019', 'P0001', 'C0002', '7');
insert into Orders
values('O0003', '09 JULY 2019', 'P0004', 'C0003', '1');
insert into Orders
values('O0004', '15 AUGUST 2019', 'P0005', 'C0004', '2');
insert into Orders
values('O0005', '02 NOVEMBER 2019', 'P0003', 'C0002', '1');
insert into Orders
values('O0006', '11 JANUARY 2020', 'P0002', 'C0005', '3');

select * from Supplier;
select * from Product;
select * from Stock;
select * from Customer;
select * from Orders;

--Two tables join -- Supplier & Product tables
select * from Supplier;
select * from Product;

select Product.PID,PDESC,CATEGORY,NAME,CITY FROM Product
RIGHT JOIN Supplier 
ON Product.SID = Supplier.SID;

--Three tables Join -- 

select * from Orders;
select * from Customer;
select * from Product;

select Orders.OID, ODATE,OQTY, CNAME,CADDR,CPHONE from Orders
LEFT JOIN Customer
on Orders.CID = Customer.CID;


select * from Orders;
select * from Customer;
select * from Product;


select Orders.OID, ODATE,OQTY, CNAME,CADDR,CPHONE from Orders
LEFT JOIN Customer
on Orders.CID = Customer.CID

select Product.PDESC, PRICE, PRICE*OQTY as 'AMNT' from Product
LEFT JOIN Orders
on Product.PID = Orders.PID;



