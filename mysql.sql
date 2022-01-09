select distinct
	state
from sql_store.customers;

select *  from sql_store.customers;

SELECT 
	name,
    unit_price*1.1 'new price'
FROM sql_inventory.products;

select *
from sql_store.customers
where points>3000;

select * 
from sql_store.customers
where birth_date > '1990-01-01' or 
(points>1000 and not state='VA');
select *
from sql_store.order_items
where order_id=6 and ((quantity*unit_price)>30) ;

select *
from sql_store.orders
where order_date>'2019-01-01';

select *
from sql_inventory.products
where quantity_in_stock in (49,38,72);

select *
from sql_store.customers
where state in ('VA','FL','GA');

SELECT *
FROM sql_store.customers
WHERE points>=1000 and points<=3000; #BETWEEN 1000 AND 3000 

SELECT *
FROM sql_store.customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT *
FROM sql_store.customers
WHERE -- address LIKE '%TRAIL%' OR 
-- address LIKE '%AVENUE%' AND
phone LIKE '%9';

SELECT *
FROM sql_store.customers
WHERE last_name regexp '[g-i]e';

SELECT *
FROM sql_store.customers
WHERE last_name regexp 'field|rose';


SELECT *
FROM sql_store.customers
-- WHERE first_name regexp 'ELKA|AMBUR'
-- WHERE last_name regexp '^my|se'
where last_name regexp 'b[ru]';

SELECT*
FROM sql_store.customers
WHERE phone is null;

select *
from sql_store.orders
where shipped_date or shipper_id is null;

select *,
	quantity*unit_price as total
from sql_store.order_items
where order_id=2 
order by total desc;

select *
from sql_store.customers
limit 3 offset 5;

select * 
from sql_store.customers
order by points desc
limit 3;

select o.order_id, c.customer_id, c.first_name, c.last_name
from sql_store.orders o
join sql_store.customers c 
	on o.customer_id=c.customer_id;
    
select o.order_id, 
	p.product_id, 
    p.quantity_in_stock, 
    o.quantity as quantity_ordered,
    p.unit_price
from sql_store.order_items o
join sql_store.products p on o.product_id= p.product_id;

select*
from sql_store.order_items o
join sql_inventory.products p on o.product_id=p.product_id;

select 
	e.employee_id,
    e.first_name,
    m.first_name as manager
from sql_hr.employees e
join sql_hr.employees m 
	on e.reports_to=m.employee_id;


SELECT c.client_id,
	c.name,
	p.date,
    c.address,
    p.amount,
    pm.name as payment_method
FROM sql_invoicing.payments as p
JOIN sql_invoicing.clients as c
	ON c.client_id=p.client_id
JOIN sql_invoicing.payment_methods as pm
	ON p.payment_method=pm.payment_method_id;
    
select *
from sql_store.order_items as o
join sql_store.order_item_notes as oin
	on o.product_id=oin.product_id
	AND	o.order_id=oin.order_Id;

SELECT p.date,
	   c.name,
       pm.name as transcation
FROM sql_invoicing.clients c
JOIN sql_invoicing.payments p
	USING (client_id)
JOIN sql_invoicing.payment_methods pm
	on p.payment_method = pm.payment_method_id;
    
SELECT o.order_id,
	o.order_date,
    'Active' as Status
FROM sql_store.orders o
WHERE o.order_date>'2019-01-01'
UNION
SELECT o.order_id,
	o.order_date,
    'Archived' as Status
FROM sql_store.orders o
WHERE o.order_date<'2019-01-01';


SELECT c.customer_id,c.first_name,c.points, 'Bronze' as type
FROM sql_store.customers c
WHERE c.points < 2000
UNION
SELECT c.customer_id,c.first_name,c.points, 'Silver' as type
FROM sql_store.customers c
WHERE c.points between 2000 and 3000
UNION
SELECT c.customer_id,c.first_name,c.points, 'Gold' as type
FROM sql_store.customers c
WHERE c.points between 3000 and 4000
order by points desc;

show databases;
use sql_store;

create table orders_archived as
select * from orders
where orders.order_date<'2019-01-01';

select * from orders_archived;

use sql_invoicing;

DROP TABLE IF EXISTS payements_done;
create table payements_done as
select *
from invoices i
left join clients c
using(client_id)
where i.payment_date is not null;

select * from payements_done;

update invoices
set  payment_total=0, payment_date=Null
where invoice_id=1

