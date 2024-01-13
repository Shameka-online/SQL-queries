CREATE DATABASE Bakery;

USE Bakery;

CREATE TABLE Sweet (
    id INT NOT NULL,
    item_name VARCHAR(50) NOT NULL,
    price FLOAT(2)
);

CREATE TABLE Savoury (
    id INT NOT NULL,
    item_name VARCHAR(50) NOT NULL,
    price FLOAT(2),
    main_ingredient VARCHAR(50)
);

-- Populate the Sweet table
INSERT INTO Sweet
(id, item_name, price)
VALUES
(1, 'doughnut', 0.50),
(2, 'croissant', 0.75),
(3, 'painauchocolat', 0.55),
(4, 'cinnamon twirl', 0.45),
(5, 'cannoli', 0.88),
(6, 'apple tart', 1.12);

INSERT INTO Savoury
(id, item_name, price, main_ingredient)
VALUES
(1, 'meat pie', 1.25, 'pork'),
(2, 'sausage roll', 1.00, null),
(3, 'pasty', 2.45, 'beef');

-- Use select * statements to check tables

/*displaying all data*/

-- method one: using all column names 
select id, item_name,price from sweet; 

-- method two: wildcard * which means select all
select * from sweet; 
select * from savoury; 
select * from Savouryextra; 

/*select all savoury items that have either pork or beef filling*/
select * from savoury where main_ingredient in ('pork', 'beef');


-- create another table called 'Savouryextra'
CREATE TABLE Savouryextra(
    id INT NOT NULL,
    item_name VARCHAR(50) NOT NULL,
    price FLOAT(2),
    main_ingredient VARCHAR(50)
);

-- Run this to confirm that the table is empty
select * from Savouryextra;

-- This will ensure that the new table is populated with items of the savoury table created before where the value of price column is greater than 1.00 pound
Insert into Savouryextra select * from savoury where price > 1.00;

-- Run this to confirm that the table is now populated 
select * from Savouryextra;

-- This removes all rows or data from a table but leaves the columns, run it
truncate table Savouryextra;

-- Run this to confirm that the table is now empty again
select * from Savouryextra;

-- find sweets for 50p or less
select * from sweet where price < 0.5

-- find all sweet items and price except cannoli

select * from sweet where item_name != 'cannoli';

-- find sweet items starting with c 

select * from sweet where item_name like ('c%');

-- find savoury items that cost more than 1 but less than 3

select * from savoury where price between 1.00 and 3.00;

SHOW TABLES;

-- case practice 

select item_name, (case when price>0.6 then 'True' else 'False' end) as more_than_60p from sweet;

--price comparison 
SELECT ROUND(AVG(price),2) AS average_sweet_price from Sweet;
SELECT ROUND(AVG(price),2) AS average_savoury_price from Savoury;

--sweet with highest price 
select item_name, price from Sweet 
where price = (select max(price) from sweet);

-- savoury with the higest price 
select item_name, price from Savoury 
where price = (select max(price) from Savoury);


-- wildcard practice 

select item_name from sweet where item_name like 'd%';

select item_name from sweet where item_name like 'a%';

select item_name from sweet where item_name like 'd%';

-- character practice
select CHAR_LENGTH(item_name) as sweet_length from sweet;

select CHAR_LENGTH(item_name) as savoury_length from savoury;
-- lower and uppercase
select LCASE(item_name) from Sweet;

select UCASE(item_name) from Savoury;

-- SELECT FIRST 3 CHARACTERS STARTING FROM THE LEFT 
select LEFT(item_name,3) FROM Sweet;

-- SELECT FIRST 5 CHARACTERS STARTING FROM THE RIGHT
SELECT RIGHT(item_name,5) FROM Savoury;

-- selects characters from 2nd char to with 3 following leters

select mid(item_name,2,3) from sweet; 

-- repetition 
select REPEAT(item_name,2) from Savoury;

-- reverse 
select reverse(item_name) from Sweet;

select reverse(item_name) from Savoury;

-- padding

Select RPAD(item_name, 15,'1') from sweet; 

select LPAD(item_name, 15,' 0') from Savoury;


insert into Savoury 
(id, item_name, price, main_ingredient) 
values
(4, 'chicken pie', 3.55, 'chicken');

select * from Savoury;

