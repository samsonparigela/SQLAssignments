CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Email VARCHAR(30),
    Phone VARCHAR(30),
    Address VARCHAR(50)
);

CREATE TABLE PRODUCTS
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(30),
    CATG VARCHAR(30),
    Price Float
);

CREATE TABLE ORDERS
(
    OrderID INT Primary Key,
    CustomerID INT,
    Foreign Key(CustomerID) REFERENCES Customers(CustomerID),
    OrderDate DATE,
    TotalAmount Float
);

CREATE TABLE ORDERDETAILS
(
    OrderDetailID INT Primary Key,
    ORDERID INT,
    ProductID INT,
    Foreign Key(OrderID) REFERENCES Orders(ORDERID),
    Foreign Key(ProductID ) REFERENCES Products(ProductID ),
    Quantity INT
);

CREATE TABLE INVENTORY
(
    InventoryID INT Primary Key,
    ProductID INT,
    Foreign Key(ProductID) REFERENCES Products(ProductID ),
    QuantityInStock INT,
    LastStockUpdate DATE
);



INSERT INTO Customers VALUES
(1,'PHIL','DUNPHY','PHILDUNPHY@GMAIL.COM','987654321','Hyd'),
(2,'LUKE','DUNPHY','PHILDUNPHY@GMAIL.COM','987654321','Bnglr'),
(3,'CLAIRE','DUNPHY','PHILDUNPHY@GMAIL.COM','987654321','Pune'),
(4,'ALEX','DUNPHY','PHILDUNPHY@GMAIL.COM','987654321','Mumbai'),
(5,'HAILEY','DUNPHY','PHILDUNPHY@GMAIL.COM','987654321','Kolkata'),
(6,'CAMERON','TUCKER','PHILDUNPHY@GMAIL.COM','987654321','Bnglr'),
(7,'MITCH','PRITCHET','PHILDUNPHY@GMAIL.COM','987654321','Pune'),
(8,'LILY','PRITCHET','PHILDUNPHY@GMAIL.COM','987654321','Hyd'),
(9,'JAY','PRITCHET','PHILDUNPHY@GMAIL.COM','987654321','Mumbai'),
(10,'GLORIA','DELGADO','PHILDUNPHY@GMAIL.COM','987654321','Kurnool');

SELECT * FROM Customers;

INSERT INTO ADDRESS VALUES
('144','JAYANAGAR','ANDHRA','518001',1),
('145','RAJANAGAR','TELANGANA','518001',2),
('146','RAVINAGAR','ANDHRA','518001',3),
('147','RAMUNAGAR','TELANGANA','518001',4),
('148','SITANAGAR','ANDHRA','518001',5),
('149','AMEERNAGAR','TELANGANA','518001',6),
('150','KABIRNAGAR','ANDHRA','518001',7),
('151','ABHINAGAR','TELANGANA','518001',8),
('152','PRAGYANAGAR','ANDHRA','518001',9),
('153','PURABNAGAR','TELANGANA','518001',10);

SELECT * FROM ADDRESS;

INSERT INTO ORDERS VALUES
(21,1,'2023/12/25',1045),
(22,2,'2023/12/24',5045),
(23,3,'2023/12/24',6045),
(24,4,'2023/12/25',7045),
(25,5,'2023/12/26',8045),
(26,6,'2023/12/27',9045),
(27,7,'2023/12/28',5045),
(28,8,'2023/12/29',3045),
(29,9,'2023/12/30',2045),
(30,10,'2023/12/31',1045),
(31,11,'2023/12/30',6645),
(32,8,'2023/12/30',8645),
(33,7,'2023/12/30',7645);

SELECT * FROM ORDERS;

INSERT INTO PRODUCTS VALUES
(31,'PEN','AA',1000),
(32,'PENCIL','AA',2000),
(33,'ERASER','AA',3000),
(34,'SHARPNER','AA',6000),
(35,'BOOKS','AA',5000),
(36,'STICKERS','AA',6000),
(37,'BRUSH','AA',7000),
(38,'PASTE','AA',8000),
(39,'SOAP','AA',9000),
(40,'SURF','AA',8000);

