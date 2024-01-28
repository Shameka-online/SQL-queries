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

select * from part;

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
 SELECT 'S5', 'ADAMS',30,'ATHENS' ;

select * from supplier;

-- alternative way to insert into a table 
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
 SELECT 'S5','P6','J4',500;

select * from supply;


select * from part;
SELECT * from supply;
select * from project;
select * from supplier;

-- finds distinct part name from parts 
SELECT distinct pname from part;

/*  selects distict name but name can 
come up a few times if id is different */

select distinct pname, p_id from part; 

-- SHOWS NAME AND WEIGHT OF RED PART 
select distinct pname, weight from part where COLOUR = 'RED';

-- SHOWS DISTINCT PARTS FROM LONDON 
select DISTINCT * from PROJECT where city = 'LONDON';

-- SHOWS DISTINCT PARTS FROM LONDON AND PARIS 
select  * from PROJECT where city in ('LONDON','PARIS');

select * from supplier ;

select distinct sname from supplier where city = 'LONDON';

-- most common supplier 

select s1.s_id, sname, count(s1.s_id) as suppliers_by_use 
from supply s1 
join supplier s2 
on s1.s_id = s2.s_id
group by s1.s_id, sname
order by suppliers_by_use desc;

use parts;
-- most common part 
select s1.p_id, pname, count(s1.p_id) as parts_by_use 
from supply s1
join part p
on s1.p_id = p.p_id
group by s1.p_id, pname
order by parts_by_use desc;



-- largest quantity grouped by p_id
select j_id, s_id, max(quantity) as stock
from supply 
group by p_id, j_id
order by stock DESC;

-- stock checking 
select j_id, p_id, (case when quantity >=500 then 'High' 
				    else 'Low - please order' end) as stock_checker 
from supply;  

-- name and status of each supplier who supplies project j2 
select sname, status  
from supplier s1
inner join supply s2
on s1.s_id = s2.s_id
where j_id ='j2'; 


use parts;


-- subquery
-- 2 missing values as opposed to the join which has the correct number of answers 
-- May be due to the id showing up only once in the supplier table. so join is a better option  
select sname, status
from supplier
where s_id in 
			(select s_id from supply where j_id = 'j2');

-- find the name and city of each project supplied by a london based supplier
-- finds the name and city of the project where the city is in the supplier table and the city is london 
select jname, city 
from project
where city in (select city 
               from supplier 
			   where city = "London");
               
 
-- found from the supply table where the projects, parts and suppliers have been assigned 
-- finds name and city from project table where the j_id is in the supply table with the matching supplier and finds where in the supplier table the supplier is london based

select jname, city 
from project 
where j_id in (select j_id 
from supply s1
join supplier s 
on s1.s_id = s.s_id
where s.city = "London");


               
-- join
select jname, p.city 
from project p
join supplier s
on s.s_id = p.j_id
join supply sup
on sup.j_id =  p.j_id
where s.city = "London" ;

-- find the name and city of each project not supplied by a london based supplier
-- doesnt show oslo or rome because these options arent available in the supplier table 

select jname, city 
from project
where city in (select city 
               from supplier 
			   where city != "London");
               
               
 -- found from the supply table where the projects, parts and suppliers have been assigned together
-- finds name and city from project table where the j_id is in the supply table with the matching supplier and finds where in the supplier table the supplier is london based              
select jname, city 
from project 
where j_id not in (select j_id 
from supply s1
join supplier s 
on s1.s_id = s.s_id
where s.city = "London");

			   

/*find supplier name, part name and project name for each case where a supplier 
supplies a project with a part, but also the supplier city, project city and part
 city are the same*/

-- with a join 
select s1.s_id, sname,s2.city, s1.p_id,pname ,p.city ,s1.j_id, jname, j.city 
from supply s1
join supplier s2 
on s1.s_id = s2.s_id
join part p 
on s1.p_id = p.p_id
join project j 
on s1.j_id = j.j_id
where (s2.city ="London" and p.city ="London" and j.city ="London") or
	  (s2.city ="Athens" and p.city ="Athens" and j.city ="Athens") or
      (s2.city ="Rome" and p.city ="Rome" and j.city ="Rome") or
      (s2.city ="Oslo" and p.city ="Oslo" and j.city ="Oslo") or
      (s2.city ="Paris" and p.city ="Paris" and j.city ="Paris");
      
-- in queries if any of the s_id's are within the values in the subquery does it occur in the sq. checks a range
-- any in querying checks if there are any values that match up to any val occuring in the inner query. does it match at least one of the vals
-- all in querying checks if all of vals from inner query is bigger or smaller than all vals in oq. bettr than all the vals
-- exists is querying the existence of the rows returned from the subquery.true if the sq has rows. false otherwise
-- finding names 

-- maybe use and. where s_id =s_id  and p_id= p_id 
select sname, jname, pname
from supplier s, project j, part p
where s.city = j.city = p.city ;


select sname from supplier where s_id in (select s_id from supply);
select pname from part where p_id in (select p_id from supplier);
select jname from project where j_id in (select j_id from supplier);



select sname as supplier_name, supplier.city , jname as project_name,project.city, pname as part_name, part.city 
from supplier , project, part
where supplier.city = project.city = part.city;


-- first try  where query follows the layout of the supply table
/*Query gets the ids from table it comes from where there is a match 
in each case where it appears */










