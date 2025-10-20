USE salesdb;
/* Drop existing tables  */
DROP TABLE IF EXISTS productlines;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS offices;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS customers; 
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS orderdetails;
/* Create the tables */
CREATE TABLE productlines (
  productLine varchar(50),
  textDescription varchar(4000) DEFAULT NULL,
  htmlDescription mediumtext,
  image mediumblob,
  PRIMARY KEY (productLine)
);

CREATE TABLE products (
  productCode varchar(15),
  productName varchar(70) NOT NULL,
  productLine varchar(50) NOT NULL,
  productScale varchar(10) NOT NULL,
  productVendor varchar(50) NOT NULL,
  productDescription text NOT NULL,
  quantityInStock smallint(6) NOT NULL,
  buyPrice decimal(10,2) NOT NULL,
  MSRP decimal(10,2) NOT NULL,
  PRIMARY KEY (productCode),
  FOREIGN KEY (productLine) REFERENCES productlines (productLine)
);

CREATE TABLE offices (
  officeCode varchar(10),
  city varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  addressLine1 varchar(50) NOT NULL,
  addressLine2 varchar(50) DEFAULT NULL,
  state varchar(50) DEFAULT NULL,
  country varchar(50) NOT NULL,
  postalCode varchar(15) NOT NULL,
  territory varchar(10) NOT NULL,
  PRIMARY KEY (officeCode)
);

CREATE TABLE employees (
  employeeNumber int,
  lastName varchar(50) NOT NULL,
  firstName varchar(50) NOT NULL,
  extension varchar(10) NOT NULL,
  email varchar(100) NOT NULL,
  officeCode varchar(10) NOT NULL,
  reportsTo int DEFAULT NULL,
  jobTitle varchar(50) NOT NULL,
  PRIMARY KEY (employeeNumber),
  FOREIGN KEY (reportsTo) REFERENCES employees (employeeNumber),
  FOREIGN KEY (officeCode) REFERENCES offices (officeCode)
);

CREATE TABLE customers (
  customerNumber int,
  customerName varchar(50) NOT NULL,
  contactLastName varchar(50) NOT NULL,
  contactFirstName varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  addressLine1 varchar(50) NOT NULL,
  addressLine2 varchar(50) DEFAULT NULL,
  city varchar(50) NOT NULL,
  state varchar(50) DEFAULT NULL,
  postalCode varchar(15) DEFAULT NULL,
  country varchar(50) NOT NULL,
  salesRepEmployeeNumber int DEFAULT NULL,
  creditLimit decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (customerNumber),
  FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees (employeeNumber)
);

CREATE TABLE payments (
  customerNumber int,
  checkNumber varchar(50) NOT NULL,
  paymentDate date NOT NULL,
  amount decimal(10,2) NOT NULL,
  PRIMARY KEY (customerNumber,checkNumber),
  FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber)
);

CREATE TABLE orders (
  orderNumber int,
  orderDate date NOT NULL,
  requiredDate date NOT NULL,
  shippedDate date DEFAULT NULL,
  status varchar(15) NOT NULL,
  comments text,
  customerNumber int NOT NULL,
  PRIMARY KEY (orderNumber),
  FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber)
);

CREATE TABLE orderdetails (
  orderNumber int,
  productCode varchar(15) NOT NULL,
  quantityOrdered int NOT NULL,
  priceEach decimal(10,2) NOT NULL,
  orderLineNumber int NOT NULL,
  PRIMARY KEY (orderNumber,productCode),
  FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber),
  FOREIGN KEY (productCode) REFERENCES products (productCode)
);
USE salesdb;
/* Drop existing tables  */
DROP TABLE IF EXISTS productlines;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS offices;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS customers; 
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS orderdetails;
/* Create the tables */
CREATE TABLE productlines (
  productLine varchar(50),
  textDescription varchar(4000) DEFAULT NULL,
  htmlDescription mediumtext,
  image mediumblob,
  PRIMARY KEY (productLine)
);

CREATE TABLE products (
  productCode varchar(15),
  productName varchar(70) NOT NULL,
  productLine varchar(50) NOT NULL,
  productScale varchar(10) NOT NULL,
  productVendor varchar(50) NOT NULL,
  productDescription text NOT NULL,
  quantityInStock smallint(6) NOT NULL,
  buyPrice decimal(10,2) NOT NULL,
  MSRP decimal(10,2) NOT NULL,
  PRIMARY KEY (productCode),
  FOREIGN KEY (productLine) REFERENCES productlines (productLine)
);

