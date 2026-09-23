-- ============================================
-- COLLEGE MANAGEMENT SYSTEM
-- COMPLETE SCRIPT FROM START
-- ============================================

-- 1. Delete old database
DROP DATABASE IF EXISTS college_management;

-- 2. Create database
CREATE DATABASE college_management;

-- 3. Select database
USE college_management;


-- ============================================
-- 4. CREATE DEPARTMENT TABLE
-- ============================================

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);


-- ============================================
-- 5. CREATE STUDENT TABLE
-- ============================================

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department_id INT,
    age INT,
    FOREIGN KEY (department_id)
        REFERENCES Department(department_id)
);


-- ============================================
-- 6. CREATE COURSE TABLE
-- ============================================

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES Department(department_id)
);


-- ============================================
-- 7. CREATE ENROLLMENT TABLE
-- ============================================

CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks INT,
    FOREIGN KEY (student_id)
        REFERENCES Student(student_id),
    FOREIGN KEY (course_id)
        REFERENCES Course(course_id)
);


-- ============================================
-- 8. CREATE EMPLOYEE TABLE
-- ============================================

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT
);


-- ============================================
-- 9. INSERT DEPARTMENTS
-- ============================================

INSERT INTO Department
(department_id, department_name, location)
VALUES
(1, 'Computer Science', 'Delhi'),
(2, 'Mechanical', 'Mumbai'),
(3, 'Electronics', 'Pune'),
(4, 'Civil', 'Jaipur'),
(5, 'Management', 'Gurgaon'),
(6, 'Physics', 'Kolkata');


-- ============================================
-- 10. INSERT STUDENTS
-- ============================================

INSERT INTO Student
(student_id, student_name, department_id, age)
VALUES
(101, 'Rahul', 1, 20),
(102, 'Priya', 1, 21),
(103, 'Amit', 2, 22),
(104, 'Neha', 3, 20),
(105, 'Rohan', NULL, 23),
(106, 'Sneha', 4, 21);


-- ============================================
-- 11. INSERT COURSES
-- ============================================

INSERT INTO Course
(course_id, course_name, department_id)
VALUES
(201, 'Database Systems', 1),
(202, 'Python Programming', 1),
(203, 'Thermodynamics', 2),
(204, 'Digital Electronics', 3),
(205, 'Structural Engineering', 4),
(206, 'Marketing Management', 5);


-- ============================================
-- 12. INSERT ENROLLMENTS
-- ============================================

INSERT INTO Enrollment
(enrollment_id, student_id, course_id, marks)
VALUES
(1, 101, 201, 85),
(2, 101, 202, 78),
(3, 102, 201, 92),
(4, 103, 203, 67),
(5, 104, 204, 35),
(6, 106, 205, 88);


-- ============================================
-- 13. INSERT EMPLOYEES
-- ============================================

INSERT INTO Employee
(emp_id, emp_name, manager_id)
VALUES
(1, 'Amit', NULL),
(2, 'Rahul', 1),
(3, 'Priya', 1),
(4, 'Neha', 2),
(5, 'Rohan', 2);


-- ============================================
-- 14. CHECK ALL TABLES
-- ============================================

SELECT * FROM Department;

SELECT * FROM Student;

SELECT * FROM Course;

SELECT * FROM Enrollment;

-- =====================================================
-- Q1. Display student names along with their department names.
-- =====================================================

SELECT s.student_name,
       d.department_name
FROM Student s
INNER JOIN Department d
ON s.department_id = d.department_id;


-- =====================================================
-- Q2. Display all students and their corresponding department locations.
-- =====================================================

SELECT s.student_name,
       d.location
FROM Student s
LEFT JOIN Department d
ON s.department_id = d.department_id;


-- =====================================================
-- Q3. Display the details of all courses along with their department names.
-- =====================================================

SELECT c.course_id,
       c.course_name,
       d.department_name
FROM Course c
INNER JOIN Department d
ON c.department_id = d.department_id;


-- =====================================================
-- Q4. Display student name, course name, and marks obtained by each student.
-- =====================================================

SELECT s.student_name,
       c.course_name,
       e.marks
FROM Student s
INNER JOIN Enrollment e
ON s.student_id = e.student_id
INNER JOIN Course c
ON e.course_id = c.course_id;


-- =====================================================
-- Q5. Display all students who are enrolled in courses.
-- =====================================================

SELECT DISTINCT s.student_id,
       s.student_name
