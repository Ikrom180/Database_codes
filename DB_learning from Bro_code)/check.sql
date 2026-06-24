CREATE TABLE employees(
	employee_id int,
    first_name varchar(50),
    last_name varchar(50),
    hourly_pay decimal(5, 2),
    hire_date date,
    constraint chk_hourly_pay check (hourly_pay >= 10.00)
);

alter table employees
add constraint chk_hourly_pay check(hourly_pay >= 10.00);

insert into employees value (6, 'Jovohir', 'Mamanabiyev', 10.99, current_date());

select * from employees;