CREATE TABLE offices (
  officeCode varchar(10),
  city varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  addressLine1 varchar(50) NOT NULL,
  addressLine2 varchar(50) DEFAULT NULL,
  state varchar(50) DEFAULT NULL,
  country varchar(50) NOT NULL,
  postalCode varchar(15) NOT NULL,
  territory varchar(10) NOT NULL,
  PRIMARY KEY (officeCode)
);

CREATE TABLE employees (
  employeeNumber int,
  lastName varchar(50) NOT NULL,
  firstName varchar(50) NOT NULL,
  extension varchar(10) NOT NULL,
  email varchar(100) NOT NULL,
  officeCode varchar(10) NOT NULL,
  reportsTo int DEFAULT NULL,
  jobTitle varchar(50) NOT NULL,
  PRIMARY KEY (employeeNumber),
  FOREIGN KEY (reportsTo) REFERENCES employees (employeeNumber),
  FOREIGN KEY (officeCode) REFERENCES offices (officeCode)
);

CREATE TABLE customers (
  customerNumber int,
  customerName varchar(50) NOT NULL,
  contactLastName varchar(50) NOT NULL,
  contactFirstName varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  addressLine1 varchar(50) NOT NULL,
  addressLine2 varchar(50) DEFAULT NULL,
  city varchar(50) NOT NULL,
  state varchar(50) DEFAULT NULL,
  postalCode varchar(15) DEFAULT NULL,
  country varchar(50) NOT NULL,
  salesRepEmployeeNumber int DEFAULT NULL,
  creditLimit decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (customerNumber),
  FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees (employeeNumber)
);

CREATE TABLE payments (
  customerNumber int,
  checkNumber varchar(50) NOT NULL,
  paymentDate date NOT NULL,
  amount decimal(10,2) NOT NULL,
  PRIMARY KEY (customerNumber,checkNumber),
  FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber)
);

CREATE TABLE orders (
  orderNumber int,
  orderDate date NOT NULL,
  requiredDate date NOT NULL,
  shippedDate date DEFAULT NULL,
  status varchar(15) NOT NULL,
  comments text,
  customerNumber int NOT NULL,
  PRIMARY KEY (orderNumber),
  FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber)
);

CREATE TABLE orderdetails (
  orderNumber int,
  productCode varchar(15) NOT NULL,
  quantityOrdered int NOT NULL,
  priceEach decimal(10,2) NOT NULL,
  orderLineNumber smallint(6) NOT NULL,
  PRIMARY KEY (orderNumber,productCode),
  FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber),
  FOREIGN KEY (productCode) REFERENCES products (productCode)
);

/* Inserting data  */
-- 1. Product Lines
INSERT INTO productlines (productLine, textDescription)
VALUES 
('Electronics', 'Consumer electronics such as phones, TVs, and laptops'),
('Furniture', 'Office and household furniture'),
('Automotive', 'Car parts and accessories');

-- 2. Products
INSERT INTO products (productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
VALUES
('P001', 'Samsung Galaxy A15', 'Electronics', '1:1', 'Samsung Kenya', 'Smartphone with 128GB storage', 50, 20000.00, 25000.00),
('P002', 'LG Smart TV 55"', 'Electronics', '1:1', 'LG Nairobi', '4K Ultra HD Smart TV', 20, 60000.00, 75000.00),
('P003', 'Wooden Office Desk', 'Furniture', '1:1', 'Nairobi Furnitures Ltd', 'Executive wooden office desk', 15, 15000.00, 22000.00),
('P004', 'Toyota Brake Pads', 'Automotive', '1:1', 'Toyota Kenya', 'Genuine Toyota brake pads', 100, 5000.00, 7500.00);

-- 3. Offices
INSERT INTO offices (officeCode, city, phone, addressLine1, country, postalCode, territory)
VALUES
('NBO1', 'Nairobi', '+254711223344', 'Kenyatta Avenue 12', 'Kenya', '00100', 'central'),
('MSA1', 'Mombasa', '+254722334455', 'Moi Avenue 45', 'Kenya', '80100', 'Coastal');

-- 4. Employees
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES
(101, 'Odhiambo', 'Brian', 'x101', 'brian.odhiambo@company.co.ke', 'NBO1', NULL, 'CEO'),
(102, 'Wambui', 'Mary', 'x102', 'mary.wambui@company.co.ke', 'NBO1', 101, 'Sales Manager'),
(103, 'Kamau', 'Peter', 'x103', 'peter.kamau@company.co.ke', 'MSA1', 101, 'Branch Manager'),
(104, 'Atieno', 'Grace', 'x104', 'grace.atieno@company.co.ke', 'NBO1', 102, 'Sales Rep');

-- 5. Customers
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, city, country, salesRepEmployeeNumber, creditLimit)
VALUES
(201, 'Jumia Kenya', 'Mwangi', 'Daniel', '+254700112233', 'Westlands Road 23', 'Nairobi', 'Kenya', 104, 500000.00),
(202, 'QuickMart Supermarket', 'Otieno', 'Jane', '+254711445566', 'Ngong Road 10', 'Nairobi', 'Kenya', 104, 300000.00),
(203, 'Coast Car Spares', 'Ali', 'Hassan', '+254733556677', 'Makupa Street 8', 'Mombasa', 'Kenya', 103, 200000.00);

