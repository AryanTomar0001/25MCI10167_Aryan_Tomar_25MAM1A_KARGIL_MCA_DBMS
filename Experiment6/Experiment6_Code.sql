create table department (
    dept_id serial primary key,
    dept_name varchar(50)
);

create table employee (
    emp_id serial primary key,
    emp_name varchar(50),
    salary numeric(10,2),
    status varchar(20),
    dept_id int references department(dept_id)
);


insert into department (dept_name) values
('HR'),
('IT'),
('Finance'),
('Sales');


insert into employee (emp_name, salary, status, dept_id) values
('Rahul', 40000, 'Active', 1),
('Ankit', 52000, 'Active', 2),
('Priya', 60000, 'Inactive', 2),
('Neha', 35000, 'Active', 3),
('Aman', 70000, 'Active', 4);



select * from employee;
select * from department;



create view active_employees as
select emp_id, emp_name, salary, dept_id
from employee
where status = 'Active';

select * from active_employees;



create view employee_department_view as
select 
    e.emp_id,
    e.emp_name,
    e.salary,
    d.dept_name
from employee e
join department d
on e.dept_id = d.dept_id;

select * from employee_department_view;


create view department_summary as
select 
    d.dept_name,
    count(e.emp_id) as total_employees,
    avg(e.salary) as average_salary,
    sum(e.salary) as total_salary
from department d
left join employee e
on d.dept_id = e.dept_id
group by d.dept_name;

select * from department_summary;



create or replace view active_employees as
select emp_id, emp_name, salary
from employee
where status = 'Active';

select * from active_employees;
