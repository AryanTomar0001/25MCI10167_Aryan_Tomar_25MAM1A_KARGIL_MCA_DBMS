# **DBMS Lab – Worksheet 9**  
## **Implementation of triggers in PostgreSQL**

---

## 👨‍🎓 **Student Details**  
**Name:** Aryan Tomar  
**UID:** 25MCI10167  
**Branch:** MCA (AI & ML)  
**Semester:** 2nd  
**Section/Group:** 1/A  
**Subject:** DBMS Lab  
**Subject Code:** 25CAP-652  
**Date of Performance:** 07/04/2026  

---
## Aim

To implement database triggers in PostgreSQL to automatically calculate values and enforce constraints during data insertion operations.

## Tools Used

- PostgreSQL

## Objectives

- Understand how to create and use triggers in PostgreSQL
- Automate calculation of total payable amount
- Enforce constraints using trigger conditions
- Execute logic automatically before inserting data

## Theory

Triggers are special database objects that automatically execute a function when a specified event (INSERT, UPDATE, DELETE) occurs on a table.

In PostgreSQL:

- Triggers are linked with functions written in PL/pgSQL
- They help maintain data integrity
- They enforce business rules
- They automate repetitive tasks

## Implementation Steps

### Step 1: Create Table

```sql
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    working_hours INT,
    perhour_salary NUMERIC,
    total_payable_amount NUMERIC
);
```

### Step 2: Create Trigger Function

```sql
CREATE OR REPLACE FUNCTION calculate_payable_amount()
RETURNS TRIGGER AS
$$
BEGIN
    NEW.total_payable_amount := NEW.perhour_salary * NEW.working_hours;

    IF NEW.total_payable_amount > 25000 THEN
        RAISE EXCEPTION 'INVALID ENTRY BECAUSE PAYABLE AMOUNT CANNOT BE GREATER THAN 25000';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

### Step 3: Create Trigger

```sql
CREATE OR REPLACE TRIGGER automated_payable_amount_calculation
BEFORE INSERT
ON employee
FOR EACH ROW
EXECUTE FUNCTION calculate_payable_amount();
```

### Step 4: Insert Valid Data

```sql
INSERT INTO employee(emp_id, emp_name, working_hours, perhour_salary)
VALUES (1, 'AKASH', 10, 1000);
```

<img width="706" height="212" alt="image" src="https://github.com/user-attachments/assets/7880fae6-c7eb-421a-b5df-4c34a9c5e760" />

### Step 5: Insert Invalid Data (Exception Case)

```sql
INSERT INTO employee(emp_id, emp_name, working_hours, perhour_salary)
VALUES (2, 'Ankush', 8, 100000);
```
<img width="1056" height="214" alt="image" src="https://github.com/user-attachments/assets/493e89b8-fd9b-4767-a27c-fbe27116881c" />

### Step 6: Retrieve Data

```sql
SELECT * FROM employee;
```
<img width="1056" height="281" alt="image" src="https://github.com/user-attachments/assets/16af3df4-3539-484a-97b2-14400a3d02c5" />

## Outcomes

- Learned how to create and use triggers in PostgreSQL
- Understood automation of calculations using triggers
- Implemented constraints using trigger conditions
- Gained knowledge of real-time database logic execution
