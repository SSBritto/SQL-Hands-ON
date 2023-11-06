USE INVENTORY_PRAC;

--Procedures :

--Add some order in the ORDER table and the ODATE should come automatically.

CREATE TABLE PRODUCT_PRAC
(PID CHAR(5), PDESC VARCHAR(20), PRICE INT);

CREATE TABLE STOCK_PRAC
(PID CHAR(5), SQTY INT);

CREATE TABLE ORDERS_PRAC
(OID CHAR(5),CID CHAR(5), PID CHAR(5), OQTY INT,
ODATE DATE);

CREATE PROCEDURE IN_PR_STK @P AS CHAR(5), @PD AS VARCHAR(20), @PR AS INT, @SQ AS INT
AS
BEGIN

		INSERT INTO PRODUCT_PRAC
		VALUES(@P,@PD,@PR);

		SELECT * FROM PRODUCT_PRAC;

		INSERT INTO STOCK_PRAC
		VALUES(@P, @SQ);

		SELECT * FROM STOCK_PRAC;

END;

IN_PR_STK 'P0001', 'DELL KEYBOARD', '500', '50';
IN_PR_STK 'P0002', 'DELL MOUSE', '200', '100';
IN_PR_STK 'P0003', 'HP 27IN MONITOR', '12500', '20';
IN_PR_STK 'P0004', 'ASC 65 VA UPS', '7500', '60';
IN_PR_STK 'P0005', 'DELL 1TB LAPTOP', '500', '50';


--Need to place an order in the table with Procedure and the order date must generate automatically.


SELECT * FROM PRODUCT_PRAC;
SELECT * FROM STOCK_PRAC;
SELECT * FROM ORDERS_PRAC;

CREATE PROCEDURE IN_PR_ORD @O AS CHAR(5), @C AS CHAR(5), @P AS CHAR(5), @OQ AS INT
AS
BEGIN
			DECLARE @OD AS DATE;
			SET @OD =(SELECT GETDATE());

			INSERT INTO ORDERS_PRAC(OID,CID,PID,OQTY,ODATE)
			VALUES (@O,@C,@P,@OQ,@OD);

			SELECT * FROM ORDERS_PRAC;

END;

DROP PROCEDURE IN_PR_ORD;

IN_PR_ORD 'O0001', 'C0001', 'P0001', 10;
IN_PR_ORD 'O0002', 'C0002', 'P0002', 12;
