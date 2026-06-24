select * from transactions;

drop table transactions;

create table transactions (
	transaction_id int primary key,
    amount decimal(5,2)
);

alter table transactions
add constraint
primary key (amount);


select * from transactions;

alter table transactions
drop column amount;

alter table transactions
add amount decimal(5,2);

insert into transactions
value(null, 5.99);


select * from transactions;

select amount
from transactions
where transaction_id = 1003;