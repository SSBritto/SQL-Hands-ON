CREATE DATABASE INVENTORY_PRAC_TR;

USE INVENTORY_PRAC_TR;

CREATE TABLE PRODUCT (PID CHAR(5), PDESC VARCHAR(50), PRICE INT);
CREATE TABLE STOCK (PID CHAR(5), SQTY INT);
CREATE TABLE ORDERS (OID CHAR(5), CID CHAR(5), PID CHAR(5), OQTY INT);

SELECT * FROM PRODUCT;
SELECT * FROM STOCK;
SELECT * FROM ORDERS;

INSERT INTO PRODUCT VALUES('P0001', 'DELL MOUSE', 250);

INSERT INTO PRODUCT VALUES('P0002', 'DELL KEYBOARD', 750);

INSERT INTO PRODUCT VALUES('P0003', 'APC 650 VA UPS', 2750);

INSERT INTO PRODUCT VALUES('P0004', 'DELL I7 256 GB SSD 1TB HDD LAPTOP', 85000);

INSERT INTO PRODUCT VALUES('P0005', 'HP 24IN 4K MONITOR', 7000);

SELECT * FROM PRODUCT;

INSERT INTO STOCK VALUES('P0001', 500);

INSERT INTO STOCK VALUES('P0002', 200);

INSERT INTO STOCK VALUES('P0003', 300);

INSERT INTO STOCK VALUES('P0004', 150);

INSERT INTO STOCK VALUES('P0005', 100);

SELECT * FROM PRODUCT;
SELECT * FROM STOCK;
SELECT * FROM ORDERS;

--Now we create a TRIGGER for when an order is placed, the stock must change,

--INSERT TRIGGER :

CREATE TRIGGER TR_IN_ORD ON ORDERS
FOR INSERT
AS
BEGIN

		UPDATE STOCK SET SQTY = SQTY - (SELECT OQTY FROM INSERTED)
		WHERE PID = (SELECT PID FROM INSERTED)

END;

INSERT INTO ORDERS VALUES('O0001', 'C0001', 'P0001', 100);

SELECT * FROM ORDERS;
SELECT * FROM STOCK;

--Now if an customer ask for 150 and not for 100 means,

--UPDATE TRIGGER :

CREATE TRIGGER TR_UP_ORD ON ORDERS
FOR UPDATE
AS
BEGIN

			DECLARE @OQ AS INT;
			DECLARE @NQ AS INT;

			SET @OQ = (SELECT OQTY FROM DELETED);
			SET @NQ = (SELECT OQTY FROM INSERTED);

			UPDATE STOCK SET SQTY = SQTY + @OQ - @NQ
			WHERE PID = (SELECT PID FROM INSERTED);

END;

DROP TRIGGER TR_UP_ORD;

UPDATE ORDERS SET OQTY = 150
WHERE OID = 'O0001';

UPDATE ORDERS SET OQTY = 200
WHERE OID = 'O0001';

SELECT * FROM ORDERS;
SELECT * FROM STOCK;

--If need to delete any product from Product Table, it must get deleted from Stock Table also.

--DELETE TRIGGER :

CREATE TRIGGER TR_DEL_PR ON PRODUCT
FOR DELETE
AS
BEGIN

		DELETE FROM STOCK
		WHERE PID = (SELECT PID FROM DELETED);

END;

DROP TRIGGER TR_DEL_PR;

DELETE FROM PRODUCT
WHERE PID = 'P0005';

SELECT * FROM PRODUCT;
SELECT * FROM STOCK;


--Now in a scenario, we have a Stock for only "30" item, but the customer asks for "40".
--Its not possible, if we place the order in blank, the stock will show in negative.
--This must not happen. Unless the order should be rejected.

--At this point, we must "check the availablity of the stock"

--Here INSERT trigger is used. But already there is an INSERT trigger. We can't have more than one
--TRIGGER in a table (either INSERT/DELETE/UPDATE). So we must delete the old TRIGGER and create
-- a new one.

DROP TRIGGER TR_IN_ORD;

CREATE TRIGGER TR_IN_ORD ON ORDERS
FOR INSERT
AS
BEGIN

			DECLARE @QR AS INT;
			DECLARE @QS AS INT;

			SET @QR = (SELECT OQTY FROM INSERTED);
			SET @QS = (SELECT SQTY FROM STOCK WHERE PID = (SELECT PID FROM INSERTED));

			IF @QS>=@QR
			BEGIN
			UPDATE STOCK SET SQTY = SQTY -@QR
			WHERE PID = (SELECT PID FROM INSERTED);
			COMMIT;
			PRINT('ORDER ACCEPTED');
			END;
			ELSE
				BEGIN
					ROLLBACK;
					PRINT('ORDER REJECTED -INSUFFICIENT BALANCE');
				END;
END;

INSERT INTO ORDERS VALUES('O0002', 'C0002', 'P0002', 100);
SELECT * FROM ORDERS;
SELECT * FROM STOCK;				--Order is placed with the message gn to be printed


INSERT INTO ORDERS VALUES('O0003', 'C0003', 'P0002', 150);
SELECT * FROM ORDERS;
SELECT * FROM STOCK;			--Order not placed with the message gn to be printed


--If the customer 'C0002' again order for  200 instead of 100 means, we must update the tables. 
--As already there is a table created with the UPDATE TRIGGER, this happens successfully.(Here the 
--balance is available, so it didn't show negative)

UPDATE ORDERS SET OQTY = 200
WHERE PID ='P0002';

--Now again if we order for 250 instead of 200,it shows in negative,
--This is becoz we had created the Orders to be placed and rejected only for the INSERT TRIGGER
--we must create an UPDATE TRIGGER which won't accept the orders and reject the orders.

UPDATE ORDERS SET OQTY = 200
WHERE PID ='P0002';

SELECT * FROM ORDERS;
SELECT * FROM STOCk;

DROP TRIGGER TR_UP_ORD;

CREATE TRIGGER TR_UP_ORD ON ORDERS
FOR UPDATE
AS
BEGIN

			DECLARE @QR AS INT;
			DECLARE @QS AS INT;

			SET @QR = (SELECT OQTY FROM INSERTED);
			SET @QS = (SELECT SQTY FROM STOCK WHERE PID = (SELECT PID FROM INSERTED));

			IF @QS>=@QR
			BEGIN
				UPDATE STOCK SET SQTY = SQTY - @QR
				WHERE PID = (SELECT PID FROM INSERTED);
				COMMIT;
				PRINT('ORDER ACCEPTED');
			END;

				ELSE
					BEGIN
						ROLLBACK;
						PRINT('ORDER REJECTED - INSUFFICIENT BALANCE');
					END;
END;

DROP TRIGGER TR_UP_ORD;


SELECT * FROM STOCk;
SELECT * FROM ORDERS;

UPDATE ORDERS SET OQTY = 250
WHERE OID = 'O0002';