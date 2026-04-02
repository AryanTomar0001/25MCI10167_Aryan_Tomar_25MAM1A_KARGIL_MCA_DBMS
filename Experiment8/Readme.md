# **DBMS Lab – Worksheet 8**  
## **Implementation of Stored Procedures in PostgreSQL**

---

## 👨‍🎓 **Student Details**  
**Name:** Aryan Tomar  
**UID:** 25MCI10167  
**Branch:** MCA (AI & ML)  
**Semester:** 2nd  
**Section/Group:** 1/A  
**Subject:** DBMS Lab  
**Subject Code:** 25CAP-652  
**Date of Performance:** 02/04/2026  

---

## 🎯 **Aim of the Session**  
To apply the concept of Stored Procedures in database operations in order to perform tasks like insertion, updating, deletion, and retrieval of data efficiently, securely, and in a reusable manner within the database system.

---

## 💻 **Software Requirements**  
- PostgreSQL (Database Server)  
- pgAdmin  
- Windows Operating System  

---

## 📌 **Objective of the Session**  
To understand and implement stored procedures for performing database operations like insertion, updating, deletion, and retrieval in an efficient and reusable manner.

---

## 🛠️ **Practical / Experiment Steps**

### **Prerequisite Understanding**

- Basic SQL operations (SELECT, INSERT, UPDATE, DELETE)  
- Table creation and data types in PostgreSQL  
- Concept of procedures and functions  
- PL/pgSQL blocks (BEGIN, END, DECLARE)  
- Parameter types (IN, OUT, INOUT)  
- IF–ELSE logic and exception handling  

---

# ⚙️ **Procedure of the Practical**

---

## ✅ **Step 1: Database Creation**

```sql
create database Practical8;
```

---

## ✅ **Step 2: Table Creation**

```sql
create table Employees2 (
    emp_id int primary key,
    emp_name varchar(50),
    manager_id int,
    department varchar(50),
    salary int
);
```

---

## ✅ **Step 3: Insert Records**

```sql
insert into Employees2 values
(1, 'Amit', NULL, 'Management', 120000),
(2, 'Ravi', 1, 'Engineering', 80000),
(3, 'Neha', 1, 'Engineering', 82000),
(4, 'Karan', 2, 'Engineering', 60000),
(5, 'Simran', 2, 'Engineering', 62000),
(6, 'Pooja', 3, 'Engineering', 61000),
(7, 'Rahul', 3, 'Engineering', 64000),
(8, 'Arjun', 1, 'HR', 70000);
```

---

## ✅ **Step 4: Display Records**

```sql
select * from Employees2;
```
<img width="989" height="408" alt="image" src="https://github.com/user-attachments/assets/9dc5233f-ffca-4865-a043-e3d19d306ad1" />


---

## ✅ **Step 5: Creating Stored Procedure**

```sql
create or replace procedure update_salary_procc(
IN p_emp_id int,
INOUT p_salary numeric(20,3),
OUT status varchar(20)
)
AS
$$
declare
curr_sal numeric(20,3);
begin

select salary + p_salary into curr_sal 
from Employees2 
where emp_id = p_emp_id;

if not found then
    raise exception 'employee not found';
end if;

update Employees2
set salary = curr_sal
where emp_id = p_emp_id;

p_salary := curr_sal;
status := 'success';

exception 
when others then 
    if sqlerrm like '%employee not found%' then
        status := 'employee not found';
    end if;

end;
$$ language plpgsql;
```
<img width="552" height="184" alt="image" src="https://github.com/user-attachments/assets/bd8a8e16-1dac-41ad-aabc-593f0af11e5a" />

---

## ✅ **Step 6: Execute Procedure (Invalid Employee Case)**

```sql
do
$$
declare 
emp_id int := 99;
status varchar(20);
salary numeric(20,3) := 500;
begin
call update_salary_procc(emp_id, salary, status);
raise notice 'your status is %', status;
end;
$$;
```
<img width="633" height="315" alt="image" src="https://github.com/user-attachments/assets/35954f35-1323-4e2c-bf7c-22a5c3ff1683" />

---

## ✅ **Step 7: Execute Procedure (Valid Employee Case)**

```sql
do
$$
declare 
emp_id int := 1;
status varchar(20);
salary numeric(20,3) := 500;
begin
call update_salary_procc(emp_id, salary, status);
raise notice 'your status is %', status;
end;
$$;
```
<img width="709" height="209" alt="image" src="https://github.com/user-attachments/assets/0322da00-5019-4401-83d0-0670e4b3deca" />

---

## ✅ **Step 8: Verify Updated Data**

```sql
select * from Employees2;
```
<img width="1013" height="498" alt="image" src="https://github.com/user-attachments/assets/66ce6348-1262-4acb-b29c-d1a331001a61" />

---

## 📥📤 **6. I/O Analysis (Input / Output)**

### 🔹 Input  
- Employee records inserted into the Employees2 table  
- Stored procedure with IN, OUT, INOUT parameters  
- Employee ID and salary increment values  
- PL/pgSQL DO blocks for execution  
- Conditional logic and exception handling  

### 🔹 Output  
- Salary updated for valid employee IDs  
- Error handled for invalid employee IDs  
- Status returned as 'success' or 'employee not found'  
- Updated salary reflected in table  
- Reusable logic executed successfully  

📸 Screenshots of execution and obtained results are attached.

---

## 📘 **7. Learning Outcomes**

- Understanding of stored procedures in PostgreSQL  
- Use of IN, OUT, INOUT parameters  
- Implementation of reusable database logic  
- Handling exceptions using PL/pgSQL  
- Performing conditional updates inside procedures  
- Applying backend logic at database level  

---

## 📂 **Repository Contents**
- README.md  
- Worksheet (Word & PDF)  
- SQL Queries  
- Screenshots  

---
