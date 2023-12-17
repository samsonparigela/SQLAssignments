CREATE DATABASE HMBank;

CREATE TABLE CUSTOMERS
(
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    DOB DATE,
    phone BIGINT,
    email VARCHAR(50)
);

INSERT INTO CUSTOMERS VALUES
(1,'PHIL','DUNPHY','2003/12/25','987654321','PHILDUNPHY@GMAIL.COM'),
(2,'LUKE','DUNPHY','2003/12/26','987654321','PHILDUNPHY@GMAIL.COM'),
(3,'CLAIRE','DUNPHY','2003/12/27','987654321','PHILDUNPHY@GMAIL.COM'),
(4,'ALEX','DUNPHY','2003/12/28','987654321','PHILDUNPHY@GMAIL.COM'),
(5,'HAILEY','DUNPHY','2003/12/29','987654321','PHILDUNPHY@GMAIL.COM'),
(6,'CAMERON','TUCKER','2004/12/25','987654321','PHILDUNPHY@GMAIL.COM'),
(7,'MITCH','PRITCHET','2004/12/26','987654321','PHILDUNPHY@GMAIL.COM'),
(8,'LILY','PRITCHET','2004/12/27','987654321','PHILDUNPHY@GMAIL.COM'),
(9,'JAY','PRITCHET','2004/12/28','987654321','PHILDUNPHY@GMAIL.COM'),
(10,'GLORIA','DELGADO','2004/12/29','987654321','PHILDUNPHY@GMAIL.COM');

CREATE TABLE ACCOUNT
(
    account_id INT PRIMARY KEY,
    customer_id int,
    FOREIGN KEY(customer_id) REFERENCES CUSTOMERS(customer_id),
    account_type VARCHAR(50),
    balance BIGINT
);

INSERT INTO ACCOUNT VALUES
(11,1,'savings',50000),
(12,2,'savings',60000),
(13,3,'savings',40000),
(14,4,'savings',30000),
(15,2,'current',20000),
(16,5,'zero_balance',10000),
(17,6,'savings',70000),
(18,7,'zero_balance',80000),
(19,3,'current',90000),
(20,8,'savings',50000);

CREATE TABLE TRANSACTIONS
(
    transaction_id  INT PRIMARY KEY,
    account_id INT,
    FOREIGN KEY(account_id) REFERENCES ACCOUNT(account_id),
    transaction_type VARCHAR(50),
    amount bigint,
    transaction_date DATE

);

INSERT INTO TRANSACTIONS VALUES
(21,11,'withdrawal',1000,'2023/10/12'),
(22,12,'withdrawal',2000,'2023/10/13'),
(23,13,'deposit',3000,'2023/10/14'),
(24,14,'withdrawal',4000,'2023/10/15'),
(25,15,'withdrawal',5000,'2023/10/16'),
(26,14,'deposit',6000,'2023/10/15'),
(27,16,'transfer',3000,'2023/10/16'),
(28,17,'withdrawal',2000,'2023/10/17'),
(29,18,'transfer',4000,'2023/10/19'),
(30,19,'withdrawal',8000,'2023/10/20');


/*
1. Write a SQL query to retrieve the name, account type and email of all customers.
*/

SELECT C.FIRST_NAME,C.LAST_NAME,C.EMAIL,A.ACCOUNT_TYPE
FROM CUSTOMERS C
JOIN ACCOUNT A
ON C.customer_id=A.customer_id;


/*
2. Write a SQL query to list all transaction corresponding customer.
*/

SELECT C.first_name,T.transaction_type,T.amount
FROM TRANSACTIONS T
JOIN Account A on A.account_id=T.account_id
JOIN Customers C
ON C.customer_id=A.customer_id;

/*
3. Write a SQL query to increase the balance of a specific account by a certain amount.
*/

DECLARE @X INT;
SET @X=650;

DECLARE @Y INT;
SET @Y=13;

UPDATE ACCOUNT
SET balance=balance+@X
WHERE account_id=@Y;

SELECT * FROM ACCOUNT;

/*
4. Write a SQL query to Combine first and last names of customers as a full_name.
*/

SELECT  CONCAT(first_name,' ',last_name) as full_name
FROM CUSTOMERS;

SELECT first_name+last_name AS FULL_NAME
FROM CUSTOMERS;

/*
5. Write a SQL query to remove accounts with a balance of zero where the account 
type is savings.
*/

INSERT INTO ACCOUNT VALUES
(21,1,'savings',0);

DELETE FROM ACCOUNT
WHERE account_type='savings' AND balance=0;

SELECT * FROM ACCOUNT;


/*
6. Write a SQL query to Find customers living in a specific city.
*/

