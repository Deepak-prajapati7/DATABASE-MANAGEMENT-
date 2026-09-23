-- ============================================
-- QUESTION 1 : CLUB MEMBERSHIP DATABASE
-- ============================================

-- 1. Create Database
CREATE DATABASE University;

-- 2. Use Database
USE University;


-- ============================================
-- 3. Create SPORTS_CLUB Table
-- ============================================

CREATE TABLE SPORTS_CLUB (
    Roll_No INT PRIMARY KEY,
    Student_Name VARCHAR(50),
    Year INT
);


-- ============================================
-- 4. Create MUSIC_CLUB Table
-- ============================================

CREATE TABLE MUSIC_CLUB (
    Roll_No INT PRIMARY KEY,
    Student_Name VARCHAR(50),
    Year INT
);


-- ============================================
-- 5. Insert Data into SPORTS_CLUB
-- ============================================

INSERT INTO SPORTS_CLUB (Roll_No, Student_Name, Year)
VALUES
(101, 'Amit Sharma', 1),
(102, 'Rahul Verma', 1),
(103, 'Priya Singh', 2),
(104, 'Neha Gupta', 2),
(105, 'Rohit Kumar', 3),
(106, 'Anjali Mehta', 3),
(107, 'Karan Joshi', 1),
(108, 'Sneha Jain', 2),
(109, 'Vikas Yadav', 3),
(110, 'Pooja Sharma', 1);


-- ============================================
-- 6. Insert Data into MUSIC_CLUB
-- ============================================

-- 101, 102 and 103 are common students
-- in both clubs.

INSERT INTO MUSIC_CLUB (Roll_No, Student_Name, Year)
VALUES
(101, 'Amit Sharma', 1),
(102, 'Rahul Verma', 1),
(103, 'Priya Singh', 2),
(111, 'Arjun Patel', 2),
(112, 'Riya Kapoor', 3),
(113, 'Mohit Saini', 1),
(114, 'Simran Kaur', 2),
(115, 'Nikhil Jain', 3);


-- ============================================
-- QUESTION 1(a)
-- ============================================


-- 1. Students in AT LEAST ONE club
-- UNION removes duplicate students.

SELECT Roll_No, Student_Name, Year
FROM SPORTS_CLUB

UNION

SELECT Roll_No, Student_Name, Year
FROM MUSIC_CLUB;


-- 2. Students who are in BOTH clubs
-- INTERSECT returns common students.

SELECT Roll_No, Student_Name, Year
FROM SPORTS_CLUB

INTERSECT

SELECT Roll_No, Student_Name, Year
FROM MUSIC_CLUB;


-- 3. Students ONLY in SPORTS CLUB
-- EXCEPT removes students who are also
-- present in MUSIC_CLUB.

SELECT Roll_No, Student_Name, Year
FROM SPORTS_CLUB

EXCEPT

SELECT Roll_No, Student_Name, Year
FROM MUSIC_CLUB;


-- 4. Students ONLY in MUSIC CLUB

SELECT Roll_No, Student_Name, Year
FROM MUSIC_CLUB

EXCEPT

SELECT Roll_No, Student_Name, Year
FROM SPORTS_CLUB;


-- 5. Students in EXACTLY ONE club
-- Sports-only UNION Music-only

(
    SELECT Roll_No, Student_Name, Year
    FROM SPORTS_CLUB

    EXCEPT

    SELECT Roll_No, Student_Name, Year
    FROM MUSIC_CLUB
)

UNION

(
    SELECT Roll_No, Student_Name, Year
    FROM MUSIC_CLUB

    EXCEPT

    SELECT Roll_No, Student_Name, Year
    FROM SPORTS_CLUB
);


-- ============================================
-- QUESTION 1(b)
-- UNION vs UNION ALL
-- ============================================


-- UNION removes duplicates

SELECT Roll_No, Student_Name, Year
FROM SPORTS_CLUB

UNION

SELECT Roll_No, Student_Name, Year
FROM MUSIC_CLUB;


-- UNION ALL keeps duplicates

SELECT Roll_No, Student_Name, Year
FROM SPORTS_CLUB

UNION ALL

SELECT Roll_No, Student_Name, Year
FROM MUSIC_CLUB;


-- ============================================
-- QUESTION 1(c)
-- ============================================


-- WRONG QUERY:
-- The first SELECT has 2 columns,
-- while the second SELECT has only 1 column.
--
-- SELECT Roll_No, Student_Name
-- FROM SPORTS_CLUB
-- UNION
-- SELECT Roll_No
-- FROM MUSIC_CLUB;


-- CORRECT QUERY:
-- Both SELECT statements must have
-- the same number of columns.

SELECT Roll_No, Student_Name
FROM SPORTS_CLUB

UNION

SELECT Roll_No, Student_Name
FROM MUSIC_CLUB;