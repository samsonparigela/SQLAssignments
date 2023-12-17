CREATE DATABASE SISDB;


USE SISDB;

/*
Define the schema for the Students table
*/
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100),
    phone_number VARCHAR(15)
);

--  Define the schema for the Courses table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

-- Define the schema for the Enrollments table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

--  Define the schema for the Teacher table
CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

--  Define the schema for the Payments table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    student_id INT,
    amount DECIMAL(10, 2),
    payment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);



-- INSERTING DATA INTO THESE TABLES

INSERT INTO Students VALUES
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

SELECT * FROM students;

INSERT INTO Courses VALUES  
  (11, 'English', 5, 33),
  (12, 'Maths', 3, 31),
  (13, 'Physics', 4, 34),
  (14, 'Chemistry', 2, 32),
  (15, 'History', 1, 35),
  (16, 'Biology', 2, 33),
  (17, 'Economics', 4, 34),
  (18, 'Politics', 1, 35),
  (19, 'Zoology', 5, 32),
  (20, 'Sociol', 3, 31);

SELECT * FROM COURSES;

INSERT INTO Enrollments VALUES
  (21, 1, 11, '2023-12-25'),
  (22, 2, 12, '2023-12-23'),
  (23, 2, 12, '2023-12-20'),
  (24, 3, 13, '2023-12-21'),
  (25, 4, 14, '2023-12-05'),
  (26, 5, 15, '2023-12-10'),
  (27, 6, 16, '2023-12-15'),
  (28, 7, 17, '2023-12-20'),
  (29, 8, 18, '2023-12-21'),
  (30, 9, 19, '2023-12-25'),
  (32, 4, 11, '2023-12-25'),
  (31, 10, 20, '2023-12-10');


SELECT * FROM enrollments;

INSERT INTO Teacher VALUES
  (31, 'Rachel', 'Green', 'rachelgreen@gmail.com'),
  (32, 'Chandler', 'Bing', 'cbing@mail.com'),
  (33, 'Joey', 'Tribbiani', 'jtribbiani@gmail.com'),
  (34, 'Phoebe', 'Buffay', 'phoebeb@gmail.com'),
  (35, 'Ross', 'Geller', 'rossg@gmail.com');

SELECT * FROM TEACHER;

INSERT INTO Payments (payment_id, student_id, amount, payment_date)
VALUES
  (41, 1, 100.00, '2023-12-25'),
  (42, 2, 200.00, '2023-12-23'),
  (43, 3, 650.00, '2023-12-21'),
  (44, 4, 660.00, '2023-12-05'),
  (45, 5, 880.00, '2023-12-10'),
  (46, 6, 950.00, '2023-12-15'),
  (47, 7, 420.00, '2023-12-20'),
  (48, 8, 780.00, '2023-12-21'),
  (49, 10, 850.00, '2023-12-10');

SELECT * FROM Payments;

 
/*
1.Insert student into the "Students" table
*/
INSERT INTO Students VALUES (11, 'John', 'Doe', '1995-08-15',1234567890,'john.doe@example.com');



/*
2.Write an SQL query to enroll a student in a course. Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date.
*/


INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date) VALUES (33, 6, 18, '2023-12-28');
Select * from Enrollments;     


/*
3. Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address.
*/ 


UPDATE Teacher 
SET email = 'phoebe@gmail.com' WHERE teacher_id = 34;
Select * from TEACHER;   

/*
4. Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on student and course.
*/

DELETE FROM Enrollments
WHERE student_id = 6 AND enrollment_id = 33;


/*
5. Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables.
*/

UPDATE Courses SET teacher_id = 32 WHERE course_id = 11;
SELECT * FROM courses;

/*
6. Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity.
*/

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date)VALUES (34, 11, 16, '2023-12-15');

DELETE FROM Enrollments WHERE student_id = 11;
    
DELETE FROM Students WHERE student_id = 11;

SELECT * FROM STUDENTS;
SELECT * FROM enrollments;

/*
7. Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount.
*/
UPDATE Payments 
SET amount = 650.00 WHERE payment_id = 43;


