use mydb
create table test(
	my_date DATE,
    my_time Time,
    my_datetime DATETIME

);


select * from test;

insert into test 
-- values( current_date(), current_time(), now());
-- value(current_date() +1 , null, null);
value(current_date() - 1 , null, null);

select * from test;