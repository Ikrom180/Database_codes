-- select * from employees;

-- alter table  employees
-- add column job varchar(25) ;

-- alter table employees
-- modify job varchar(25) after hourly_pay;

-- set sql_safe_updates = 0;

-- update employees
-- set job = 'Boss'
-- where employee_id = 7;


-- update employees
-- set employee_id = 7
-- where first_name = 'Jovohir';


select * 
from employees
where hire_date <= "2026-01-05" and job = "janitor";


select * 
from employees
where job = 'cook' or job = 'cashier';

select * 
from employees
where job = 'cook' and job = 'cashier';


select * 
from employees
where not job = "manager";


select * 
from employees
where not job = "manager" and not job = "asst.manager";


select * from employees;



select * 
from employees 
where hire_date between "2023-01-01" and "2030-01-01";

select * 
from employees 
where job in ("cook", "cashier");


