create table products (
	product_id INT,
    product_name VARCHAR(25), -- unique, -- whether u wish during creating the table time whether i will show you  
    price DECIMAL(4,2)
); 

select * from products;

insert into products values
								(1, 'apple', 10.00),
								(2, 'apple', 10.00);

alter table products
add constraint
unique(product_name);

delete from products
where product_id = 1;

update products
set product_id = 1
where product_id = 2;


set sql_safe_updates = 0



