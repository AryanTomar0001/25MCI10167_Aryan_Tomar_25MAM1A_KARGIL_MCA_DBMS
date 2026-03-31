# **DBMS Lab – Worksheet 7**  
## **Implementation of JOINS in PostgreSQL**

---

## 👨‍🎓 **Student Details**  
**Name:** Aryan Tomar  
**UID:** 25MCI10167  
**Branch:** MCA (AI & ML)  
**Semester:** 2nd  
**Section/Group:** 1/A  
**Subject:** DBMS Lab  
**Subject Code:** 25CAP-652  
**Date of Performance:** 31/03/2026  

---

## 🎯 **Aim of the Session**  
To implement different types of SQL JOIN operations in PostgreSQL to retrieve and combine data from multiple related tables.

---

## 💻 **Software Requirements**  
- PostgreSQL (Database Server)  
- pgAdmin  
- Windows Operating System  

---

## 📌 **Objective of the Session**

- To understand different types of SQL JOINs (INNER, LEFT, RIGHT, CROSS)  
- To retrieve and combine data from multiple related tables  
- To identify matched and unmatched records using joins  
- To apply JOIN operations in real-world database scenarios  

---

## 🛠️ **Practical / Experiment Steps**

### **Prerequisite Understanding**

- Basic knowledge of DBMS concepts (tables, rows, columns)  
- Understanding of SQL commands (SELECT, WHERE, etc.)  
- Knowledge of primary key and foreign key relationships  
- Basic idea of relational databases and table linking  

---

# ⚙️ **Procedure of the Practical**

---

## ✅ **Step 1: Database Creation**

```sql
create database Practical7;
```

---

## ✅ **Step 2: Table Creation**

```sql
create table departments (
    department_id int primary key,
    department_name varchar(50)
);

create table students (
    student_id int primary key,
    name varchar(50),
    department_id int,
    foreign key (department_id) references departments(department_id)
);

create table courses (
    course_id int primary key,
    course_name varchar(50)
);

create table enrollments (
    student_id int,
    course_id int,
    primary key (student_id, course_id),
    foreign key (student_id) references students(student_id),
    foreign key (course_id) references courses(course_id)
);
```

---

## ✅ **Step 3: Insert Records**

```sql
insert into departments values
(1, 'Computer Science'),
(2, 'Mechanical'),
(3, 'Electrical');

insert into students values
(1, 'Aryan', 1),
(2, 'Rohit', 2),
(3, 'Priya', 1),
(4, 'Simran', 3),
(5, 'Karan', NULL);

insert into courses values
(101, 'DBMS'),
(102, 'OS'),
(103, 'Maths'),
(104, 'Physics');

insert into enrollments values
(1, 101),
(1, 102),
(2, 103),
(3, 101);
```

---

## ✅ **Step 4: Display Records**

```sql
select * from students;
```
<img width="924" height="393" alt="image" src="https://github.com/user-attachments/assets/db34b7e9-045c-4928-ae70-880b296026eb" />

```sql
select * from departments;
```

<img width="741" height="296" alt="image" src="https://github.com/user-attachments/assets/5bbf5c43-65f9-46ba-96e1-9dcae8371169" />

```sql
select * from courses;
```
<img width="611" height="311" alt="image" src="https://github.com/user-attachments/assets/ed44f415-4b15-4b3b-b098-889168e8562e" />

```sql
select * from enrollments;
```
<img width="483" height="298" alt="image" src="https://github.com/user-attachments/assets/d7931597-3d6c-4fbb-9f1c-c6628bcb6a4a" />


---

## ✅ **Step 5: INNER JOIN (Students with Courses)**

```sql
select 
s.student_id, s.name, c.course_name
from students s
inner join enrollments e on s.student_id = e.student_id
inner join courses c on e.course_id = c.course_id;
```
<img width="988" height="1234" alt="image" src="https://github.com/user-attachments/assets/811b99dc-7cbb-4dc5-ac38-4eb0565e54da" />

---

## ✅ **Step 6: LEFT JOIN (Students not enrolled in any course)**

```sql
select 
s.student_id, s.name
from students s
left join enrollments e on s.student_id = e.student_id
where e.student_id is null;
```
<img width="622" height="189" alt="image" src="https://github.com/user-attachments/assets/0703fc8d-a6a3-4300-871e-2537b543f2b5" />

---

## ✅ **Step 7: RIGHT JOIN / ALL COURSES**

```sql
select c.course_id, c.course_name, s.name
from courses c
left join enrollments e on c.course_id = e.course_id
left join students s on e.student_id = s.student_id;
```
<img width="875" height="350" alt="image" src="https://github.com/user-attachments/assets/ecab0179-978d-4178-9aad-5430d6b5fd2d" />

---

## ✅ **Step 8: JOIN with Departments**

```sql
select s.student_id, s.name, d.department_name
from students s
left join departments d on s.department_id = d.department_id;
```
<img width="881" height="348" alt="image" src="https://github.com/user-attachments/assets/2c67b7a3-9e43-4135-8f57-ad4701f66783" />

---

## ✅ **Step 9: CROSS JOIN**

```sql
select s.name, c.course_name
from students s
cross join courses c;
```
<img width="703" height="1111" alt="image" src="https://github.com/user-attachments/assets/5687d23e-cd4e-414f-bf02-7233e9ea9c0b" />

---

## 📥📤 **6. I/O Analysis (Input / Output)**

### 🔹 Input  
- Students table (student_id, name, department_id)  
- Courses table (course_id, course_name)  
- Enrollments table (student_id, course_id)  
- Departments table (department_id, department_name)  
- Relationships using primary and foreign keys  

### 🔹 Output  
- Students with their enrolled courses  
- Students not enrolled in any course  
- All courses with or without students  
- Students with department details  
- All possible student-course combinations  

📸 Screenshots of execution and obtained results are attached.

---

## 📘 **7. Learning Outcomes**

- Understanding different types of SQL JOINs  
- Ability to combine data from multiple related tables  
- Skill to identify matched and unmatched records  
- Improved query writing and data retrieval skills  
- Ability to apply JOIN concepts in real-world database problems  

---

## 📂 **Repository Contents**
- README.md  
- Worksheet (Word & PDF)  
- SQL Queries  
- Screenshots  

---