--- JOINS

/*
1. Write an SQL query to calculate the total payments made by a specific student. You will need to join the "Payments" table with the "Students" table based on the student's ID
*/

SELECT s.student_id, s.first_name, s.last_name, SUM(p.amount) AS total_payments FROM Students s
JOIN Payments p 
ON s.student_id = p.student_id WHERE s.student_id = 1
GROUP BY s.student_id, s.first_name, s.last_name;

/*
2.Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. Use a JOIN operation between the "Courses" table and the "Enrollments" table.
*/

SELECT c.course_id, c.course_name, COUNT(e.student_id) AS enrolled_students 
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

/*
3. Write an SQL query to find the names of students who have not enrolled in any course. Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments
*/

SELECT s.student_id, s.first_name, s.last_name FROM Students s 
LEFT JOIN Enrollments e 
ON s.student_id = e.student_id 
WHERE e.enrollment_id IS NULL;

/*
4. Write an SQL query to retrieve the first name, last name of students, and the names of thecourses they are enrolled in. Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables.
*/

SELECT S.first_name, S.last_name, C.course_name
FROM STUDENTS S
INNER JOIN enrollments E
ON S.student_id=E.student_id
INNER JOIN COURSES C
ON E.course_id=C.course_id;

/*
5. Create a query to list the names of teachers and the courses they are assigned to. Join the
"Teacher" table with the "Courses" table.
*/

SELECT T.first_name,C.course_name
FROM TEACHER T
INNER JOIN courses C
ON T.teacher_id=C.teacher_id;


/*
6. Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the
"Students" table with the "Enrollments" and "Courses" tables.
*/

SELECT S.first_name, S.last_name, E.enrollment_date
FROM STUDENTS S
INNER JOIN enrollments E
ON S.student_id=E.student_id
INNER JOIN COURSES C
ON E.course_id=C.course_id
WHERE C.course_id=13;

/*
7. Find the names of students who have not made any payments. Use a LEFT JOIN between the
"Students" table and the "Payments" table and filter for students with NULL payment records.
*/

SELECT S.FIRST_NAME,S.last_name
FROM STUDENTS S
LEFT JOIN Payments P
ON S.student_id=P.student_id
WHERE P.payment_id IS NULL;

/*
8. Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN
between the "Courses" table and the "Enrollments" table and filter for courses with NULL
enrollment records.
*/

SELECT C.course_name
FROM COURSES C
LEFT JOIN enrollments E
ON C.course_id=E.course_id
WHERE E.course_id IS NULL;

/*
9. Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments"
table to find students with multiple enrollment records.
*/

SELECT DISTINCT
    e1.student_id
FROM
    Enrollments e1
JOIN
    Enrollments e2 ON e1.student_id = e2.student_id
                 AND e1.course_id <> e2.course_id;

/*
10. Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher"
table and the "Courses" table and filter for teachers with NULL course assignments.
*/

SELECT T.FIRST_NAME,T.last_name
FROM TEACHER T
LEFT JOIN COURSES C
ON T.teacher_id=C.teacher_id
WHERE C.teacher_id IS NULL;

/*
Aggregate Functions and Subqueries:
*/

/*
1. Write an SQL query to calculate the average number of students enrolled in each course. Use
aggregate functions and subqueries to achieve this.
*/

SELECT C.COURSE_ID,C.COURSE_NAME,(COUNT(*)/((SELECT COUNT(*) FROM courses)*1.0)) AS AVG_APPLICANTS
FROM COURSES C
INNER JOIN enrollments E
ON C.course_id=E.course_id
GROUP BY C.COURSE_ID,C.COURSE_NAME


/*
2. Identify the student(s) who made the highest payment. Use a subquery to find the maximum
payment amount and then retrieve the student(s) associated with that amount.
*/
SELECT * FROM Payments;
SELECT * FROM STUDENTS WHERE student_id IN ( SELECT student_id FROM Payments WHERE AMOUNT = MAX(AMOUNT) );

/*
3. Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the
course(s) with the maximum enrollment count.
*/

