SELECT*FROM books;
SELECT*FROM branch;
SELECT*FROM employees;
SELECT*FROM members;
SELECT*FROM issued_status;
SELECT*FROM return_status;

--Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books 
 VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')
 SELECT*FROM books;

-- Task 2: Update an Existing Member's Address

UPDATE members
SET member_address = '125 Oak St'
WHERE member_id = 'C101';
SELECT*FROM members;

--Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM issued_status
WHERE issued_id =  'IS121';
SELECT*FROM issued_status;

--Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'

SELECT * FROM issued_status
WHERE issued_emp_id = 'E101'
SELECT*FROM issued_status

--Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT issued_emp_id,COUNT(issued_id) AS Total_issued_books
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(*)>1

-- CTAS
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt.

CREATE TABLE book_cnts
AS
 SELECT b.isbn,b.book_title,COUNT(i.issued_id) AS no_books_issued
 FROM books b
 JOIN issued_status i
 ON i.issued_book_isbn = b.isbn
 GROUP BY b.isbn,b.book_title

 SELECT*FROM book_cnts

 --Task 7. Retrieve All Books in a Specific Category:

 SELECT books
 WHERE category = 'Classic'
ory
 --Task 8: Find Total Rental Income by Category:

 SELECT b.category, SUM(b.rental_price) AS Total_rental_income,
 		COUNT(*)
 FROM books b
 JOIN issued_status i ON i.issued_book_isbn = b.isbn
 GROUP BY b.category

 --Task 9: List Members Who Registered in the Last 180 Days:
 
 SELECT*FROM Members
 WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days'

INSERT INTO members (member_id,member_name,member_address,reg_date)
VALUES
('C122','sam','145 main st','2025-06-12'),
('C123','john','115 main st','2025-04-11')

 --Task 10: List Employees with Their Branch Manager's Name and their branch details:

SELECT e1.*,
		b.manager_id,
		e2.emp_name AS manager
FROM employees e1
JOIN branch b ON e1.branch_id = b.branch_id
JOIN employees e2 ON b.manager_id =e2.emp_id

--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:
CREATE TABLE boos_price_gt_seven
AS
SELECT*FROM books
WHERE rental_price>7

SELECT*FROM boos_price_gt_seven

--Task 12: Retrieve the List of Books Not Yet Returned

SELECT DISTINCT i.issued_book_name
FROM issued_status i
LEFT JOIN return_status r ON i.issued_id = r.issued_id
WHERE r.return_id IS NULL


