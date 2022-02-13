-- Use Dictinct with Orderby to remove duplicate rows

-- Deliverable 1
--DROP TABLE if error occurs
DROP TABLE retirement_titles;
-- Table 1: Retirement Titles
Select e.emp_no, e.first_name, e.last_name, t.title,t.from_date, t.to_date, e.birth_date
INTO retirement_titles
From employees as e
INNER JOIN dept_employees AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
Where(e.birth_Date BETWEEN '1952-01-01' and '1955-12-31')
Order by (e.emp_no) ASC;
-- VIEW TABLE
Select * from retirement_titles;


-- DROP TABLE IF ERROR OCCURS
DROP TABLE unique_titles;
-- Table 2: Unique Titles(Use Retirement Titles)
Select DISTINCT ON(rt.emp_no) rt.emp_no, rt.first_name, rt.last_name, rt.title
Into unique_titles
FROM retirement_titles as rt
WHERE (rt.to_date = '9999-01-01')
Order by (rt.emp_no) ASC;
-- VIEW TABLE
SELECT * FROM unique_titles;


--DROP TABLE if error occurs
DROP TABLE retiring_titles_count;
-- Table 3 : UNIQUE TITLE COUNT
SELECT COUNT(ut.emp_no) , ut.title
INTO retiring_titles_count
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT DESC;
--View Table
SELECT * FROM retiring_titles_count;


-- Deliverable 2:
	-- Using the ERD you created in this module as a reference and your knowledge of SQL queries, 
	-- create a mentorship-eligibility table that holds the current employees who were born between:
	-- January 1, 1965 and December 31, 1965.
	
-- Drop Table if error/ inaccurate data stored for table
DROP TABLE mentorship_eligibilty;

SELECT DISTINCT ON(e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,de.from_date,de.to_date,t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
INNER JOIN dept_employees as de	
ON (e.emp_no = de.emp_no)
Where(e.birth_Date BETWEEN '1965-01-01' and '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY (e.emp_no) Asc;
--VIEW TABLE
SELECT * FROM mentorship_eligibilty;
--View Count
SELECT COUNT(*) FROM mentorship_eligibilty;



