-- 1. Unique customerID
select count(distinct customerid) from ecommerce_data;

--2. Unique invoice no.
select count(distinct invoiceno) from ecommerce_data;

--3. Total revenue
select sum(Quantity * UnitPrice) as total_revenue 
from ecommerce_data;

--4. Top customer
select customerid,
sum(quantity * unitprice) as revenue
from ecommerce_data
where quantity > 0 and unitprice > 0
group by customerid
order by revenue desc
limit 1;

--5. Top selling product
select description,
sum(quantity) as total_sold
from ecommerce_data
where quantity > 0
group by description
order by total_sold desc
limit 1;

-- 6. Country with highest sales
select country,
sum(quantity * unitprice) as revenue
from ecommerce_data
where quantity > 0 and unitprice > 0
group by country
order by revenue desc
limit 1;

-- 7. Monthly sales trend 
select
date_trunc('month', invoicedate) as month,
sum(quantity * unitprice) as revenue
from ecommerce_data
where quantity > 0 and unitprice > 0
group by month
order by month;

--8. Average order value
select 
avg(order_total) from
(
select invoiceno,
sum(quantity * unitprice) as order_total
from ecommerce_data
where quantity > 0 and unitprice > 0
group by invoiceno
) as t;

--9. Most expensive product
select description,
max(unitprice) as price
from ecommerce_data
group by description
order by price desc
limit 5;