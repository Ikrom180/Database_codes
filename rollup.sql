-- Rollup , extension of the GROUP By clause
-- produces another row and shows the grand total(super-aggregate value)
use mydb;

select sum(t.amount), t.order_date
from transactions t
group by order_date with rollup ; -- all group by sums

select count(t.transaction_id), t.order_date
from transactions t
group by order_date with rollup ; -- transactions sums all of the roll up shows this

select count(t.transaction_id) as  '# of orders', t.customer_id
from transactions t
group by customer_id with rollup ;


select sum(t.hourly_pay), t.employee_id
from employees t
group by employee_id with rollup;

select * from transactions




/*
select * from transactions;


-- alter table transactions add column order_date date
INSERT INTO transactions (order_date)
VALUES (CURDATE());  -- MySQL

insert into transactions values (9, 5.99, 5, '2026-05-20');

delete from transactions t
where t.order_date = curdate();

UPDATE transactions
SET order_date = '2026-06-29'
WHERE order_date IS NULL;