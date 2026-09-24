-- ============================================================
-- QUESTION 2: HOSPITAL DATABASE
-- ============================================================

-- Create Database
CREATE DATABASE HospitalDB;

-- Use Database
USE HospitalDB;


-- ============================================================
-- 1. CREATE TABLES
-- ============================================================

CREATE TABLE DOCTOR (
    Doc_ID INT PRIMARY KEY,
    Doc_Name VARCHAR(50),
    Specialization VARCHAR(50)
);

CREATE TABLE PATIENT (
    Pat_ID INT PRIMARY KEY,
    Pat_Name VARCHAR(50),
    Doc_ID INT,
    Admit_Date DATE,
    Bill_Amount DECIMAL(10,2),
    FOREIGN KEY (Doc_ID) REFERENCES DOCTOR(Doc_ID)
);


-- ============================================================
-- 2. INSERT DATA INTO DOCTOR
-- ============================================================

INSERT INTO DOCTOR (Doc_ID, Doc_Name, Specialization)
VALUES
(101, 'Dr. Sharma', 'Cardiology'),
(102, 'Dr. Mehta', 'Neurology'),
(103, 'Dr. Verma', 'Orthopedics'),
(104, 'Dr. Gupta', 'Cardiology'),
(105, 'Dr. Singh', 'Pediatrics');


-- ============================================================
-- 3. INSERT DATA INTO PATIENT
-- ============================================================

INSERT INTO PATIENT
(Pat_ID, Pat_Name, Doc_ID, Admit_Date, Bill_Amount)
VALUES
(1, 'Aarav', 101, '2024-01-10', 25000),
(2, 'Riya', 101, '2024-01-15', 15000),
(3, 'Karan', 101, '2024-02-01', 12000),

(4, 'Ananya', 102, '2024-02-05', 30000),
(5, 'Rohan', 102, '2024-02-10', 18000),

(6, 'Vikas', 103, '2024-03-01', 8000),
(7, 'Pooja', 103, '2024-03-05', 12000),

(8, 'Neha', 104, '2024-03-10', 60000),
(9, 'Raj', 104, '2024-03-15', 55000),

(10, 'Simran', 105, '2024-04-01', 15000),
(11, 'Aditya', 105, '2024-04-05', 11000);


-- ============================================================
-- DISPLAY TABLES
-- ============================================================

SELECT * FROM DOCTOR;

SELECT * FROM PATIENT;


-- ============================================================
-- QUESTION 2(a)
-- Using a CORRELATED SUBQUERY, list patients whose bill
-- is higher than the average bill of all patients treated
-- by the SAME doctor.
--
-- TYPE: CORRELATED SUBQUERY
-- ============================================================

SELECT p.Pat_ID,
       p.Pat_Name,
       p.Doc_ID,
       p.Bill_Amount
FROM PATIENT p
WHERE p.Bill_Amount >
(
    SELECT AVG(p2.Bill_Amount)
    FROM PATIENT p2
    WHERE p2.Doc_ID = p.Doc_ID
);


-- ============================================================
-- QUESTION 2(b)
-- Using ALL, list doctors for whom EVERY patient has a bill
-- above 10000.
--
-- TYPE: NON-CORRELATED SUBQUERY
-- ============================================================

SELECT d.Doc_ID,
       d.Doc_Name,
       d.Specialization
FROM DOCTOR d
WHERE 10000 < ALL
(
    SELECT p.Bill_Amount
    FROM PATIENT p
    WHERE p.Doc_ID = d.Doc_ID
);


-- ============================================================
-- QUESTION 2(b)
-- SAME QUERY USING NOT EXISTS
--
-- TYPE: CORRELATED SUBQUERY
-- ============================================================

SELECT d.Doc_ID,
       d.Doc_Name,
       d.Specialization
FROM DOCTOR d
WHERE NOT EXISTS
(
    SELECT 1
    FROM PATIENT p
    WHERE p.Doc_ID = d.Doc_ID
      AND p.Bill_Amount <= 10000
);


-- ============================================================
-- QUESTION 2(c)
-- Using a SUBQUERY IN THE FROM CLAUSE, show each
-- specialization with:
-- 1. Number of doctors
-- 2. Total bill amount collected
--
-- Only specializations whose total bill is > 100000.
-- ============================================================

SELECT Specialization,
       Number_of_Doctors,
       Total_Bill
FROM
(
    SELECT d.Specialization,
           COUNT(DISTINCT d.Doc_ID) AS Number_of_Doctors,
           COALESCE(SUM(p.Bill_Amount), 0) AS Total_Bill
    FROM DOCTOR d
    LEFT JOIN PATIENT p
        ON d.Doc_ID = p.Doc_ID
    GROUP BY d.Specialization
) AS specialization_summary
WHERE Total_Bill > 100000;


-- ============================================================
-- QUESTION 2(d)
-- EXPLANATION
-- ============================================================

/*
For each of the 1,000 patients, the correlated subquery
calculates the average bill of patients treated by that
patient's doctor.

The outer query then compares the patient's bill with that
doctor-specific average. Therefore, conceptually, the
subquery may be evaluated once for each outer patient,
although the database optimizer may internally optimize
the execution using other techniques.
*/


-- ============================================================
-- OPTIONAL: SHOW AVERAGE BILL FOR EACH DOCTOR
-- This helps to verify Question 2(a)
-- ============================================================

SELECT d.Doc_ID,
       d.Doc_Name,
       AVG(p.Bill_Amount) AS Average_Bill
FROM DOCTOR d
JOIN PATIENT p
    ON d.Doc_ID = p.Doc_ID
GROUP BY d.Doc_ID, d.Doc_Name;


-- ============================================================
-- OPTIONAL: SHOW TOTAL BILL FOR EACH SPECIALIZATION
-- This helps to verify Question 2(c)
-- ============================================================

SELECT d.Specialization,
       COUNT(DISTINCT d.Doc_ID) AS Number_of_Doctors,
       SUM(p.Bill_Amount) AS Total_Bill
FROM DOCTOR d
JOIN PATIENT p
    ON d.Doc_ID = p.Doc_ID
GROUP BY d.Specialization;