SELECT TOP 1 E.COURSE_ID as CID,COUNT(E.enrollment_id) AS No_Of_Enrollments
FROM Enrollments E
GROUP BY E.course_id
ORDER BY No_Of_Enrollments DESC


/*
4. Calculate the total payments made to courses
*/

SELECT  student_id,sum(amount) AS Total_Amount FROM payments
GROUP BY student_id




/*
5. Identify students who are enrolled in all available courses. Use subqueries to compare a
student's enrollments with the total number of courses.
*/

SELECT P1.FIRST_NAME,COUNT(P2.course_id) AS COURSES_TAKEN
FROM STUDENTS P1
INNER JOIN enrollments P2
ON P1.student_id=P2.student_id
GROUP BY P2.student_id,P1.first_name

/*
6. Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to
find teachers with no course assignments.
*/


SELECT * FROM
(
    SELECT P1.FIRST_NAME,P2.COURSE_ID AS CID
    FROM TEACHER P1
    LEFT JOIN COURSES P2
    ON P1.teacher_id=P2.teacher_id
) T WHERE CID IS NULL





/*
7. Calculate the average age of all students. Use subqueries to calculate the age of each student
based on their date of birth.
*/
SELECT STUDENT_ID,DATEDIFF(YEAR,P1.DATE_OF_BIRTH,GETDATE()) AS AGE FROM STUDENTS P1;
/*
8. Identify courses with no enrollments. Use subqueries to find courses without enrollment
records.
*/

SELECT * FROM 
(
    SELECT C1.COURSE_NAME,C2.course_id AS CID
    FROM courses C1
    LEFT JOIN enrollments C2
    ON C1.COURSE_ID=C2.COURSE_ID
) t WHERE CID IS NULL

/*
9. Calculate the total payments made by each student for each course they are enrolled in. Use
subqueries and aggregate functions to sum payments.
*/

SELECT P1.FIRST_NAME,P3.COURSE_NAME,P4.AMOUNT
FROM students P1
INNER JOIN enrollments P2
ON P1.student_id=P2.student_id
INNER JOIN COURSES P3
ON P2.course_id=P3.course_id
INNER JOIN Payments P4
ON P2.student_id=P4.[student_id ]

/*
10. Identify students who have made more than one payment. Use subqueries and aggregate
functions to count payments per student and filter for those with counts greater than one.
*/

SELECT P2.STUDENT_ID,P1.FIRST_NAME,COUNT(P2.student_id) AS COUNT
FROM students P1
INNER JOIN Payments P2
ON P1.student_id=P2.student_iD
GROUP BY P2.student_id,P1.first_name
HAVING COUNT(P2.student_id)>1


/*
11. Write an SQL query to calculate the total payments made by each student. Join the "Students"
table with the "Payments" table and use GROUP BY to calculate the sum of payments for each
student.
*/
SELECT P2.STUDENT_ID,P1.FIRST_NAME,SUM(P2.AMOUNT) AS TOTAL_AMOUNT
FROM students P1
INNER JOIN Payments P2
ON P1.student_id=P2.student_iD
GROUP BY P2.student_id,P1.first_name
/*
12. Retrieve a list of course names along with the count of students enrolled in each course. Use
JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to
count enrollments.
*/

SELECT P2.COURSE_ID,P1.COURSE_NAME,COUNT(STUDENT_ID) AS COUNT
FROM COURSES P1
INNER JOIN enrollments P2
ON P1.COURSE_ID=P2.COURSE_ID
GROUP BY P2.course_id,P1.course_name

/*
13. Calculate the average payment amount made by students. Use JOIN operations between the
"Students" table and the "Payments" table and GROUP BY to calculate the average.
*/

SELECT student_id,AVG(AMOUNT)
FROM Payments
GROUP BY student_id

SELECT P1.student_id ,SUM(P1.AMOUNT)/COUNT(*)
FROM PAYMENTS P1
INNER JOIN STUDENTS P2
ON P1.student_id=P2.student_id
GROUP BY P1.student_id