ALTER TABLE CUSTOMERS
ADD CITY VARCHAR(30) NULL;

SELECT * FROM CUSTOMERS;

UPDATE CUSTOMERS
SET CITY='HYD' WHERE customer_id%2=0 

UPDATE CUSTOMERS
SET CITY='BNGLR' WHERE customer_id%2<>0 

SELECT * FROM CUSTOMERS
WHERE CITY LIKE 'BNGLR';


/*
7. Write a SQL query to Get the account balance for a specific account.
*/

SELECT balance FROM ACCOUNT
WHERE account_id=13;

/*
8. Write a SQL query to List all current accounts with a balance greater than $1,000.
*/

INSERT INTO ACCOUNT VALUES
(21,9,'savings',600),
(22,9,'current',600);

select * from account;

SELECT * FROM account
WHERE account_type='current' AND balance>1000;

/*
9. Write a SQL query to Retrieve all transactions for a specific account.
*/

DECLARE @X INT;
SET @X=16;

SELECT * FROM transactions 
WHERE account_id=@x;

/*
10. Write a SQL query to Calculate the interest accrued on savings accounts based on a 
given interest rate.
*/

DECLARE @X INT;
SET @X=10;

SELECT balance*(@X*0.01) AS INTEREST FROM ACCOUNT
WHERE account_type='savings';

/*
11. Write a SQL query to Identify accounts where the balance is less than a specified 
overdraft limit.
*/

DECLARE @X INT;
SET @X=20000;

SELECT * FROM ACCOUNT
WHERE balance<@x;

/*
12. Write a SQL query to Find customers not living in a specific city.
*/

SELECT first_name,last_name
FROM CUSTOMERS
WHERE city not like 'HYD';



/*
1. Write a SQL query to Find the average account balance for all customers. 
*/


SELECT AVG(balance) AS AVG
FROM ACCOUNT
GROUP BY customer_id;

/*
2. Write a SQL query to Retrieve the top 10 highest account balances.
*/

SELECT TOP 10
* FROM ACCOUNT
ORDER BY BALANCE DESC

/*
3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
*/

SELECT account_id,SUM(amount) FROM TRANSACTIONS
GROUP BY ACCOUNT_ID,transaction_type,TRANSACTION_DATE 
HAVING transaction_type like 'deposit'
AND transaction_date BETWEEN '2023/10/15' AND '2023/10/20'

SELECT * FROM TRANSACTIONS

/*
4. Write a SQL query to Find the Oldest and Newest Customers.
*/


-- Oldest Customer
SELECT TOP 1
    customer_id,
    first_name,
    DOB
FROM 
    Customers
ORDER BY 
    DOB ASC

-- Newest Customer
SELECT TOP 1
    customer_id,
    first_name,
    DOB
FROM 
    Customers
ORDER BY 
    DOB DESC



/*
5. Write a SQL query to Retrieve transaction details along with the account type.
*/

SELECT T.transaction_id,T.transaction_type,T.transaction_date,T.amount,T.account_id,A.account_type FROM TRANSACTIONS T
JOIN ACCOUNT A
ON T.account_id=A.account_id;


/*
6. Write a SQL query to Get a list of customers along with their account details.
*/

SELECT * FROM
CUSTOMERS C
JOIN ACCOUNT A
ON C.customer_id=A.customer_id

/*
7. Write a SQL query to Retrieve transaction details along with customer information for a 
specific account.
*/

SELECT * FROM TRANSACTIONS

SELECT C.FIRST_NAME,C.LAST_NAME,T.* FROM TRANSACTIONS T
JOIN ACCOUNT A
ON T.account_id=A.account_id
JOIN CUSTOMERS C
ON C.customer_id=A.customer_id

/*
8. Write a SQL query to Identify customers who have more than one account.
*/

SELECT C.first_name,C.LAST_NAME
FROM CUSTOMERS C
WHERE C.customer_id IN
(
    SELECT customer_id
    FROM ACCOUNT
    GROUP BY CUSTOMER_ID
    HAVING COUNT(customer_id)>1
)

/*
9. Write a SQL query to Calculate the difference in transaction amounts between deposits and 
withdrawals.
*/

SELECT SUM(A.AMOUNT)-SUM(B.AMOUNT) AS DEPS_WITHD
FROM TRANSACTIONS A, TRANSACTIONS B
WHERE A.TRANSACTION_TYPE='deposit' 
AND B.TRANSACTION_TYPE='withdrawal'




/*
10. Write a SQL query to Calculate the average daily balance for each account over a specified 
period.
*/

