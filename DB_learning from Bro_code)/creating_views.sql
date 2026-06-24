-- use mydb

create view employee_attandance as 
select e.first_name, e.last_name
from employees e;

drop view employee_attandance;


select * from employee_attandance
order by last_name asc;

select * from customers ;

alter table customers
add column emails varchar(50);

update customers
set emails = 'botirr55@gmail.com'
where  customer_id = 9;

select * from customers ;


create view customer_emails as 
select emails
from customers;

insert into customers
values (10, 'Pearl', 'Krabs', null, 'PBkrabs.com');

select * from customer_emails