FROM Student s
INNER JOIN Enrollment e
ON s.student_id = e.student_id;


-- =====================================================
-- Q6. Use INNER JOIN to display Student_Name and Department_Name.
-- =====================================================

SELECT s.student_name AS Student_Name,
       d.department_name AS Department_Name
FROM Student s
INNER JOIN Department d
ON s.department_id = d.department_id;


-- =====================================================
-- Q7. Find the details of students belonging to the
--     "Computer Science" department.
-- =====================================================

SELECT s.*
FROM Student s
INNER JOIN Department d
ON s.department_id = d.department_id
WHERE d.department_name = 'Computer Science';


-- =====================================================
-- Q8. Display Student Name, Course Name and Marks
--     for all enrolled students.
-- =====================================================

SELECT s.student_name AS Student_Name,
       c.course_name AS Course_Name,
       e.marks AS Marks
FROM Student s
INNER JOIN Enrollment e
ON s.student_id = e.student_id
INNER JOIN Course c
ON e.course_id = c.course_id;


-- =====================================================
-- Q9. Display department-wise student details
--     using INNER JOIN.
-- =====================================================

SELECT d.department_name,
       s.student_id,
       s.student_name,
       s.age
FROM Department d
INNER JOIN Student s
ON d.department_id = s.department_id
ORDER BY d.department_name;


-- =====================================================
-- Q10. Display all students along with their department
--      names, including students who do not belong
--      to any department.
-- =====================================================

SELECT s.student_id,
       s.student_name,
       d.department_name
FROM Student s
LEFT JOIN Department d
ON s.department_id = d.department_id;


-- =====================================================
-- Q11. Find students who are not enrolled in any course.
-- =====================================================

SELECT s.student_id,
       s.student_name
FROM Student s
LEFT JOIN Enrollment e
ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;


-- =====================================================
-- Q12. Display all departments and the students
--      belonging to them, including departments
--      with no students.
-- =====================================================

SELECT d.department_id,
       d.department_name,
       s.student_id,
       s.student_name
FROM Department d
LEFT JOIN Student s
ON d.department_id = s.department_id;


-- =====================================================
-- Q13. Display all courses along with enrolled students,
--      including courses having no enrollment.
-- =====================================================

SELECT c.course_id,
       c.course_name,
       s.student_id,
       s.student_name
FROM Course c
LEFT JOIN Enrollment e
ON c.course_id = e.course_id
LEFT JOIN Student s
ON e.student_id = s.student_id;


-- =====================================================
-- Q14. Display all departments and their students
--      using RIGHT JOIN.
-- =====================================================

SELECT d.department_id,
       d.department_name,
       s.student_id,
       s.student_name
FROM Student s
RIGHT JOIN Department d
ON s.department_id = d.department_id;


-- =====================================================
-- Q15. Display all courses and their enrolled students
--      using RIGHT JOIN.
-- =====================================================

SELECT c.course_id,
       c.course_name,
       s.student_id,
       s.student_name
FROM Enrollment e
RIGHT JOIN Course c
ON e.course_id = c.course_id
LEFT JOIN Student s
ON e.student_id = s.student_id;


-- =====================================================
-- Q16. Display complete student course information:
--      Student Name, Department Name, Course Name, Marks
-- =====================================================

SELECT s.student_name AS Student_Name,
       d.department_name AS Department_Name,
       c.course_name AS Course_Name,
       e.marks AS Marks
FROM Student s
INNER JOIN Department d
ON s.department_id = d.department_id
INNER JOIN Enrollment e
ON s.student_id = e.student_id
INNER JOIN Course c
ON e.course_id = c.course_id;


-- =====================================================
-- Q17. Display Student Name, Department Location
--      and Course Name using multiple JOIN operations.
-- =====================================================

SELECT s.student_name AS Student_Name,
       d.location AS Department_Location,
       c.course_name AS Course_Name
FROM Student s
INNER JOIN Department d
ON s.department_id = d.department_id
INNER JOIN Enrollment e
ON s.student_id = e.student_id
INNER JOIN Course c
ON e.course_id = c.course_id;


-- =====================================================
-- Q18. Find the average marks obtained by students
--      in each course along with the course name.
-- =====================================================

SELECT c.course_name,
       AVG(e.marks) AS Average_Marks
FROM Course c
INNER JOIN Enrollment e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;


-- =====================================================
-- Q19. Display department-wise:
--      Department Name and Number of Students
--      using JOIN and GROUP BY.
-- =====================================================

