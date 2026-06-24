use mydb;

alter table customers
drop column referral_i ;

update customers
set referral_id = 4
where customer_id = 10;

select * from customers;


select * 
from customers as a
inner join customers as b
on a.referral_id = b.customer_id;


select a.customer_id, a.first_name, a.last_name,
	   a.referral_id, concat(b.first_name, " ", b.last_name) as "referred_by"
from customers as a
left join customers as b
on a.referral_id = b.customer_id;



select * from employees;


alter table employees
modify column supervisor_id int after hire_date ;

set sql_safe_updates = 0;

update employees
set supervisor_id = 7
where employee_id = 1;

select * from employees;


select a.employee_id, a.first_name, a.last_name,
	   concat(b.first_name, " ", b.last_name) as "supervisor"
from employees as a 
inner join  employees as b 
on a.supervisor_id = b.employee_id
order by a.employee_id asc;


select  a.employee_id, a.first_name, a.last_name, 
		concat(b.first_name, " ", b.last_name) as "supervisor"
from employees as a 
inner join employees as b
on a.supervisor_id = b.employee_id
order by a.employee_id asc;



