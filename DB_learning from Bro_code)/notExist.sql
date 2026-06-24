use mydb;

select c.customer_id , t.amount , c.first_name 
from transactions t
inner join customers c
on t.customer_id = c.customer_id;





select * from customers;
select * from transactions;

select * 
from customers c 
where customer_id not in(
	select * 
    from transactions t 
    where t.customer_id = c.customer_id
);


SELECT c.*
FROM customers c
left JOIN transactions t
       ON c.customer_id = t.customer_id
WHERE t.customer_id IS NULL;


SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT *
    FROM transactions t
    WHERE t.customer_id = c.customer_id
);


SELECT c.*
FROM customers c
LEFT JOIN transactions t
       ON c.customer_id = t.customer_id
WHERE t.customer_id IS NULL;



SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM transactions t
    WHERE t.customer_id = c.customer_id
);
