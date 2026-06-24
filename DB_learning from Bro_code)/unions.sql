create table income(
	income_name varchar(15),
    amount int
);

insert into income values ('orders', 1000000), ('merchandise', 50000), ('services', 125000);
select * from income;

delete from income;

create table expenses(
	income_name varchar(15),
    amount int
);


insert into expenses values ('wages', -250000), ('tax', -50000), ('repairs', -150000);

select * from expenses;

select * from income
union
select * from expenses;

drop table income;
drop table expenses;



select * from employees 
union
select * from customers;



select e.first_name, e.last_name from employees e
union all
select c.first_name, c.last_name from customers c;

select e.first_name, e.last_name from employees e
union 
select c.first_name, c.last_name from customers c;
















