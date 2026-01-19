---customer name, product, quantity, price, and order date.

create table customer_orders(
order_id serial primary key,
customer_name varchar(20),
product varchar(20),
quantity int,
price numeric(10,2),
order_date date
);

insert into customer_orders(customer_name,product,quantity,price,order_date) values
('Amit', 'Laptop', 1, 55000, '2025-01-05'),
('Amit', 'Mouse', 2, 800, '2025-01-06'),
('Riya', 'Mobile', 1, 22000, '2025-01-10'),
('Riya', 'Headphones', 1, 2000, '2025-01-10'),
('Karan', 'Laptop', 1, 60000, '2025-02-02'),
('Karan', 'Keyboard', 1, 1500, '2025-02-05'),
('Neha', 'Mobile', 2, 21000, '2025-02-15'),
('Neha', 'Charger', 3, 900, '2025-02-18');

select*from customer_orders;

--Filtering Data Using Conditions Show only those customer who purcahse 20000 above show customer name 
--and product and quantity and price

select order_id,customer_name,product,quantity,price
from customer_orders where price>20000;


---Sorting Query Results
--ascending
select order_id,customer_name,product,quantity,price
from customer_orders where price>20000 order by price ;

--descending
select order_id,customer_name,product,quantity,price
from customer_orders where price>20000 order by price desc;

--Grouping Data for Aggregation
select product ,count(*)as total_product_sale
from customer_orders
group by product;


--Step 5: Applying Conditions on Aggregated Data
select product,
sum(quantity*price) as total_revenue
from customer_orders
group by product
having sum(quantity*price) > 50000;


--step6
select product, sum(quantity*price) as total_revenue
from customer_orders
where order_date >= '2025-01-01'
group by product
having sum(quantity*price) > 50000;
