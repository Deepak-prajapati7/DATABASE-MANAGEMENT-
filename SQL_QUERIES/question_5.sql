-- ============================================================
-- QUESTION 1: UNIVERSITY CLUB MEMBERSHIP
-- ============================================================

CREATE DATABASE UniversityDB;
USE UniversityDB;


-- ============================================================
-- CREATE TABLES
-- ============================================================

CREATE TABLE SPORTS_CLUB (
    Roll_No INT,
    Student_Name VARCHAR(50),
    Year INT
);

CREATE TABLE MUSIC_CLUB (
    Roll_No INT,
    Student_Name VARCHAR(50),
    Year INT
);


-- ============================================================
-- INSERT SAMPLE DATA
-- Three students are members of BOTH clubs
-- ============================================================

INSERT INTO SPORTS_CLUB VALUES
(101, 'Rahul', 1),
(102, 'Priya', 2),
(103, 'Amit', 1),
(104, 'Neha', 3),
(105, 'Ravi', 2),
(106, 'Sneha', 1);

INSERT INTO MUSIC_CLUB VALUES
(103, 'Amit', 1),
(104, 'Neha', 3),
(105, 'Ravi', 2),
(107, 'Karan', 2),
(108, 'Pooja', 1);


-- ============================================================
-- 1(a) STUDENTS IN AT LEAST ONE CLUB
-- UNION
-- ============================================================

SELECT Roll_No, Student_Name, Year
FROM SPORTS_CLUB

UNION

SELECT Roll_No, Student_Name, Year
FROM MUSIC_CLUB;


-- ============================================================
-- 1(a) STUDENTS IN BOTH CLUBS
-- INTERSECT
-- ============================================================

SELECT Roll_No, Student_Name, Year
FROM SPORTS_CLUB

INTERSECT

SELECT Roll_No, Student_Name, Year
FROM MUSIC_CLUB;


-- ============================================================
-- 1(a) STUDENTS ONLY IN SPORTS CLUB
-- EXCEPT
-- ============================================================

SELECT Roll_No, Student_Name, Year
FROM SPORTS_CLUB

EXCEPT

SELECT Roll_No, Student_Name, Year
FROM MUSIC_CLUB;


-- ============================================================
-- 1(a) STUDENTS IN EXACTLY ONE CLUB
-- (SPORTS EXCEPT MUSIC) UNION (MUSIC EXCEPT SPORTS)
-- ============================================================

SELECT Roll_No, Student_Name, Year
FROM SPORTS_CLUB

EXCEPT

SELECT Roll_No, Student_Name, Year
FROM MUSIC_CLUB

UNION

SELECT Roll_No, Student_Name, Year
FROM MUSIC_CLUB

EXCEPT

SELECT Roll_No, Student_Name, Year
FROM SPORTS_CLUB;


-- ============================================================
-- 1(b) UNION vs UNION ALL
--
-- SPORTS_CLUB = 40 rows
-- MUSIC_CLUB = 25 rows
-- COMMON = 3 students
--
-- UNION     = 40 + 25 - 3 = 62 rows
-- UNION ALL = 40 + 25     = 65 rows
-- ============================================================

-- UNION
SELECT Roll_No, Student_Name, Year
FROM SPORTS_CLUB

UNION

SELECT Roll_No, Student_Name, Year
FROM MUSIC_CLUB;


-- UNION ALL
SELECT Roll_No, Student_Name, Year
FROM SPORTS_CLUB

UNION ALL

SELECT Roll_No, Student_Name, Year
FROM MUSIC_CLUB;


-- ============================================================
-- 1(c) INCORRECT QUERY
--
-- SELECT Roll_No, Student_Name FROM SPORTS_CLUB
-- UNION
-- SELECT Roll_No FROM MUSIC_CLUB;
--
-- ERROR: Both SELECT statements of UNION must have the
-- same number of columns.
--
-- CORRECT QUERY:
-- ============================================================

SELECT Roll_No, Student_Name
FROM SPORTS_CLUB

UNION

SELECT Roll_No, Student_Name
FROM MUSIC_CLUB;