SELECT * FROM PRODUCTS;

INSERT INTO OrderDetails VALUES
(41,21,31,5),
(42,22,32,4),
(43,23,33,3),
(44,24,34,2),
(45,25,35,1),
(46,26,36,2),
(47,27,37,3),
(48,28,38,4),
(49,29,39,5),
(51,30,41,3);

SELECT * FROM OrderDetails;

INSERT INTO INVENTORY VALUES
(51,31,100,'2023/10/17'),
(52,32,200,'2023/10/18'),
(53,33,300,'2023/10/19'),
(54,34,400,'2023/10/20'),
(55,35,500,'2023/10/13'),
(56,36,600,'2023/10/14'),
(57,37,700,'2023/10/15'),
(58,38,800,'2023/10/16'),
(59,39,900,'2023/10/12'),
(60,40,600,'2023/10/11');

SELECT * FROM INVENTORY;

/*
1. Write an SQL query to retrieve the names and emails of all customers. 
*/

SELECT FIRSTNAME,LASTNAME, EMAIL FROM Customers;

/*
2. Write an SQL query to list all orders with their order dates and corresponding customer names.
*/

SELECT Customers.CID,Customers.FirstName,Orders.OrderDate FROM Customers
 JOIN Orders ON Customers.CID = Orders.CID;

/*
3. Write an SQL query to insert a new customer record into the "Customers" table. Include 
customer information such as name, email, and address.
*/

INSERT INTO Customers VALUES
(11,'MANNY','DELGADO','MANNYDELGADO@GMAIL.COM',987654321);

/*
4. Write an SQL query to update the prices of all electronic gadgets in the "Products" table by 
increasing them by 10%.
*/

UPDATE Products
SET Price = price+price/10;

SELECT * FROM Products;

/*
5. Write an SQL query to delete a specific order and its associated order details from the 
"Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.
*/

DECLARE @X INT
SET @X=3
DELETE FROM Orders WHERE OrderID=@X;
DELETE FROM OrderDetails WHERE OrderID=@X;

SELECT * FROM Orders;

/*
6. Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, 
order date, and any other necessary information.
*/

INSERT INTO Orders(OrderID,CID,TotalAmount,OrderDate)
VALUES(31,11,8564,'2023/12/27');

SELECT * FROM Orders;

/*
7. Write an SQL query to update the contact information (e.g., email and address) of a specific 
customer in the "Customers" table. Allow users to input the customer ID and new contact 
information.
*/

DECLARE @X INT
SET @X=10

UPDATE Customers
SET EMAIL='GLORIADELGADO@GMAIL.COM'
WHERE CID=@X;

SELECT * FROM Customers;

DECLARE @X INT
SET @X=10

UPDATE Address
SET HNO='344'
WHERE CID=@X;

SELECT * FROM ADDRESS;

/*
8. Write an SQL query to recalculate and update the total cost of each order in the "Orders" 
table based on the prices and quantities in the "OrderDetails" table.
*/

ALTER TABLE Orders
DROP COLUMN TAMOUNT;

UPDATE Orders
SET TotalAmount = (
    SELECT SUM(O.Quantity * P.Price)
    FROM OrderDetails O
    JOIN Products P ON O.PID = P.PID
    GROUP BY O.OrderID

);


/*
9. Write an SQL query to delete all orders and their associated order details for a specific 
customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID 
as a parameter.
*/

DECLARE @X INT
SET @X=(SELECT OrderID FROM Orders WHERE CID=11)
DELETE FROM Orders WHERE OrderID=@X;
DELETE FROM OrderDetails WHERE OrderID=@X;

SELECT * FROM Orders;
SELECT * FROM OrderDetails;

/*
10. Write an SQL query to insert a new electronic gadget product into the "Products" table, 
including product name, category, price, and any other relevant details.
*/

INSERT INTO Products VALUES
(41,'SMART WATCH','WATCHES',5700);

SELECT * FROM Products;

/*
11. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from 
"Pending" to "Shipped"). Allow users to input the order ID and the new status.
*/

