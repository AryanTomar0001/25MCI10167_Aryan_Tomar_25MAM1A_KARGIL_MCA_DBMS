CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

select * from enrollments;


INSERT INTO departments VALUES
(1, 'Computer Science'),
(2, 'Mechanical'),
(3, 'Electrical');

INSERT INTO students VALUES
(1, 'Aryan', 1),
(2, 'Rohit', 2),
(3, 'Priya', 1),
(4, 'Simran', 3),
(5, 'Karan', NULL);


INSERT INTO courses VALUES
(101, 'DBMS'),
(102, 'OS'),
(103, 'Maths'),
(104, 'Physics');


INSERT INTO enrollments VALUES
(1, 101),
(1, 102),
(2, 103),
(3, 101);


select 
s.student_id,s.name,c.course_name
from students s
left join enrollments e on
e.student_id=e.student_id
left join courses c on
e.course_id=c.course_id;


select 
s.student_id,s.name
from 
students s 
left join enrollments e on
s.student_id =e.student_id
where e.student_id is null;


SELECT c.course_id, c.course_name, s.name
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
LEFT JOIN students s ON e.student_id = s.student_id;



SELECT s.student_id, s.name, d.department_name
FROM students s
LEFT JOIN departments d ON s.department_id = d.department_id


SELECT s.name, c.course_name
FROM students s
CROSS JOIN courses c;
