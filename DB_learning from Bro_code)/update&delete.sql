use mydb;

select * from employees ;

insert into employees(employee_id, first_name, last_name) values(6, 'Sheldon', 'Plankton');

alter table employees
add constraint
unique(employee_id);

-- to disable safe mode
set sql_safe_updates = 0;

-- to delete
delete from employees
where employee_id = 6;

select * from employees;

-- to update the table
update employees
set hourly_pay = 10.90
where employee_id = 6;


update employees
set hire_date = now()
where employee_id = 6