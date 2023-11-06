use PRACTICE;

select * from EMP;
select * from EMP_SAL;

--City wise COUNT employees arranged in DESC order

select CITY, COUNT(EID) FROM EMP
GROUP BY CITY
ORDER BY CITY DESC;

-- Details of the employees not having account in YAHOO

select * from EMP;

select EMAIL, COUNT(EID) FROM EMP
GROUP BY EMAIL
HAVING (EMAIL NOT LIKE '%YAHOO%');


-- DESI wise the BASIC and EIDs are arranged in DESC with BASIC

select * from EMP_SAL;

select DESI, SUM(BASIC) AS 'TOTAL SALARY', COUNT(EID) AS 'TOTAL NO.OF EMPLOYEES' from EMP_SAL
GROUP BY DESI
ORDER BY DESI DESC;