SELECT d.department_name,
       COUNT(s.student_id) AS Number_of_Students
FROM Department d
LEFT JOIN Student s
ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name;


-- =====================================================
-- Q20. Display Department Name, Course Name
--      and Number of Students Enrolled.
-- =====================================================

SELECT d.department_name,
       c.course_name,
       COUNT(e.student_id) AS Number_of_Students_Enrolled
FROM Department d
INNER JOIN Course c
ON d.department_id = c.department_id
LEFT JOIN Enrollment e
ON c.course_id = e.course_id
GROUP BY d.department_id,
         d.department_name,
         c.course_id,
         c.course_name;


-- =====================================================
-- Q21. Find the student who scored the highest marks
--      in each course.
-- =====================================================

SELECT c.course_name,
       s.student_name,
       e.marks
FROM Enrollment e
INNER JOIN Student s
ON e.student_id = s.student_id
INNER JOIN Course c
ON e.course_id = c.course_id
LEFT JOIN Enrollment e2
ON e.course_id = e2.course_id
AND e.marks < e2.marks
WHERE e2.enrollment_id IS NULL;


-- =====================================================
-- Q22. Display departments where no student is registered.
-- =====================================================

SELECT d.department_id,
       d.department_name
FROM Department d
LEFT JOIN Student s
ON d.department_id = s.department_id
WHERE s.student_id IS NULL;


-- =====================================================
-- Q23. Display courses in which no student has enrolled.
-- =====================================================

SELECT c.course_id,
       c.course_name
FROM Course c
LEFT JOIN Enrollment e
ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;


-- =====================================================
-- Q24. Find the total number of students in each department.
-- =====================================================

SELECT d.department_name,
       COUNT(s.student_id) AS Total_Students
FROM Department d
LEFT JOIN Student s
ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name;


-- =====================================================
-- Q25. Display the complete report:
--      Student ID, Student Name, Department, Course,
--      Marks and Result Status.
--      Marks >= 40 = Pass
--      Marks < 40 = Fail
-- =====================================================

SELECT s.student_id,
       s.student_name,
       d.department_name AS Department,
       c.course_name AS Course,
       e.marks AS Marks,
       CASE
           WHEN e.marks >= 40 THEN 'Pass'
           ELSE 'Fail'
       END AS Result_Status
FROM Student s
INNER JOIN Department d
ON s.department_id = d.department_id
INNER JOIN Enrollment e
ON s.student_id = e.student_id
INNER JOIN Course c
ON e.course_id = c.course_id;


-- =====================================================
-- Q26. Display employee name with their manager name
--      using SELF JOIN.
-- =====================================================

SELECT e.emp_name AS Employee,
       m.emp_name AS Manager
FROM Employee e
LEFT JOIN Employee m
ON e.manager_id = m.emp_id;


-- =====================================================
-- Q27. Find departments having more than 5 students
--      using JOIN and GROUP BY.
-- =====================================================

SELECT d.department_name,
       COUNT(s.student_id) AS Number_of_Students
FROM Department d
INNER JOIN Student s
ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(s.student_id) > 5;


-- =====================================================
-- Q28. Find the second highest marks obtained by students
--      using JOIN.
-- =====================================================

SELECT DISTINCT e1.marks AS Second_Highest_Marks
FROM Enrollment e1
INNER JOIN Enrollment e2
ON e1.marks < e2.marks
LEFT JOIN Enrollment e3
ON e3.marks > e1.marks
AND e3.marks < e2.marks
WHERE e3.enrollment_id IS NULL
ORDER BY e1.marks DESC
LIMIT 1;


-- =====================================================
-- Q29. Display students who have enrolled in
--      more than one course.
-- =====================================================

SELECT s.student_id,
       s.student_name,
       COUNT(e.course_id) AS Number_of_Courses
FROM Student s
INNER JOIN Enrollment e
ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name
HAVING COUNT(e.course_id) > 1;


-- =====================================================
-- Q30. Generate a complete college report showing:
--      Department -> Students -> Courses -> Marks
--      using appropriate JOIN operations.
-- =====================================================

SELECT d.department_name AS Department,
       s.student_name AS Student,
       c.course_name AS Course,
       e.marks AS Marks
FROM Department d
LEFT JOIN Student s
ON d.department_id = s.department_id
LEFT JOIN Enrollment e
ON s.student_id = e.student_id
LEFT JOIN Course c
ON e.course_id = c.course_id
ORDER BY d.department_name,
         s.student_name,
         c.course_name;