# **DBMS Lab – Worksheet 6**  
## **Implementation of Views in PostgreSQL**

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
To learn how to create, query, and manage views in SQL to simplify database queries and provide a layer of abstraction for end-users.

---

## 💻 **Software Requirements**  
- PostgreSQL (Database Server)  
- pgAdmin  
- Windows Operating System  

---

## 📌 **Objective of the Session**

- **Data Abstraction:** Hide complex joins and calculations behind a simple virtual table.  
- **Enhanced Security:** Restrict access to sensitive columns using views.  
- **Query Simplification:** Pre-join multiple tables for easier reporting.  
- **View Management:** Understand creation, replacement, and deletion of views.  

---

## 🛠️ **Practical / Experiment Steps**

### **Prerequisite Understanding**

- A View is a virtual table created from a SELECT query.  
- Views do not store data physically.  
- Base tables must be created before creating views.  
- JOIN operations must be understood for multi-table views.  
- Aggregate functions (COUNT, SUM, AVG) are required for summary views.  
- Commands required:
  - CREATE VIEW  
  - SELECT  
  - CREATE OR REPLACE VIEW  
  - DROP VIEW  

---

# ⚙️ **Procedure of the Practical**

---

## ✅ **Step 1: Database Creation**

```sql
create database Practical6;
```

---

## ✅ **Step 2: Table Creation**

```sql
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
```

---

## ✅ **Step 3: Insert Records**

```sql
insert into department (dept_name) values
('HR'),
('IT'),
('Finance'),
('Sales');
```

```sql
insert into employee (emp_name, salary, status, dept_id) values
('Rahul', 40000, 'Active', 1),
('Ankit', 52000, 'Active', 2),
('Priya', 60000, 'Inactive', 2),
('Neha', 35000, 'Active', 3),
('Aman', 70000, 'Active', 4);
```

---

## ✅ **Step 4: Display Base Tables**

```sql
select * from employee;
select * from department;
```
<img width="1008" height="277" alt="image" src="https://github.com/user-attachments/assets/142aaf99-e807-41d3-8de0-eff87f604b8e" />
<img width="717" height="375" alt="image" src="https://github.com/user-attachments/assets/3f75f790-860c-49d9-8744-5ca437a0d994" />

---

## ✅ **Step 5: Creating a Simple View (Filtering)**

```sql
create view active_employees as
select emp_id, emp_name, salary, dept_id
from employee
where status = 'Active';
```

```sql
select * from active_employees;
```
<img width="614" height="238" alt="image" src="https://github.com/user-attachments/assets/23ae43f4-a038-45eb-9c94-0c8fdd55966a" />

---

## ✅ **Step 6: Creating a Join View (Multiple Tables)**

```sql
create view employee_department_view as
select 
    e.emp_id,
    e.emp_name,
    e.salary,
    d.dept_name
from employee e
join department d
on e.dept_id = d.dept_id;
```

```sql
select * from employee_department_view;
```
<img width="911" height="297" alt="image" src="https://github.com/user-attachments/assets/77749698-822a-49e9-9de5-998e08930f20" />

---

## ✅ **Step 7: Advanced Summarization View**

```sql
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
```

```sql
select * from department_summary;
```
<img width="1018" height="272" alt="image" src="https://github.com/user-attachments/assets/54962552-d606-489c-a028-b85e13a90c2b" />

---

## ✅ **Step 8: Modifying View**

```sql
create or replace view active_employees as
select emp_id, emp_name, salary
from employee
where status = 'Active';
```

```sql
select * from active_employees;
```
<img width="806" height="313" alt="image" src="https://github.com/user-attachments/assets/ed61e979-b615-4858-80f4-a12899717e12" />

---

## 📥📤 **6. I/O Analysis (Input / Output)**

### 🔹 Input  
- Creation of base tables (Employee & Department)  
- Insertion of sample records  
- SQL commands for simple and complex views  
- JOIN operations inside views  
- Aggregate functions for summary views  

### 🔹 Output  
- Virtual tables created successfully  
- Filtered employee data displayed  
- Combined employee-department data retrieved  
- Department-level statistics generated  
- Simplified reporting queries  
- Real-time updated results when base tables change  

📸 Screenshots of execution and obtained results are attached.

---

## 📘 **7. Learning Outcomes**

- Students can create and manage simple and complex views.  
- Students understand abstraction using virtual tables.  
- Students can implement view-based security concepts.  
- Students can simplify reporting using JOIN and aggregation views.  
- Students can apply views in real-world systems like Payroll or Library Management.  

---

## 📂 **Repository Contents**
- README.md  
- Worksheet (Word & PDF)  
- SQL Queries  
- Screenshots  

---