-- 6. Payments
INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES
(201, 'CHK001', '2025-08-01', 150000.00),
(202, 'CHK002', '2025-08-05', 90000.00),
(203, 'CHK003', '2025-08-10', 60000.00);

-- 7. Orders
INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, customerNumber)
VALUES
(301, '2025-08-02', '2025-08-10', '2025-08-08', 'Shipped', 201),
(302, '2025-08-06', '2025-08-15', '2025-08-12', 'Shipped', 202),
(303, '2025-08-11', '2025-08-18', NULL, 'In Process', 203);

-- 8. Order Details
INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES
(301, 'P001', 5, 25000.00, 1),
(301, 'P003', 2, 22000.00, 2),
(302, 'P002', 1, 75000.00, 1),
(303, 'P004', 10, 7500.00, 1);
SELECT checkNumber, paymentDate, amount
FROM payments;

SELECT orderDate, requiredDate, status
FROM orders
WHERE status = 'in process'
ORDER BY orderDate DESC;

SELECT firstName, lastName, email
FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY employeeNumber DESC;

SELECT *
FROM offices;

SELECT productName, quantityInStock
FROM products
ORDER BY buyPrice ASC
LIMIT 5;

SELECT 
AVG(buyprice) avg_buy_price
FROM products;

SELECT
COUNT(*) AS total
FROM products;

SELECT
productCode,
SUM(priceEach * quantityOrdered) total
FROM orderdetails
GROUP BY productCode
ORDER BY total DESC;

SELECT 
MAX(buyPrice) price
FROM products;

SELECT 
MIN(buyPrice) price
FROM products;

SELECT paymentDate, 
       SUM(amount) AS totalAmount
FROM payments
GROUP BY paymentDate
ORDER BY paymentDate DESC
LIMIT 5;

SELECT customerName, 
       country, 
       AVG(creditLimit) AS avgCreditLimit
FROM customers
GROUP BY customerName, country;

SELECT productCode, 
       quantityOrdered, 
       (quantityOrdered * priceEach) AS totalPrice
FROM orderdetails
GROUP BY productCode, quantityOrdered, priceEach;

SELECT checkNumber, 
       MAX(amount) AS highestAmount
FROM payments
GROUP BY checkNumber;

CREATE INDEX IdxPhone
on Customers(phone);

DROP INDEX IdxPhone ON customers;

CREATE USER 'bob'@'localhost' 
IDENTIFIED BY 'S$cu3r3!';

GRANT INSERT ON salesDB.* 
TO 'bob'@'localhost';

ALTER USER 'bob'@'localhost' 
IDENTIFIED BY 'P$55!23';

SELECT e.firstName, e.lastName, e.email, e.officeCode
FROM employees e
INNER JOIN offices o
  ON e.officeCode = o.officeCode;
  
SELECT p.productName, p.productVendor, p.productLine
FROM products p
LEFT JOIN productlines pl
  ON p.productLine = pl.productLine;
  
  SELECT o.orderDate, o.shippedDate, o.status, o.customerNumber
FROM customers c
RIGHT JOIN orders o
  ON c.customerNumber = o.customerNumber
LIMIT 10;
-- 1NF Transformation
CREATE TABLE ProductDetail_1NF AS
SELECT 101 AS OrderID, 'John Doe' AS CustomerName, 'Laptop' AS Product
UNION ALL
SELECT 101, 'John Doe', 'Mouse'
UNION ALL
SELECT 102, 'Jane Smith', 'Tablet'
UNION ALL
SELECT 102, 'Jane Smith', 'Keyboard'
UNION ALL
SELECT 102, 'Jane Smith', 'Mouse'
UNION ALL
SELECT 103, 'Emily Clark', 'Phone';
-- Already exists in the database
SELECT orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber
FROM orders;
-- Already exists in the database
SELECT orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber
FROM orderdetails;


























