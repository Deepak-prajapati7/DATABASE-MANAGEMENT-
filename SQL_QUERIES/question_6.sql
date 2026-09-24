-- ============================================================
-- QUESTION 2: COMPANY STAFF MERGER
-- ============================================================

CREATE DATABASE CompanyMergeDB;
USE CompanyMergeDB;


-- ============================================================
-- CREATE TABLES
-- ============================================================

CREATE TABLE STAFF_A (
    Emp_Code INT,
    Full_Name VARCHAR(100),
    Email VARCHAR(100),
    Dept VARCHAR(50)
);

CREATE TABLE STAFF_B (
    Emp_Code INT,
    Full_Name VARCHAR(100),
    Email VARCHAR(100),
    Dept VARCHAR(50)
);


-- ============================================================
-- INSERT SAMPLE DATA
-- ============================================================

INSERT INTO STAFF_A VALUES
(101, 'Rahul Sharma', 'rahul@gmail.com', 'IT'),
(102, 'Priya Singh', 'priya@gmail.com', 'HR'),
(103, 'Amit Kumar', 'amit@gmail.com', 'Finance'),
(104, 'Neha Gupta', 'neha@gmail.com', 'Marketing');

INSERT INTO STAFF_B VALUES
(201, 'Rahul Sharma', 'rahul@gmail.com', 'IT'),
(202, 'Ravi Verma', 'ravi@gmail.com', 'Sales'),
(203, 'Pooja Mehta', 'pooja@gmail.com', 'HR'),
(204, 'Amit Kumar', 'amit@gmail.com', 'Finance');


-- ============================================================
-- 2(a) EMAIL ADDRESSES THAT APPEAR IN BOTH COMPANIES
-- INTERSECT
-- ============================================================

SELECT Email
FROM STAFF_A

INTERSECT

SELECT Email
FROM STAFF_B;


-- ============================================================
-- 2(b) COMBINED STAFF DIRECTORY WITHOUT DUPLICATES
-- UNION + ORDER BY
-- ============================================================

SELECT Full_Name, Email, Dept
FROM STAFF_A

UNION

SELECT Full_Name, Email, Dept
FROM STAFF_B

ORDER BY Full_Name;


-- ============================================================
-- 2(c) COMPANY B EMPLOYEES WHOSE EMAIL DOES NOT
-- EXIST IN COMPANY A
--
-- USING EXCEPT
-- ============================================================

SELECT Full_Name, Email, Dept
FROM STAFF_B

EXCEPT

SELECT Full_Name, Email, Dept
FROM STAFF_A;


-- ============================================================
-- 2(c) SAME QUERY USING NOT EXISTS
-- ============================================================

SELECT b.Full_Name, b.Email, b.Dept
FROM STAFF_B b
WHERE NOT EXISTS
(
    SELECT 1
    FROM STAFF_A a
    WHERE a.Email = b.Email
);


-- ============================================================
-- 2(d) COMBINED DIRECTORY WITH SOURCE COLUMN
--
-- UNION ALL IS CORRECT BECAUSE 'A' AND 'B' ARE ADDED
-- AS SOURCE VALUES, SO ROWS FROM THE TWO COMPANIES
-- SHOULD NOT BE REMOVED AS DUPLICATES.
-- ============================================================

SELECT Full_Name, Email, Dept, 'A' AS Source
FROM STAFF_A

UNION ALL

SELECT Full_Name, Email, Dept, 'B' AS Source
FROM STAFF_B

ORDER BY Full_Name;


-- ============================================================
-- OPTIONAL: DISPLAY ORIGINAL TABLES
-- ============================================================

SELECT * FROM SPORTS_CLUB;

SELECT * FROM MUSIC_CLUB;

SELECT * FROM STAFF_A;

SELECT * FROM STAFF_B;