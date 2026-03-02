create table employee_cursor (
    emp_id serial primary key,
    emp_name varchar(50),
    experience int,
    salary numeric(10,2)
);

insert into employee_cursor (emp_name, experience, salary) values
('Rahul', 2, 30000),
('Ankit', 5, 45000),
('Priya', 8, 60000),
('Neha', 1, 25000),
('Aman', 10, 80000);


select * from employee_cursor;



--Implementing a Simple Forward-Only Cursor
do $$
declare
    emp_rec record;
    emp_cursor cursor for 
        select emp_id, emp_name, salary from employee_cursor;
begin
    open emp_cursor;

    loop
        fetch emp_cursor into emp_rec;
        exit when not found;

        raise notice 'ID: %, Name: %, Salary: %',
        emp_rec.emp_id, emp_rec.emp_name, emp_rec.salary;
    end loop;

    close emp_cursor;

	
end $$;


----Complex Row-by-Row Manipulation

do $$
declare
    emp_rec record;
    emp_cursor cursor for 
        select emp_id, experience, salary from employee_cursor;
begin
    open emp_cursor;

    loop
        fetch emp_cursor into emp_rec;
        exit when not found;

        if emp_rec.experience >= 8 then
            update employee_cursor
            set salary = salary * 1.20
            where emp_id = emp_rec.emp_id;

        elseif emp_rec.experience >= 5 then
            update employee_cursor
            set salary = salary * 1.10
            where emp_id = emp_rec.emp_id;

        else
            update employee_cursor
            set salary = salary * 1.05
            where emp_id = emp_rec.emp_id;
        end if;

    end loop;

    close emp_cursor;
end $$;

---Exception and Status Handling

do $$
declare
    emp_rec record;
    emp_cursor cursor for 
        select * from employee_cursor where experience > 20;
begin
    open emp_cursor;

    fetch emp_cursor into emp_rec;

    if not found then
        raise notice 'No employees found with experience > 20.';
    else
        raise notice 'Employees exist.';
    end if;

    close emp_cursor;
end $$;
