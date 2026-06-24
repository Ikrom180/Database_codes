select count(amount) as 'Today`s transaction'-- count
from transactions;

select max(amount) as maximum
from transactions;

select avg(amount) as average
from transactions;

select sum(amount) as 'total sum'
from transactions;