use mydb;

create table products (
	product_id int,
    product_name varchar(25),
    price Decimal(4,2) default 0
    
);


alter table products
alter price set default 0;

insert into products (product_id, product_name)
values  (104, "straw"),
		(105, "napkin"),
		(106, "fork"),
        (107, "spoon");



select * from products;



insert into products 
values  (104, "straw", 0.00),
		(105, "napkin", 0.00),
		(106, "fork", 0.00),
        (107, "spoon", 0.00);
	
select * from products;

set sql_safe_updates = 0;

delete from products
where product_id >= 104;

select * from products;









create table transactions(
	transaction_id int,
    amount decimal(5,2),
    transaction_date datetime default now()
);


insert into transactions(transaction_id, amount)
values (1, 5.99);

select * from transactions





