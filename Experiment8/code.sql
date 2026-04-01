
CREATE TABLE Employees2 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT,
    department VARCHAR(50),
    salary INT
);
INSERT INTO Employees2 VALUES
(1, 'Amit', NULL, 'Management', 120000),
(2, 'Ravi', 1, 'Engineering', 80000),
(3, 'Neha', 1, 'Engineering', 82000),
(4, 'Karan', 2, 'Engineering', 60000),
(5, 'Simran', 2, 'Engineering', 62000),
(6, 'Pooja', 3, 'Engineering', 61000),
(7, 'Rahul', 3, 'Engineering', 64000),
(8, 'Arjun', 1, 'HR', 70000);

create or replace procedure update_salary_procc(IN p_emp_id int,inout p_salary numeric(20,3),OUT status varchar(20))
AS
$$
declare
curr_sal numeric(20,3);
begin
select salary+p_salary into curr_sal from Employees2 where emp_id=p_emp_id;
if not found then
raise exception 'employee not found';
end if;


update Employees2
set salary=curr_sal
where emp_id=p_emp_id;
p_salary:=curr_sal;
status:='success';
exception 
when others then 
if sqlerrm like '%employee not found%' then
status:='employee not found';
end if;
end;
$$ language plpgsql;


----employee not found

do
$$
declare 
emp_id int :=99;
status varchar(20);
salary numeric(20,3):=500;
begin
call update_salary_procc(emp_id,salary,status);
raise notice 'your status is %',status;
end ;
$$


do
$$
declare 
emp_id int :=1;
status varchar(20);
salary numeric(20,3):=500;
begin
call update_salary_procc(emp_id,salary,status);
raise notice 'your status is %',status;
end ;
$$

select* from Employees2;
