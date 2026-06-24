select * from transactions;

set sql_safe_UPDATES = 0;

delete from transactions;

select * FROM customers;

DELETE FROM CUSTOMERS;

alter table customers
auto_increment = 0;

alter table transactions
auto_increment = 0;

insert into transactions(amount, customer_id) 
values (4.99, 3),
	   (2.89, 2),
       (3.39, 3),
       (4.99, 1);
       
       
insert into transactions(amount, customer_id) 
values (4.99, 8);
       
alter table transactions
drop foreign key fk_customer_id;

alter table transactions
add constraint fk_customer_id
foreign key(customer_id)
references customers(customer_id);
       
       
alter table transactions
add constraint fk_customer_id
foreign key(customer_id) references customers(customer_id);
       
insert into customers(first_name, last_name) 
values ('Fred', 'Fish'),
	   ('Larry', 'Lobster'),
       ('Bubble', 'Bass');