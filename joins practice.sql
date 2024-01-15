CREATE DATABASE JOINS_PRACTICE;
USE JOINS_PRACTICE;
-- Create table 1
CREATE TABLE Table1_fruit_basket
(ID INT, Fruit VARCHAR(50));
INSERT INTO Table1_fruit_basket
(ID, Fruit)
VALUES
(1, 'pear'),
(2, 'apple'),
(3, 'kiwi'),
(4, 'orange'),
(5, 'banana');
-- Create table 2
CREATE TABLE Table2_fruit_basket
(ID INT, Fruit VARCHAR(50));
INSERT INTO Table2_fruit_basket
(ID, Fruit)
VALUES
(1, 'pear'),
(2, 'apple'),
(3, 'kiwi'),
(6, 'melon'),
(7, 'peach'),
(8, 'plum');

SELECT *
FROM Table1_fruit_basket;
SELECT *
FROM Table2_fruit_basket;

/* inner join
selects everyting from table 1 and joins the matches in table 2*/
select t1.*, t2.*
from table1_fruit_basket t1
inner join table2_fruit_basket t2 on t1.id = t2.id;

/* inner join
selects everyting from table and joins what applies however using aliases */
select t1.id as t1id, 
t1.fruit as t1fruit, 
 t2.id as t2id,
 t2.fruit as t2fruit
 from table1_fruit_basket t1
 inner join table2_fruit_basket t2
 on t1.id = t2.id;

/* left join */
select t1.*, t2.*
from table1_fruit_basket t1
left join table2_fruit_basket t2 on t1.id = t2.id;

/* joins everything from table 2 with matching rows from
table 1 where the id is null in table 2 */
select t1.*, t2.*
from table1_fruit_basket t1
left join table2_fruit_basket t2 on t1.id = t2.id
where t2.id is null;


/* right join */
select t1.*, t2.*
from table1_fruit_basket t1 
right join table2_fruit_basket t2 on t1.id = t2.id;

/* outer join. 
full outer join not in mysql so use union
and using left join and right join 
null is displayed when there are no pairs*/
SELECT * FROM Table1_fruit_basket t1
LEFT JOIN Table2_fruit_basket t2 ON t1.ID = t2.ID
UNION
SELECT * FROM Table1_fruit_basket t1
RIGHT JOIN Table2_fruit_basket t2 ON t1.id = t2.id;

/*LEFT JOIN - WHERE NULL -
 opposite of left join, this finds non matching rows on 2nd table */
SELECT 
    t1.*, t2.*
FROM
    Table1_fruit_basket t1
        LEFT JOIN
    Table2_fruit_basket t2 ON t1.ID = t2.ID
WHERE
    t2.ID IS NULL;

/* CROSS JOIN joins everything in table */
SELECT t1.*,t2.*
FROM Table1_fruit_basket t1
CROSS JOIN Table2_fruit_basket t2;


/* UNION ALL - has duplicates as it joins everything from both tables */
SELECT t1.ID T1ID, t1.Fruit AS T1Fruit
FROM Table1_fruit_basket t1
UNION ALL
SELECT  t2.ID AS T2ID, t2.Fruit AS T2Fruit
FROM Table2_fruit_basket t2;

/* UNION - has no duplicates*/
SELECT t1.ID AS T1ID, t1.Fruit AS T1Fruit
FROM Table1_fruit_basket t1
UNION
SELECT  t2.ID AS T2ID, t2.Fruit AS T2Fruit
FROM Table2_fruit_basket t2;
