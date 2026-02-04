CREATE TABLE employee (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(50),
    salary NUMERIC(10,2)
);

INSERT INTO employee (emp_name, salary) VALUES
('Rahul', 40000),
('Ankit', 52000),
('Priya', 60000),
('Neha', 35000),
('Aman', 70000);
select*from employee;
--Example 1: FOR Loop – Simple Iteration

DO $$
BEGIN
    FOR i IN 1..5 LOOP
        RAISE NOTICE 'Iteration number: %', i;
    END LOOP;
END $$;

--Example 2
DO $$
DECLARE
    emp RECORD;
BEGIN
    FOR emp IN SELECT emp_id, emp_name FROM employee LOOP
        RAISE NOTICE 'Employee ID: %, Name: %', emp.emp_id, emp.emp_name;
    END LOOP;
END $$;

--Example 3:
DO $$
DECLARE
    counter INT := 1;
BEGIN
    WHILE counter <= 5 LOOP
        RAISE NOTICE 'Counter: %', counter;
        counter := counter + 1;
    END LOOP;
END $$;


--Example 4
DO $$
DECLARE
    x INT := 1;
BEGIN
    LOOP
        RAISE NOTICE 'Value: %', x;
        x := x + 1;
        EXIT WHEN x > 5;
    END LOOP;
END $$;


---Example 5
DO $$
DECLARE
    emp RECORD;
BEGIN
    FOR emp IN SELECT emp_id, salary FROM employee LOOP
        UPDATE employee
        SET salary = salary * 1.10
        WHERE emp_id = emp.emp_id;
    END LOOP;
END $$;

select*from employee;

--Example 6

DO $$
DECLARE
    emp RECORD;
BEGIN
    FOR emp IN SELECT emp_name, salary FROM employee LOOP
        IF emp.salary > 50000 THEN
            RAISE NOTICE '% is a High Earner', emp.emp_name;
        ELSE
            RAISE NOTICE '% is a Regular Employee', emp.emp_name;
        END IF;
    END LOOP;
END $$;
