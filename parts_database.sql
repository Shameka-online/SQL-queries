CREATE DATABASE Parts;

 USE Parts;
 SHOW TABLES;

 CREATE TABLE SUPPLIER (
 	S_ID VARCHAR(2),
 	SNAME VARCHAR(10),
 	STATUS INT,
 	CITY VARCHAR(10)
 );

CREATE TABLE PART
 (
 P_ID CHAR(2),
 PNAME CHAR(10),
 COLOUR CHAR(10),
 WEIGHT INT,
CITY CHAR(10)
 );


 CREATE TABLE PROJECT
 (
 J_ID CHAR(2),
 JNAME CHAR(10),
 CITY CHAR(10)
 );

 CREATE TABLE SUPPLY
 (
S_ID CHAR(2),
 P_ID CHAR(2),
 J_ID CHAR(2),
 QUANTITY INT
 );

 INSERT INTO PROJECT 
 (J_ID,JNAME, CITY)
 VALUES 
 ('J1', 'SORTER', 'PARIS'),
 ('J2', 'DISPLAY', 'ROME'),
 ('J3', 'OCR', 'ATHENS'),
 ('J4', 'CONSOLE', 'ATHENS'),
 ('J5', 'RAID', 'LONDON'),
 ('J6', 'EDS', 'OSLO'),
 ('J7', 'TAPE', 'LONDON');

 select * from project;

 INSERT INTO PART 
 (P_ID,PNAME, COLOUR, WEIGHT, CITY)
 VALUES 
 ('P1', 'NUT', 'RED', 12, 'LONDON'),
 ('P2', 'BOLT', 'GREEN', 17, 'PARIS'),
 ('P3', 'SCREW', 'BLUE', 17, 'ROME'),
 ('P4', 'SCREW', 'RED', 14, 'LONDON'),
 ('P5', 'CAM', 'BLUE', 12, 'PARIS'),
 ('P6', 'COG', 'RED', 19, 'LONDON');

-- Slightly different way of inserting values into a DB

INSERT INTO SUPPLIER (S_ID,SNAME,STATUS,CITY)
 SELECT 'S1','SMITH',20,'LONDON'
 UNION ALL
 SELECT 'S2','JONES',10,'PARIS'
 UNION ALL
 SELECT 'S3','BLAKE',30,'PARIS'
 UNION ALL
 SELECT 'S4','CLARK',20,'LONDON'
 UNION ALL
 SELECT 'S5', 'ADAMS',30,'ATHENS' 

 select * from supplier;

--alternative way to insert into a table 
 INSERT INTO SUPPLY
 SELECT 'S1','P1','J1',200
 UNION ALL
 SELECT 'S1','P1','J4',700
 UNION ALL
 SELECT 'S2','P3','J1',400
 UNION ALL
 SELECT 'S2','P3','J2',200
 UNION ALL
 SELECT 'S2','P3','J3',200
 UNION ALL
 SELECT 'S2','P3','J4',500
 UNION ALL
 SELECT 'S2','P3','J5',600
 UNION ALL
 SELECT 'S2','P3','J6',400
 UNION ALL
 SELECT 'S2','P3','J7',800
 UNION ALL
 SELECT 'S2','P5','J2',100
 UNION ALL
 SELECT 'S3','P3','J1',200
 UNION ALL
 SELECT 'S3','P4','J2',500
 UNION ALL
 SELECT 'S4','P6','J3',300
 UNION ALL
 SELECT 'S4','P6','J7',300
 UNION ALL
 SELECT 'S5','P2','J2',200
 UNION ALL
 SELECT 'S5','P2','J4',100
 UNION ALL
 SELECT 'S5','P5','J5',500
 UNION ALL
 SELECT 'S5','P5','J7',100
 UNION ALL
 SELECT 'S5','P6','J2',200
 UNION ALL
 SELECT 'S5','P1','J4',100
 UNION ALL
 SELECT 'S5','P3','J4',200
 UNION ALL
 SELECT 'S5','P4','J4',800
 UNION ALL
 SELECT 'S5','P5','J4',400
 UNION ALL
 SELECT 'S5','P6','J4',500

 select * from supply;


select * from part;
SELECT * from supply;
select * from project;
select * from supplier;

--finds distinct part name from parts 
SELECT distinct pname from part;

/*  selects distict name but name can 
come up a few times if id is different */
select distinct pname, p_id from part; 

-- SHOWS NAME AND WEIGHT OF RED PART 
select distinct pname, weight from part where COLOUR = 'RED';

--SHOWS DISTINCT PARTS FROM LONDON 
select DISTINCT * from PROJECT where city = 'LONDON';

--SHOWS DISTINCT PARTS FROM LONDON AND PARIS 
select  * from PROJECT where city in ('LONDON','PARIS');

select * from supplier ;

select distinct sname from supplier where city = 'LONDON';

--largest quantity grouped by p_id
select j_id, p_id, max(quantity) as stock
from supply 
group by p_id, j_id
order by stock DESC

-- stock checking 
select j_id, p_id, (case when quantity >=500 then 'High' else 'Low - please order' end) as stock_checker 
from supply; 



