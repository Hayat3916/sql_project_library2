-- SQL Project - Library Management System Q2

SELECT*FROM books;
SELECT*FROM branch;
SELECT*FROM employees;
SELECT*FROM issued_status;
SELECT*FROM members;
SELECT*FROM return_status;

/*Task 13: Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name,
book title, issue date, and days overdue.
*/

SELECT i.issued_member_id,m.member_name,
	b.book_title,i.issued_date,
	--rs.return_date,
	CURRENT_DATE - i.issued_date AS over_dues_days
FROM issued_status i
JOIN members m ON m.member_id = i.issued_member_id
JOIN books b ON b.isbn = i.issued_book_isbn
LEFT JOIN return_status rs ON rs.issued_id = i.issued_id
WHERE rs.return_date IS NULL AND (CURRENT_DATE - i.issued_date)>30
ORDER BY 1

/*
Task 14: Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, the number of 
books returned, and the total revenue generated from book rentals.
*/

CREATE TABLE branch_reports
 AS
SELECT
	b.branch_id,b.manager_id,
	COUNT(i.issued_id) AS number_book_issued,
	COUNT(r.return_id) AS number_of_book_return,
	SUM(bk.rental_price) AS total_revenue
FROM issued_status i
JOIN employees e ON i.issued_emp_id = e.emp_id
JOIN branch b ON e.branch_id = b.branch_id 
LEFT JOIN return_status r ON r.issued_id = i.issued_id
JOIN books bk ON i.issued_book_isbn = bk.isbn
GROUP BY b.branch_id,b.manager_id

SELECT*FROM branch_reports

/*
Task 15: CTAS: Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one 
book in the last 2 months.
*/
CREATE TABLE active_members
AS
SELECT*FROM members
WHERE member_id IN (SELECT DISTINCT issued_member_id
					FROM issued_status
					WHERE issued_date >= CURRENT_DATE - INTERVAL '2 MONTH'
					);
SELECT *FROM active_members;

/*
Task 16: Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, 
number of books processed, and their branch.
*/

SELECT 
	e.emp_name,
	b.*,
	COUNT(i.issued_id) AS no_book_issued
FROM issued_status i
JOIN employees e ON e.emp_id = i.issued_emp_id
JOIN branch b ON e.branch_id = b.branch_id
GROUP BY 1,2


