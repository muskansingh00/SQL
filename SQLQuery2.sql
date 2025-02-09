-- 📌 1️⃣ Database Creation
CREATE DATABASE MobileDB;
USE MobileDB;  -- Select Database

-- 📌 2️⃣ Customers Table with Constraints
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),  
    CustomerName VARCHAR(100) NOT NULL,  
    MobileNumber VARCHAR(15) UNIQUE NOT NULL,  
    City VARCHAR(50),  
    PaymentMode VARCHAR(20) CHECK (PaymentMode IN ('Cash', 'Card', 'UPI', 'Net Banking')),  
    Email VARCHAR(100) UNIQUE,  
    Address TEXT,  
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- 📌 3️⃣ Orders Table with Foreign Key
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 📌 4️⃣ Insert Data into Customers
INSERT INTO Customers (CustomerName, MobileNumber, City, PaymentMode, Email, Address)
VALUES 
('Rahul Sharma', '9876543210', 'Mumbai', 'UPI', 'rahul@gmail.com', 'Andheri, Mumbai'),
('Priya Singh', '8765432109', 'Delhi', 'Cash', 'priya@yahoo.com', 'Lajpat Nagar, Delhi'),
('Amit Kumar', '7654321098', 'Bangalore', 'Card', 'amit@hotmail.com', 'Indiranagar, Bangalore');

-- 📌 5️⃣ Insert Data into Orders
INSERT INTO Orders (CustomerID, Amount) VALUES (1, 1500.50);
INSERT INTO Orders (CustomerID, Amount) VALUES (2, 2300.75);
INSERT INTO Orders (CustomerID, Amount) VALUES (3, 3200.00);

-- 📌 6️⃣ Fetch Data (SELECT Queries)
SELECT * FROM Customers;  -- Fetch all customers
SELECT CustomerName, MobileNumber FROM Customers WHERE City = 'Mumbai'; -- Filter by City
SELECT CustomerName, MobileNumber FROM Customers WHERE MobileNumber LIKE '%98'; -- LIKE Operator

-- 📌 7️⃣ Joins (INNER, LEFT, RIGHT, FULL)
SELECT Customers.CustomerName, Orders.OrderID, Orders.Amount
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;  -- INNER JOIN

SELECT Customers.CustomerName, Orders.OrderID, Orders.Amount
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;  -- LEFT JOIN

SELECT Customers.CustomerName, Orders.OrderID, Orders.Amount
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;  -- RIGHT JOIN

SELECT Customers.CustomerName, Orders.OrderID, Orders.Amount
FROM Customers
FULL JOIN Orders ON Customers.CustomerID = Orders.CustomerID;  -- FULL JOIN

-- 📌 8️⃣ Views (Virtual Table)
CREATE VIEW CustomerOrders AS
SELECT Customers.CustomerName, Orders.OrderID, Orders.Amount
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT * FROM CustomerOrders;  -- Use View

-- 📌 9️⃣ Indexing (For Faster Queries)
CREATE INDEX idx_City ON Customers(City);
DROP INDEX idx_City ON Customers;  -- Drop Index

-- 📌 🔟 Stored Procedure
CREATE PROCEDURE GetCustomerOrders
AS
BEGIN
    SELECT Customers.CustomerName, Orders.OrderID, Orders.Amount
    FROM Customers
    INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
END;

EXEC GetCustomerOrders;  -- Run Stored Procedure

-- 📌 1️⃣1️⃣ Function
CREATE FUNCTION GetTotalCustomers()
RETURNS INT
AS
BEGIN
    DECLARE @Total INT;
    SELECT @Total = COUNT(*) FROM Customers;
    RETURN @Total;
END;

SELECT dbo.GetTotalCustomers() AS TotalCustomers;  -- Call Function

-- 📌 1️⃣2️⃣ Transactions (Commit & Rollback)
BEGIN TRANSACTION;
DELETE FROM Customers WHERE City = 'Delhi';  -- Temporary Deletion

ROLLBACK;  -- Undo Changes (Use COMMIT to save changes)

-- 📌 1️⃣3️⃣ DELETE vs TRUNCATE
DELETE FROM Customers WHERE City = 'Mumbai';  -- Deletes Specific Rows
TRUNCATE TABLE Customers;  -- Deletes All Rows & Resets Identity

-- 📌 1️⃣4️⃣ Backup & Restore Database
BACKUP DATABASE MobileDB TO DISK = 'C:\Backup\MobileDB.bak';
RESTORE DATABASE MobileDB FROM DISK = 'C:\Backup\MobileDB.bak';

-- 📌 1️⃣5️⃣ Drop Tables & Database (Only for Cleanup)
DROP TABLE Orders;
DROP TABLE Customers;
DROP DATABASE MobileDB;
