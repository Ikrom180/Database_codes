-- Index (BTree data structure)
-- Indexes are used to find values within a specific column more quickly
-- MySql normally searches sequentially through a column
-- The longer the column , the more ecpensive the operation  is
-- Update takes more time , Select takes less time

#     DB codes
-- use mydb;
-- show indexes from customers => shows index has or not in table

# Creating indexing

use mydb;

Create index last_name_inx
on customers(last_name);

show indexes from customers;

alter table customers
DROP index last_name_inx;

create index last_name_first_name_idx
on customers(last_name, first_name);

show indexes from customers;