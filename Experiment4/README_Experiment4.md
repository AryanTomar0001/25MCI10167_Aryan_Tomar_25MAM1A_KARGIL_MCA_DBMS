# **DBMS Lab – Worksheet 4**  
## **Implementation of Iterative Control Structures in PostgreSQL**

---

## 👨‍🎓 **Student Details**  
**Name:** Aryan Tomar  
**UID:** 25MCI10167  
**Branch:** MCA (AI & ML)  
**Semester:** 2nd  
**Section/Group:** 1/A  
**Subject:** DBMS Lab  
**Subject Code:** 25CAP-652  
**Date of Performance:** 04/02/2026  

---

## 🎯 **Aim of the Session**  
To understand and implement iterative control structures in PostgreSQL conceptually, including FOR loops, WHILE loops, and basic LOOP constructs, for repeated execution of database logic.

---

## 💻 **Software Requirements**  
- PostgreSQL (Database Server)  
- pgAdmin  
- Windows Operating System  

---

## 📌 **Objective of the Session**  
- To understand why iteration is required in database programming  
- To learn the purpose and behavior of FOR, WHILE, and LOOP constructs  
- To understand how repeated data processing is handled in databases  
- To relate loop concepts to real-world batch processing scenarios  
- To strengthen conceptual knowledge of procedural SQL used in enterprise systems  

---

## 🛠️ **Practical / Experiment Steps**

### **Prerequisite Understanding**
- Iterative control structures are executed inside PL/pgSQL blocks, not normal SQL queries  
- A table containing multiple records is required to demonstrate loop execution  
- The table should include:
  - A unique identifier  
  - A descriptive attribute  
  - A numeric value for repeated processing  

---

# ⚙️ **Procedure of the Practical**

---

## ✅ **Step 1: Database Creation**

```sql
create database Practical4;
```

---

## ✅ **Step 2: Table Creation**

```sql
create table employee (
    emp_id serial primary key,
    emp_name varchar(50),
    salary numeric(10,2)
);
```

---

## ✅ **Step 3: Insert Records**

```sql
insert into employee (emp_name, salary) values
('Rahul', 40000),
('Ankit', 52000),
('Priya', 60000),
('Neha', 35000),
('Aman', 70000);
```

---

## ✅ **Step 4: Display Records**

```sql
select * from employee;
```
<img width="864" height="372" alt="image" src="https://github.com/user-attachments/assets/132a6b7d-244a-49cc-90f8-eb89a3488517" />

---

## ✅ **Step 5: FOR Loop – Simple Iteration**

```sql
do $$
begin
    for i in 1..5 loop
        raise notice 'Iteration number: %', i;
    end loop;
end $$;
```
<img width="753" height="426" alt="image" src="https://github.com/user-attachments/assets/7ccebb4d-2e7a-4cbf-8369-b8d7d1aafeef" />

---

## ✅ **Step 6: FOR Loop with Query (Row-by-Row Processing)**

```sql
do $$
declare
    emp record;
begin
    for emp in select emp_id, emp_name from employee loop
        raise notice 'Employee ID: %, Name: %', emp.emp_id, emp.emp_name;
    end loop;
end $$;
```
<img width="777" height="428" alt="image" src="https://github.com/user-attachments/assets/7e00d7fa-8595-450c-ac33-a99e8d1b3e49" />

---

## ✅ **Step 7: WHILE Loop – Conditional Iteration**

```sql
do $$
declare
    counter int := 1;
begin
    while counter <= 5 loop
        raise notice 'Counter: %', counter;
        counter := counter + 1;
    end loop;
end $$;
```
<img width="686" height="489" alt="image" src="https://github.com/user-attachments/assets/cf0c9f23-2e9f-4b1e-82d3-bf6d6a17e219" />

---

## ✅ **Step 8: LOOP with EXIT WHEN**

```sql
do $$
declare
    x int := 1;
begin
    loop
        raise notice 'Value: %', x;
        x := x + 1;
        exit when x > 5;
    end loop;
end $$;
```
<img width="659" height="375" alt="image" src="https://github.com/user-attachments/assets/10afdc4c-a3d5-47f7-a9ce-caaa36c2dc71" />

---

## ✅ **Step 9: Salary Increment Using FOR Loop**

```sql
do $$
declare
    emp record;
begin
    for emp in select emp_id, salary from employee loop
        update employee
        set salary = salary * 1.10
        where emp_id = emp.emp_id;
    end loop;
end $$;
```

```sql
select * from employee;
```
<img width="837" height="445" alt="image" src="https://github.com/user-attachments/assets/9b070a61-e03e-4870-9feb-fd942483e270" />

---

## ✅ **Step 10: Combining LOOP with IF Condition**

```sql
do $$
declare
    emp record;
begin
    for emp in select emp_name, salary from employee loop
        if emp.salary > 50000 then
            raise notice '% is a High Earner', emp.emp_name;
        else
            raise notice '% is a Regular Employee', emp.emp_name;
        end if;
    end loop;
end $$;
```
<img width="824" height="470" alt="image" src="https://github.com/user-attachments/assets/a9b1192e-4316-4abb-b7ea-22209369d6c5" />

---

## 📥📤 **6. I/O Analysis (Input / Output)**

### 🔹 Input  
- Employee records stored in a table for iterative processing  
- PL/pgSQL DO blocks containing procedural logic  
- FOR loops for fixed-range and query-based iteration  
- WHILE loop for condition-based execution  
- LOOP construct with EXIT WHEN condition  
- IF–ELSE logic used inside loops  
- UPDATE statements executed repeatedly  

### 🔹 Output  
- Repeated execution of SQL statements using loops  
- Row-by-row processing of table records  
- Conditional messages displayed during iteration  
- Salary updates applied using iterative logic  
- Proper termination of loops based on conditions  
- Successful execution of procedural SQL demonstrating iteration control  

📸 Screenshots of execution and obtained results are attached.

---

## 📘 **7. Learning Outcomes**

- Understood the need for iterative control structures in database programming  
- Learned the usage of FOR, WHILE, and LOOP constructs in PostgreSQL  
- Gained knowledge of executing repeated logic using PL/pgSQL  
- Understood row-by-row processing and conditional execution in databases  
- Developed foundational skills for writing procedural SQL in real-world applications  

---

## 📂 **Repository Contents**
- README.md  
- Worksheet (Word & PDF)  
- SQL Queries  
- Screenshots  

---
