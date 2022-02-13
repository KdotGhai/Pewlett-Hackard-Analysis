-- Creating tables for PH-EmployeeDB

--DROP TABLE employees CASCADE; --(Only if error is generated)
-- Depratments
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
); -- select * from departments; -- Test Run outputs
-- Employees
CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);-- select * from employees; -- Test Run outputs
-- Department Managers
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);-- select * from dept_manager; -- Test Run outputs
-- Salaries
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);-- select * from salaries; -- Test Run outputs
DROP TABLE titles;
-- Titles
CREATE TABLE titles (
  emp_no INT NOT NULL,
  title varchar NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  Foreign key(emp_no) references employees (emp_no),
  Primary key(emp_no,title,from_date )
);-- select * from titles; -- Test Run outputs
-- Depratment Employees
CREATE TABLE dept_employees (
  emp_no INT NOT NULL,
  dept_no VARCHAR NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  FOREIGN KEY (emp_no) REFERENCES salaries (emp_no),
  PRIMARY KEY (emp_no,dept_no)
);   -- select * from dept_employees; -- Test Run outputs

-- Count employees 
SELECT COUNT(*)FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

--count employees within the year of 1952
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create New Tables using "Selct Into"
	-- Same as code above but instead of generating a count store dinto list we store into new table
	-- Select the data we want listed and FROM which data table but in between we use INTO
	-- the INTO instructs a new table be made as well as, naming it
	-- We use Where to filter the data we desire
	-- ***** This data is skewed/inaccurate since it includes all employees, we want only retiring
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
	-- Test run to see the new table "retirement_info"; SELECT * FROM retirement_info;
SELECT * FROM retirement_info; -- make sure to refresh to see new table

-- Join Tables example
	-- in this case the left table is the table written after the From statement: "titles" in this case
	-- here we are merging titles onto Employees with matching data being 'emp_no'
Select first_name, last_name, title
from employees as e
Right Join titles as t on e.emp_no = t.emp_no;

-- Dropping Retirement table
	-- We're Dropping it since the data is including all employees and not the ones retiring exclusively 
DROP TABLE retirement_info;

-- Create NEW table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;


-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_employees as de ON ri.emp_no = de.emp_no;

-- Combine Retirementt info with Department Employees table
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_employees as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO emp_count_by_dept
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Check data for salaries in order: decending
SELECT * FROM salaries
ORDER BY to_date DESC;

-- Going to Sort Salaries by filtering dates first in employees
SELECT emp_no, first_name, last_name, gender
--INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--DROP TABLE emp_info;

-- List 1: Employee Information
-- We're going to do a join of (Salaries & Employees) also (Department Employees & Employees)
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
     AND (de.to_date = '9999-01-01');


-- List 2: Management
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
--INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
-- List 3: Department Retirees
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_employees AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- SKILL DRILL
-- Create a query that will return only the information relevant to the Sales team. The requested list includes:
	--Employee numbers
	--Employee first name
	--Employee last name
	--Employee department name
	-- *** For retiring peeps(using 'retirement_info' table)
	
Select ri.emp_no, ri.first_name, ri.last_name, d.dept_name
from retirement_info as ri
INNER JOIN dept_employees AS de
ON (ri.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
Where (d.dept_name = 'Sales');

-- Skill Drill: Same as above however, filter for two departments('Sales','Development')
-- requires to use "in" when filtering in the 'Where' statement as shown below
Select ri.emp_no, ri.first_name, ri.last_name, d.dept_name
from retirement_info as ri
INNER JOIN dept_employees AS de
ON (ri.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
Where (d.dept_name in ('Sales','Development'));