ALTER TABLE Orders
ADD status VARCHAR(20) NULL;

SELECT * FROM Orders;

DECLARE @Y INT
SET @Y=30
UPDATE Orders
SET STATUS='SHIPPED'
WHERE OrderID=@Y;

SELECT * FROM Orders;

/*
12. Write an SQL query to calculate and update the number of orders placed by each customer 
in the "Customers" table based on the data in the "Orders" table.
*/


ALTER TABLE CUSTOMERS
ADD NO_OF_ORDERS int NULL


SELECT CID, COUNT(OrderID)
AS OrderNumber
FROM Orders
GROUP BY CID;

UPDATE Customers
SET NO_OF_ORDERS=(
    SELECT COUNT(OrderID)
    AS OrderNumber
    FROM Orders
    GROUP BY CID)

/*
AGGREGATE FUNCTIONS
*/

/*
1.Write an SQL query to find out which customers have not placed any orders.
*/

SELECT * FROM CUSTOMERS
WHERE CID NOT IN (SELECT CID FROM ORDERS);

/*
2. Write an SQL query to find the total number of products available for sale. 
*/

SELECT PID,
COUNT(*) AS TOTALPRODUCTS
FROM INVENTORY
GROUP BY PID;

/*
3. Write an SQL query to calculate the total revenue generated by TechShop. 
*/

SELECT SUM(TotalAmount)
AS REVENUE 
FROM Orders;

/*
4. Write an SQL query to calculate the average quantity ordered for products in a specific category. 
Allow users to input the category name as a parameter.
*/

DECLARE @P VARCHAR(20)
SET @P='AA';


SELECT COUNT(ORDERDETAILS.QUANTITY) AS AVG,
PRODUCTS.Catg
FROM ORDERDETAILS
INNER JOIN PRODUCTS
ON ORDERDETAILS.PID=PRODUCTS.PID
WHERE PRODUCTS.CATG=@P
GROUP BY Products.Catg;

/*
5. Write an SQL query to calculate the total revenue generated by a specific customer. Allow users 
to input the customer ID as a parameter.
*/

DECLARE @P INT
SET @P=1;

SELECT CID,SUM(TOTALAMOUNT) AS REVENUE
FROM Orders
GROUP BY CID
HAVING CID=@P;

/*
6. Write an SQL query to find the customers who have placed the most orders. List their names 
and the number of orders they've placed.
*/

SELECT CID,COUNT(CID) AS TOTAL_COUNT FROM ORDERS 
GROUP BY CID
HAVING COUNT(CID) =
(SELECT TOP 1
COUNT(CID)
FROM Orders
GROUP BY CID
ORDER BY COUNT(CID) DESC)


/*
7. Write an SQL query to find the most popular product category, which is the one with the highest 
total quantity ordered across all orders.
*/
SELECT PNAME FROM Products
WHERE PID IN (SELECT TOP 1 PID
FROM OrderDetails
ORDER BY Quantity DESC
);

/*
8. Write an SQL query to find the customer who has spent the most money (highest total revenue) 
on electronic gadgets. List their name and total spending.
*/

SELECT TOP 1 C.FIRSTNAME,C.LASTNAME, SUM(O.TOTALAMOUNT) AS TOTAL_SPENDING
FROM CUSTOMERS AS C
JOIN ORDERS AS O
ON C.CID=O.CID
GROUP BY C.CID,C.FirstName,C.LastName
ORDER BY SUM(O.TotalAmount) DESC;

/*
9. Write an SQL query to calculate the average order value (total revenue divided by the number of 
orders) for all customers.
*/

SELECT C.FIRSTNAME,AVG(O.TOTALAMOUNT) 
FROM CUSTOMERS AS C
JOIN ORDERS AS O
ON C.CID=O.CID
GROUP BY C.CID,C.FirstName;


/*
10. Write an SQL query to find the total number of orders placed by each customer and list their 
names along with the order count
*/

