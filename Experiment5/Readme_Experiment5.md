# **DBMS Lab – Worksheet 5**  
## **Implementation of Cursors for Row-by-Row Processing in PostgreSQL**

---

## 👨‍🎓 **Student Details**  
**Name:** Aryan Tomar  
**UID:** 25MCI10167  
**Branch:** MCA (AI & ML)  
**Semester:** 2nd  
**Section/Group:** 1/A  
**Subject:** DBMS Lab  
**Subject Code:** 25CAP-652  
**Date of Performance:** 01/03/2026  

---

## 🎯 **Aim of the Session**  
To gain hands-on experience in creating and using cursors for row-by-row processing in a database, enabling sequential access and manipulation of query results for complex business logic.

(Company Relevance: Infosys, Wipro, TCS, Capgemini)

---

## 💻 **Software Requirements**  
- PostgreSQL (Database Server)  
- pgAdmin  
- Windows Operating System  

---

## 📌 **Objective of the Session**  

- **Sequential Data Access:** To fetch rows one by one using cursor mechanisms.  
- **Row-Level Manipulation:** To perform conditional logic and calculations on individual records.  
- **Resource Management:** To understand DECLARE, OPEN, FETCH, CLOSE lifecycle of cursors.  
- **Exception Handling:** To handle cursor-related edge cases such as empty result sets.  

---

## 🛠️ **Practical / Experiment Steps**

### **Prerequisite Understanding**
- Cursors are used inside PL/pgSQL blocks for row-by-row processing.  
- Cursors differ from set-based SQL execution.  
- A table with multiple records is required for demonstration.  
- The table must include:
  - A primary key  
  - A descriptive column (e.g., employee name)  
  - A numeric column (e.g., salary or experience)  
- Cursor lifecycle includes DECLARE → OPEN → FETCH → CLOSE.  
- Basic IF–ELSE logic is required for conditional processing.  

---

# ⚙️ **Procedure of the Practical**

---

## ✅ **Step 1: Database Creation**

```sql
create database Practical5;
```

---

## ✅ **Step 2: Table Creation**

```sql
create table employee_cursor (
    emp_id serial primary key,
    emp_name varchar(50),
    experience int,
    salary numeric(10,2)
);
```

---

## ✅ **Step 3: Insert Records**

```sql
insert into employee_cursor (emp_name, experience, salary) values
('Rahul', 2, 30000),
('Ankit', 5, 45000),
('Priya', 8, 60000),
('Neha', 1, 25000),
('Aman', 10, 80000);
```

---

## ✅ **Step 4: Display Records**

```sql
select * from employee_cursor;
```
<img width="1028" height="372" alt="image" src="https://github.com/user-attachments/assets/7746f163-6649-4be0-9b22-795b8aaf7344" />
---

## ✅ **Step 5: Implementing a Simple Forward-Only Cursor**

```sql
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

```

<img width="892" height="418" alt="image" src="https://github.com/user-attachments/assets/aa9148a0-25d0-422c-8242-366b927281ad" />

---
## ✅ **Step 6: Complex Row-by-Row Manipulation**

```sql
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

<img width="1034" height="458" alt="image" src="https://github.com/user-attachments/assets/39d70e71-6a70-4952-ba65-3156b467cc4b" />

```
<img width="1034" height="458" alt="image" src="https://github.com/user-attachments/assets/53bb43db-6c2c-4e16-8832-97cd044fc257" />

---

## ✅ **Step 7: Exception and Status Handling**

```sql
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

```
<img width="839" height="231" alt="image" src="https://github.com/user-attachments/assets/afc0f7bf-4fda-4e7a-88ab-4389078acf82" />

---

## 📥📤 **6. I/O Analysis (Input / Output)**

### 🔹 Input  
- Employee records inserted into table  
- PL/pgSQL DO blocks containing cursor logic  
- DECLARE, OPEN, FETCH, CLOSE statements  
- IF–ELSE conditional logic  
- UPDATE statements inside cursor loops  
- Exception handling for empty result sets  

### 🔹 Output  
- Sequential row-by-row processing of employee records  
- Display of employee details using FETCH  
- Conditional salary updates based on experience  
- Notice messages generated during execution  
- Proper termination of cursor after processing  
- Successful handling of empty result sets  

📸 Screenshots of execution and obtained results are attached.

---

## 📘 **7. Learning Outcomes**

- Students can design and implement cursors for row-wise processing.  
- Students understand the complete cursor lifecycle.  
- Students can apply conditional business logic using cursors.  
- Students can handle empty result sets and prevent logical errors.  
- Students can apply cursor logic to real-world payroll and migration scenarios.  

---

## 📂 **Repository Contents**
- README.md  
- Worksheet (Word & PDF)  
- SQL Queries  
- Screenshots  

---
