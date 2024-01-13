create database Shop; 
use shop; 

CREATE TABLE sales1(
store VARCHAR(10),
week int,
day VARCHAR(9),
SalesPerson VARCHAR(7),
SalesAmount DECIMAL(4, 2),
month VARCHAR(3)
);


-- week number indicating the week of the year beginning january 

insert into sales1
(store, week, day, SalesPerson,SalesAmount, month)
VALUES
('London','2','Monday','Frank','56.25','May'),
('London','5','Tuesday','Frank','74.32','Sep'),
('London','5','Monday','Bill','98.42','Sep'),
('London','5','Saturday','Bill','73.90','Dec'),
('London','1','Tuesday','Josie','44.27','Sep'),
('Dusseldorf','4','Monday','Manfred','77.00','Jul'),
('Dusseldorf','3','Tuesday','Inga','9.99','Jun'),
('Dusseldorf','4','Wednesday','Manfred','86.81','Jul'),
('London','6','Friday','Josie','74.02','Oct'),
('Dusseldorf','1','Saturday','Manfred','43.11','Apr');

/*  find all sales records that took place in the London store, not in dec,
 but sales done by bill or frank, and more than 50 in currency */
SELECT 
    *
FROM
    sales1
WHERE
    store = 'London' AND month <> 'Dec'
        AND salesperson = 'bill' or salesperson = 'frank' 
        and salesamount > 50;
        

-- finds everything from sales in london, not in dec, by bill/frank and >50
SELECT 
    *
FROM
    sales1
WHERE
    store = 'London' AND month != 'Dec'
        AND salesperson in ('bill','frank')
        and salesamount > 50;


-- sales each week
SELECT 
    COUNT(salesamount) as sales_per_week, week
FROM
    sales1
GROUP BY week;
-- sales each week desc
select WEEK, count(salesamount)as sales_per_week 
from sales1
group by week
order by week desc;

-- sales each week asc
select WEEK, count(*)
from sales1 
group by week order by week asc;

-- how many sales were recorded each week on different days of the week 
select  day,week, count(salesamount)
from sales1
group by day, week
order by week;

-- change name from inga to annete


SET SQL_SAFE_UPDATES = 0;
UPDATE sales1 
SET 
    salesperson = 'Annete'
WHERE
    salesperson = 'Inga';

select * from sales1;
 -- how many sales did annete do
 select salesperson, count(salesamount)
 from sales1
 where salesperson = 'Annete';
 -- total sales amount by each person per day 
 select sum(salesamount), day, salesperson
 from sales1
 group by day, salesperson; 
 -- how much people sold for a given period
 select salesperson sum(salesamount) 
 from sales1 group by salesperson
 order by salesamount desc; 
-- How much (sum) each person sold for the given period
select salesperson, sum(salesamount) from sales1
group by salesperson; 

/*How much (sum) each person sold for the given period, including the number of sales per
person, their average, lowest and highest sale amounts*/

select s.salesperson, sum(s.salesamount) as total, count(s.salesamount) as amout_of_sales, 
avg(s.salesamount) as  avg_sale_per_person, min(salesamount) as min_amount_made, max(salesamount)
from sales1 as max_amount_mades
group by s.salesperson; 

-- Find the total monetary sales amount achieved by each store
select store, sum(salesamount) as store_total
from sales1 s
group by store; 


/*  Find the number of sales by each person 
if they did less than 3 sales for the past period
used having because cant use where with an aggregate  */
select salesperson, count(salesamount) as SalesPerPerson
from sales1 
group by salesperson
having salesperperson < 3 ;


/*Find the total amount of sales by month 
where combined total is less than £100*/
select sum(salesamount) as totalsales, month
from sales1
group by month
having totalsales < 100  ;


/*. in mysql groupconcat is same as listagg which is used in oracle*/
SELECT GROUP_CONCAT(Store ORDER BY Store SEPARATOR ',') AS Stores FROM  sales1 ;

SELECT  GROUP_CONCAT(distinct Store ORDER BY Store SEPARATOR ',') AS Stores FROM   sales1 ;