SELECT C1.FirstName,COUNT(C2.OrderID) AS TOTAL_ORDERS
FROM Customers AS C1
INNER JOIN Orders AS C2
ON C1.CID=C2.CID
GROUP BY C2.CID,C1.FirstName



--SELECT DATEDIFF(YEAR,'2001/10/05',GETDATE())


/*
Joins:
*/

/*
1. Write an SQL query to retrieve a list of all orders along with customer information (e.g., 
customer name) for each order.
*/


SELECT C.CID,FIRSTNAME,PNAME
FROM CUSTOMERS AS C
INNER JOIN ORDERS AS O
ON C.CID=O.CID
INNER JOIN ORDERDETAILS AS O1
ON O.ORDERID=O1.ORDERID
INNER JOIN PRODUCTS AS P
ON O1.PID=P.PID;

/*
2. Write an SQL query to find the total revenue generated by each electronic gadget product. 
Include the product name and the total revenue.
*/

SELECT P.PID,P.PNAME,O.Quantity*P.PRICE
FROM Products AS P
INNER JOIN OrderDetails AS O
ON P.PID=O.PID;


/*
3. Write an SQL query to list all customers who have made at least one purchase. Include their 
names and contact information.
*/

SELECT C.FIRSTNAME, C.PHONE
FROM Customers AS C
INNER JOIN Orders AS O
ON C.CID=O.CID


/*
4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest 
total quantity ordered. Include the product name and the total quantity ordered.
*/

SELECT P.PID,P.PNAME,O.QUANTITY
FROM PRODUCTS AS P
INNER JOIN OrderDetails AS O
ON P.PID =O.PID
GROUP BY P.PID,P.PNAME,O.Quantity
HAVING P.PID IN (SELECT PID FROM OrderDetails WHERE Quantity = (SELECT MAX(QUANTITY) FROM OrderDetails) );

/*
5.Write an SQL query to retrieve a list of electronic gadgets along with their corresponding 
categories.
*/

SELECT PNAME,CATG FROM PRODUCTS;

/*
6. Write an SQL query to calculate the average order value for each customer. Include the 
customer's name and their average order value.
*/

SELECT C.FIRSTNAME,AVG(O.TOTALAMOUNT) AS AVG_ORDER_VALUE
FROM CUSTOMERS AS C
JOIN ORDERS AS O
ON C.CID=O.CID
GROUP BY C.CID,C.FirstName;

--SELECT (5045+7645)/2;
/*
7. Write an SQL query to find the order with the highest total revenue. Include the order ID, 
customer information, and the total revenue.
*/

SELECT CID,OrderID,TotalAmount FROM Orders 
WHERE OrderID IN 
(
    SELECT OrderID FROM Orders
    WHERE TotalAmount =
    (
        SELECT MAX(TotalAmount) FROM Orders
    )
)


/*
8. Write an SQL query to list electronic gadgets and the number of times each product has been 
ordered.
*/

SELECT P.PName,SUM(O.Quantity) AS NO_OF_ORDERS
FROM PRODUCTS P
JOIN OrderDetails O
ON P.PID =O.PID
GROUP BY P.PNAME,O.PID;

--SELECT * FROM OrderDetails

/*
9. Write an SQL query to find customers who have purchased a specific electronic gadget product. 
Allow users to input the product name as a parameter.
*/

DECLARE @F VARCHAR(50)
SET @F='SURF'

SELECT C.FIRSTNAME,P.PNAME
FROM CUSTOMERS C

JOIN ORDERS O
ON C.CID=O.CID
JOIN OrderDetails O1
ON O.OrderID=O1.OrderID
JOIN PRODUCTS P
ON O1.PID=P.PID
WHERE P.PNAME = @F;



/*
10. Write an SQL query to calculate the total revenue generated by all orders placed within a 
specific time period. Allow users to input the start and end dates as parameters.
*/

DECLARE @D1 DATE,@D2 DATE
SET @D1='2023/12/28'
SET @D2='2023/12/31'

SELECT SUM(TOTALAMOUNT) AS 
REVENUE_GENERATED
FROM Orders
WHERE OrderDate BETWEEN @D1 AND @D2

