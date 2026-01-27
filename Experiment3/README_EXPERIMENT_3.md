# **DBMS Lab – Worksheet 3**  
## **Implementation of Conditional Logic using IF–ELSE and CASE Statements in PostgreSQL**

---

## 👨‍🎓 **Student Details**  
**Name:** Aryan Tomar  
**UID:** 25MCI10167  
**Branch:** MCA (AI & ML)  
**Semester:** 2nd  
**Section/Group:** 1/A  
**Subject:** DBMS Lab  
**Date of Performance:** 27/01/2026  

---

## 🎯 **Aim of the Session**  
To implement conditional decision-making logic in PostgreSQL using IF–ELSE constructs and CASE expressions for classification, validation, and rule-based data processing.

---

## 💻 **Software Requirements**  
- PostgreSQL (Database Server)  
- pgAdmin  
- Windows Operating System  

---

## 📌 **Objective of the Session**  
After completing this practical, the student will be able to:  
- Understand conditional execution in SQL  
- Implement decision-making logic using CASE expressions  
- Simulate real-world rule validation scenarios  
- Classify data based on multiple conditions  

---

## 🛠️ **Practical / Experiment Steps**  
- Create a table storing schema names and violation counts  
- Populate the table with multiple records  
- Classify data using CASE expressions  
- Apply conditional logic in UPDATE statements  
- Implement IF–ELSE logic using PL/pgSQL  
- Perform real-world classification (grading system)  
- Apply CASE for custom sorting  

---

# ⚙️ **Procedure of the Practical**

---

## ✅ **Step 1: Database Creation**

```sql
create database Practical3;
```

---

## ✅ **Step 2: Table Creation**

```sql
create table schema_audit(
schema_id serial primary key,
schema_name varchar(50),
violation_count int
);
```

---

## ✅ **Step 3: Insert Records**

```sql
insert into schema_audit(schema_name, violation_count) values
('UserDB', 0),
('FinanceDB', 2),
('SalesDB', 5),
('AuditDB', 9),
('BackupDB', 15);
```

---

## ✅ **Step 4: Display Records**

```sql
select * from schema_audit;
```
<img width="425" height="181" alt="Screenshot 2026-01-27 210557" src="https://github.com/user-attachments/assets/03518032-3db5-45cf-8147-803d05fb7272" />


---

## ✅ **Step 5: Classifying Data Using CASE**

```sql
select schema_name, violation_count,
case
 when violation_count = 0 then 'No Violation'
 when violation_count between 1 and 3 then 'Minor Violation'
 when violation_count between 4 and 7 then 'Moderate Violation'
 else 'Critical Violation'
end as violation_status
from schema_audit;
```
<img width="966" height="381" alt="image" src="https://github.com/user-attachments/assets/b29f89fd-7b37-48be-8dad-575f8e6296a9" />

---

## ✅ **Step 6: Applying CASE Logic in Data Updates**

```sql
alter table schema_audit add approval_status varchar(30);
```
<img width="988" height="311" alt="image" src="https://github.com/user-attachments/assets/bce431c4-bee2-4d21-8ca8-23704809b058" />

```sql
update schema_audit
set approval_status =
case
 when violation_count = 0 then 'Approved'
 when violation_count between 1 and 5 then 'Needs Review'
 else 'Rejected'
end;
```
<img width="1054" height="334" alt="image" src="https://github.com/user-attachments/assets/38b5d5bd-5465-49b7-b82c-0b49a329e8ad" />

---

## ✅ **Step 7: Implementing IF–ELSE Logic Using PL/pgSQL**

```sql
do $$
declare
 v_count int := 6;
begin
 if v_count = 0 then
  raise notice 'System is clean. No violations.';
 elseif v_count <= 5 then
  raise notice 'System has minor issues. Review required.';
 else
  raise notice 'System is critical. Immediate action required.';
 end if;
end $$;
```
<img width="978" height="615" alt="image" src="https://github.com/user-attachments/assets/66daf73b-ef19-49da-bc6b-3f00bff3e98c" />

---

## ✅ **Step 8: Real-World Classification Scenario (Grading System)**

```sql
create table students(
student_name varchar(30),
marks int
);
```

```sql
insert into students values
('Amit',85), ('Neha',72), ('Riya',64), ('Karan',45), ('Rohit',32);
```
<img width="539" height="351" alt="image" src="https://github.com/user-attachments/assets/534abb8d-3cc0-497a-b948-74b14cd5e929" />

```sql
select student_name, marks,
case
 when marks >= 80 then 'A Grade'
 when marks >= 60 then 'B Grade'
 when marks >= 40 then 'C Grade'
 else 'Fail'
end as grade
from students;
```
<img width="680" height="355" alt="image" src="https://github.com/user-attachments/assets/086e3091-650a-439d-8e05-66eb76dafbd6" />

---

## ✅ **Step 9: Using CASE for Custom Sorting**

```sql
select schema_name, violation_count, approval_status
from schema_audit
order by
case
 when violation_count = 0 then 1
 when violation_count between 1 and 3 then 2
 when violation_count between 4 and 7 then 3
 else 4
end;
```
<img width="933" height="345" alt="image" src="https://github.com/user-attachments/assets/efad728d-11b6-4ad1-a46d-6a7229b8712e" />

---

## 📥📤 **6. I/O Analysis (Input / Output)**

### 🔹 Input  
- Schema violation data  
- CASE expressions  
- ALTER and UPDATE commands  
- PL/pgSQL IF–ELSE block  
- Student grading queries  
- Custom sorting queries  

### 🔹 Output  
- Schemas classified into violation categories  
- Automatic approval status generated  
- Conditional system messages displayed  
- Students categorized into grades  
- Priority-based sorted records displayed  
- Successful execution of conditional SQL logic  

📸 Screenshots of execution and obtained results are attached.

---

## 📘 **7. Learning Outcomes**

After completing this experiment, the student has:  
- Understood conditional logic in PostgreSQL using CASE expressions  
- Implemented rule-based decision logic inside SQL queries  
- Gained hands-on experience with IF–ELSE constructs  
- Developed the ability to classify and validate data  
- Practiced real-world scenarios such as compliance checks and grading systems  
- Improved logical thinking for backend development and interviews  
- Built confidence in writing analytical and rule-based SQL queries  

---

## 📂 **Repository Contents**
- README.md  
- Worksheet (Word & PDF)  
- SQL Queries  
- Screenshots  

---
