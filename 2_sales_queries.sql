create table sales_transactions(
ordernumber int,
quantityordered int, 
priceeach numeric,
orderlinenumber int, 
sales numeric, 
orderdate text,
status varchar(50),
qtr_id int,
month_id int,
year_id int,
productline varchar(50),
msrp numeric,
productcode varchar(50),
customername varchar(150),
phone varchar(50),
addressline1 varchar(200),
addressline2 varchar(200),
city varchar(100),
state varchar(100),
postalcode varchar(50),
country varchar(100),
territory varchar(100),
contactlastname varchar(100),
contactfirstname varchar(100),
dealsize varchar(50)
);

--1. Total Revenue
select round(sum(sales), 2) as total_revenue
from sales_transactions;

--2. Revenue by product line
select productline, round(sum(sales), 2) as revenue
from sales_transactions
group by productline
order by revenue desc;

--3. Revenue by country
select country, round(sum(sales),2) as revenue
from sales_transactions
group by country
order by revenue desc;

--4. Monthly revenue trend 
select year_id,
month_id , round(sum(sales),2) as monthly_revenue
from sales_transactions
group by year_id, month_id
order by year_id, month_id;

--5. Top products by revenue 
select productcode, round(sum(sales),2) as revenue,
rank() over (order by sum(sales) desc)
as revenue_rank
from sales_transactions
group by productcode
order by revenue desc
limit 10;

--6. Revenue by deal size
select dealsize , round(sum(sales),2) as revenue,
round(100.0* sum(sales)/(select sum(sales) from sales_transactions),2)
as revenue_percentage
from sales_transactions
group by dealsize
order by revenue desc;

--7. Status of orders
select status,
round(sum(sales),2) as revenue,
count(*) as transaction_count
from sales_transactions
group by status
order by revenue desc;

--8. Average order value
select round(sum(sales)/ count(distinct ordernumber),2) as avg_ord_value
from sales_transactions;

--9. Best performance by territory
SELECT territory,
       ROUND(SUM(sales),2) AS revenue
FROM sales_transactions
GROUP BY territory
ORDER BY revenue DESC;
