SELECT account_id,AVG(amount) as AVG FROM TRANSACTIONS
GROUP BY account_id
HAVING transaction_date BETWEEN (2023/10/10) AND (2023-10-30);

select * from TRANSACTIONS


/*
11. Calculate the total balance for each account type.
*/

SELECT account_type,SUM(balance)
FROM ACCOUNT
GROUP BY account_type;


/*
12. Identify accounts with the highest number of transactions order by descending order.
*/

SELECT * FROM TRANSACTIONS;

SELECT ACCOUNT_ID,COUNT(ACCOUNT_ID) AS TRANSACTION_NUMBER
FROM TRANSACTIONS
GROUP BY ACCOUNT_ID
ORDER BY COUNT(ACCOUNT_ID) DESC

/*
13. List customers with high aggregate account balances, along with their account types.
*/


SELECT Customer_ID,account_type,balance FROM ACCOUNT WHERE balance =
(
    (SELECT MAX(balance) from ACCOUNT)
)

/*
14. Identify and list duplicate transactions based on transaction amount, date, and account.
*/
INSERT INTO TRANSACTIONS VALUES(31,11,'withdrawal',1000,'2023/10/12');


SELECT * FROM TRANSACTIONS
WHERE ACCOUNT_ID =
(
    SELECT ACCOUNT_ID FROM TRANSACTIONS
    GROUP BY  ACCOUNT_ID,AMOUNT,TRANSACTION_DATE
    HAVING COUNT(account_id)>1
)

/*
1. Retrieve the customer(s) with the highest account balance.
*/

    SELECT C.first_name,SUM(A.balance) AS Balance
    FROM ACCOUNT A
    JOIN CUSTOMERS C
    ON C.customer_id=A.customer_id
    GROUP BY A.customer_id,C.FIRST_NAME
    ORDER BY SUM(A.Balance) DESC

/*
2. Calculate the average account balance for customers who have more than one account.
*/

SELECT customer_id,AVG(balance)
FROM ACCOUNT
GROUP BY customer_id
HAVING COUNT(customer_id)>1

/*
3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.
*/

SELECT ACCOUNT_ID,AMOUNT FROM TRANSACTIONS
WHERE (AMOUNT)>5000

/*
4. Identify customers who have no recorded transactions.
*/

SELECT C.FIRST_NAME,C.LAST_NAME
FROM CUSTOMERS C
WHERE customer_id NOT IN
(
    SELECT A.CUSTOMER_ID FROM ACCOUNT A
    JOIN TRANSACTIONS T
    ON A.account_id=T.account_id
)

SELECT * FROM ACCOUNT
SELECT * FROM CUSTOMERS
SELECT * FROM TRANSACTIONS

/*
5. Calculate the total balance of accounts with no recorded transactions.
*/

SELECT C.CUSTOMER_ID,SUM(A.balance)
FROM CUSTOMERS C
JOIN ACCOUNT A
ON C.customer_id=A.customer_id
GROUP BY C.customer_id
HAVING C.customer_id NOT IN
(
    SELECT A.CUSTOMER_ID FROM ACCOUNT A
    JOIN TRANSACTIONS T
    ON A.account_id=T.account_id
)

/*
6. Retrieve transactions for accounts with the lowest balance.
*/
SELECT * FROM TRANSACTIONS
WHERE ACCOUNT_ID IN
(
    SELECT ACCOUNT_ID FROM ACCOUNT 
    WHERE BALANCE=
    (
        SELECT MIN(balance) FROM ACCOUNT AS MIN
    )
)



/*
7. Identify customers who have accounts of multiple types.
*/

SELECT (C.FIRST_NAME)
FROM CUSTOMERS C
INNER JOIN ACCOUNT A
ON C.CUSTOMER_ID=A.customer_id
GROUP BY A.customer_id,C.first_name
HAVING COUNT(*)>1

/*
8. Calculate the percentage of each account type out of the total number of accounts.
*/

SELECT
    account_type,
    COUNT(*) AS account_count,
    (COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()) AS percentage_of_total
FROM
    Account
GROUP BY
    account_type;


/*
9. Retrieve all transactions for a customer with a given customer_id.
*/

DECLARE @X INT;
SET @X=2;

SELECT C.FIRST_NAME,C.LAST_NAME,T.* FROM TRANSACTIONS T
JOIN ACCOUNT A
ON T.account_id=A.account_id
JOIN CUSTOMERS C
ON C.customer_id=A.customer_id
WHERE C.customer_id=@X
/*
10. Calculate the total balance for each account type, including a subquery within the SELECT 
clause.
*/
SELECT account_type,SUM(balance) AS TOTAL_BALANCE
FROM ACCOUNT
GROUP BY account_type
