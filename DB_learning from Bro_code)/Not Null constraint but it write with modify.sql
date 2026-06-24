select * from products;

create table products(
	product_id int,
    product_name varchar(25),
    price decimal(4,2)  -- not null -- or u will see alter option
);

alter table products 
modify price decimal(4,2) not null;

delete from products 
where product_id = 1; 

insert into products values (100, 'hamburger', 3.99),
							(101, 'fries', 1.89),
                            (102, 'sode', 1.00),
                            (103, 'ice cream', 1.49);
                            
insert into products values(103, 'ice cream', null);

update products                            
set price = null
where product_id = 100
