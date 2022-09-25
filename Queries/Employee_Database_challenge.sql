SELECT
	e.emp_no, 
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t 
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count(title) DESC;


--Write a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
SELECT
	DISTINCT ON(e.emp_no)
	e.emp_no as "Employee No.",
	e.first_name as "First Name",
	e.last_name as "Last Name",
	e.birth_date as "Birthday",
	de.from_date as "Start Date",
	de.to_date as "Last Day",
	t.title as "Current Title",
	de.dept_no as "Current Department"
INTO mentorship_eligibility
FROM
employees as e
	INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
	INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
AND de.to_date = '9999-01-01'
AND t.to_date = de.to_date
AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no

--Get count of total eligible employees from Mentorship Program
SELECT COUNT("Employee No.") as "Total Eligible Employees"
FROM mentorship_eligibility 

--Get Count of Mentorship Eligible Employees by Dept. 
SELECT d.dept_name, COUNT(m."Employee No.")
FROM mentorship_eligibility as m
INNER JOIN departments as d
ON (m."Current Department" = d.dept_no)
GROUP BY "Current Department", d.dept_name
ORDER BY COUNT(m."Employee No.") DESC;

SELECT SUM(count) as "Total Titles Retiring"
FROM retiring_titles


---Get total mentorship eligible by title
SELECT COUNT("Employee No.") As "Number of Eligible Employees", "Current Title" as "Titles"
FROM mentorship_eligibility
GROUP BY "Current Title"
ORDER BY COUNT("Employee No.") DESC;

