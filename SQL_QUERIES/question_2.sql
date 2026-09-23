-- =========================================================
-- QUESTION 2 : COMPANY STAFF DATABASE
-- =========================================================

-- 1. Create Database
CREATE DATABASE CompanyDB;

-- 2. Use Database
USE CompanyDB;


-- =========================================================
-- 3. Create STAFF_A Table
-- =========================================================

CREATE TABLE STAFF_A (
    Emp_Code INT PRIMARY KEY,
    Full_Name VARCHAR(50),
    Email VARCHAR(100),
    Dept VARCHAR(50)
);


-- =========================================================
-- 4. Create STAFF_B Table
-- =========================================================

CREATE TABLE STAFF_B (
    Emp_Code INT PRIMARY KEY,
    Full_Name VARCHAR(50),
    Email VARCHAR(100),
    Dept VARCHAR(50)
);


-- =========================================================
-- 5. Insert Data into STAFF_A
-- =========================================================

INSERT INTO STAFF_A (Emp_Code, Full_Name, Email, Dept)
VALUES
(1001, 'Amit Sharma', 'amit@gmail.com', 'IT'),
(1002, 'Rahul Verma', 'rahul@gmail.com', 'HR'),
(1003, 'Priya Singh', 'priya@gmail.com', 'Finance'),
(1004, 'Neha Gupta', 'neha@gmail.com', 'Sales'),
(1005, 'Rohit Kumar', 'rohit@gmail.com', 'IT'),
(1006, 'Anjali Mehta', 'anjali@gmail.com', 'HR');


-- =========================================================
-- 6. Insert Data into STAFF_B
-- =========================================================

-- Amit, Rahul and Priya also exist in Company B
-- with the same email addresses.

INSERT INTO STAFF_B (Emp_Code, Full_Name, Email, Dept)
VALUES
(2001, 'Amit Sharma', 'amit@gmail.com', 'IT'),
(2002, 'Rahul Verma', 'rahul@gmail.com', 'HR'),
(2003, 'Priya Singh', 'priya@gmail.com', 'Finance'),
(2004, 'Karan Joshi', 'karan@gmail.com', 'IT'),
(2005, 'Sneha Jain', 'sneha@gmail.com', 'Marketing'),
(2006, 'Vikas Yadav', 'vikas@gmail.com', 'Sales');


-- =========================================================
-- QUESTION 2(a)
-- E-mail addresses that appear in BOTH companies
-- =========================================================

SELECT Email
FROM STAFF_A

INTERSECT

SELECT Email
FROM STAFF_B;


-- Expected common emails:
-- amit@gmail.com
-- rahul@gmail.com
-- priya@gmail.com


-- =========================================================
-- QUESTION 2(b)
-- One combined staff directory without duplicates
-- Sorted by Full_Name
-- =========================================================

SELECT Full_Name, Email, Dept
FROM STAFF_A

UNION

SELECT Full_Name, Email, Dept
FROM STAFF_B

ORDER BY Full_Name;


-- =========================================================
-- QUESTION 2(c)
-- Employees of Company B whose email does NOT
-- exist in Company A
-- =========================================================


-- Method 1: Using EXCEPT
-- First find emails present in B but not in A.

SELECT Email
FROM STAFF_B

EXCEPT

SELECT Email
FROM STAFF_A;


-- Complete employee details using EXCEPT:

SELECT Full_Name, Email, Dept
FROM STAFF_B
WHERE Email IN
(
    SELECT Email
    FROM STAFF_B

    EXCEPT

    SELECT Email
    FROM STAFF_A
);


-- Method 2: Using NOT EXISTS
-- This works for databases that do not support EXCEPT.

SELECT B.Full_Name, B.Email, B.Dept
FROM STAFF_B AS B
WHERE NOT EXISTS
(
    SELECT 1
    FROM STAFF_A AS A
    WHERE A.Email = B.Email
);


-- Expected employees:
-- Karan Joshi
-- Sneha Jain
-- Vikas Yadav


-- =========================================================
-- QUESTION 2(d)
-- Add a Source column showing 'A' or 'B'
-- =========================================================

SELECT Full_Name, Email, Dept, 'A' AS Source
FROM STAFF_A

UNION ALL

SELECT Full_Name, Email, Dept, 'B' AS Source
FROM STAFF_B;


-- =========================================================
-- QUESTION 2(d) WITH SORTING
-- If the combined directory also needs to be sorted
-- =========================================================

SELECT Full_Name, Email, Dept, 'A' AS Source
FROM STAFF_A

UNION ALL

SELECT Full_Name, Email, Dept, 'B' AS Source
FROM STAFF_B

ORDER BY Full_Name;