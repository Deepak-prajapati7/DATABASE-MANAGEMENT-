-- ============================================================
-- QUESTION 1: ONLINE STORE
-- ============================================================

-- Create Database
CREATE DATABASE OnlineStore;

-- Use Database
USE OnlineStore;


-- ============================================================
-- 1. CREATE TABLES
-- ============================================================

CREATE TABLE CUSTOMER (
    Cust_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50),
    Join_Date DATE
);

CREATE TABLE ORDERS (
    Order_ID INT PRIMARY KEY,
    Cust_ID INT,
    Order_Date DATE,
    Amount DECIMAL(10,2),
    FOREIGN KEY (Cust_ID) REFERENCES CUSTOMER(Cust_ID)
);


-- ============================================================
-- 2. INSERT DATA INTO CUSTOMER
-- ============================================================

INSERT INTO CUSTOMER (Cust_ID, Name, City, Join_Date)
VALUES
(1, 'Rahul', 'Delhi', '2024-01-10'),
(2, 'Priya', 'Mumbai', '2024-02-15'),
(3, 'Amit', 'Delhi', '2024-03-20'),
(4, 'Neha', 'Mumbai', '2024-04-05'),
(5, 'Ravi', 'Pune', '2024-05-12'),
(6, 'Sneha', 'Delhi', '2024-06-18');


-- ============================================================
-- 3. INSERT DATA INTO ORDERS
-- ============================================================

INSERT INTO ORDERS (Order_ID, Cust_ID, Order_Date, Amount)
VALUES
(101, 1, '2024-07-01', 25000),
(102, 1, '2024-07-15', 15000),
(103, 2, '2024-07-05', 12000),
(104, 3, '2024-07-10', 30000),
(105, 4, '2024-07-20', 8000),
(106, 5, '2024-07-25', 18000);


-- ============================================================
-- DISPLAY TABLES
-- ============================================================

SELECT * FROM CUSTOMER;

SELECT * FROM ORDERS;


-- ============================================================
-- QUESTION 1(a)
-- List customers who have placed at least one order
-- whose amount is greater than the average order amount
-- of the whole store.
--
-- TYPE: NON-CORRELATED SUBQUERY
-- ============================================================

SELECT DISTINCT c.Cust_ID, c.Name, c.City
FROM CUSTOMER c
WHERE c.Cust_ID IN
(
    SELECT o.Cust_ID
    FROM ORDERS o
    WHERE o.Amount >
    (
        SELECT AVG(Amount)
        FROM ORDERS
    )
);


-- ============================================================
-- QUESTION 1(b)
-- List customers who have NEVER placed an order.
--
-- METHOD 1: USING NOT IN
-- TYPE: NON-CORRELATED SUBQUERY
-- ============================================================

SELECT Cust_ID, Name, City
FROM CUSTOMER
WHERE Cust_ID NOT IN
(
    SELECT Cust_ID
    FROM ORDERS
);


-- ============================================================
-- QUESTION 1(b)
-- METHOD 2: USING NOT EXISTS
-- TYPE: CORRELATED SUBQUERY
-- ============================================================

SELECT c.Cust_ID, c.Name, c.City
FROM CUSTOMER c
WHERE NOT EXISTS
(
    SELECT 1
    FROM ORDERS o
    WHERE o.Cust_ID = c.Cust_ID
);


-- ============================================================
-- QUESTION 1(c)
-- For each city, find the customer whose TOTAL ORDER VALUE
-- is the highest in that city.
--
-- METHOD: DERIVED TABLE + MULTI-COLUMN COMPARISON
-- ============================================================

SELECT c.City, c.Cust_ID, c.Name, t.Total_Order_Value
FROM CUSTOMER c
JOIN
(
    SELECT c2.City,
           c2.Cust_ID,
           SUM(o.Amount) AS Total_Order_Value
    FROM CUSTOMER c2
    JOIN ORDERS o
        ON c2.Cust_ID = o.Cust_ID
    GROUP BY c2.City, c2.Cust_ID
) AS t
ON c.Cust_ID = t.Cust_ID
WHERE (t.City, t.Total_Order_Value) IN
(
    SELECT City, MAX(Total_Order_Value)
    FROM
    (
        SELECT c3.City,
               c3.Cust_ID,
               SUM(o3.Amount) AS Total_Order_Value
        FROM CUSTOMER c3
        JOIN ORDERS o3
            ON c3.Cust_ID = o3.Cust_ID
        GROUP BY c3.City, c3.Cust_ID
    ) AS city_totals
    GROUP BY City
);


-- ============================================================
-- OPTIONAL: SHOW TOTAL ORDER VALUE OF EVERY CUSTOMER
-- ============================================================

SELECT c.City,
       c.Cust_ID,
       c.Name,
       COALESCE(SUM(o.Amount), 0) AS Total_Order_Value
FROM CUSTOMER c
LEFT JOIN ORDERS o
    ON c.Cust_ID = o.Cust_ID
GROUP BY c.City, c.Cust_ID, c.Name
ORDER BY c.City, Total_Order_Value DESC;