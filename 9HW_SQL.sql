
--Create Tables and assign foreign key constraints per ERD diagram

--UNCOMMENT TO DROP FOR TESTING
--DROP TABLE departments
--DROP TABLE employees
--DROP TABLE dept_employees
--DROP TABLE dept_managers
--DROP TABLE salaries
--DROP TABLE titles

--Create departments and employees first since they have the larges number of foreign key references
CREATE TABLE departments (
    dept_no VARCHAR PRIMARY KEY,
    dept_name VARCHAR NOT NULL
);

CREATE TABLE employees (
    emp_no INTEGER PRIMARY KEY NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    gender VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL	
);

--Create tables which reference above

CREATE TABLE dept_employees (
    emp_no INTEGER   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);


CREATE TABLE dept_managers (
    dept_no VARCHAR NOT NULL,
	emp_no INTEGER   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
	--FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	--FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


CREATE TABLE salaries (
    emp_no INTEGER   NOT NULL,
    salary INTEGER   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE titles (
    emp_no INTEGER   NOT NULL,
    title VARCHAR   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--Import .CSV files via GUI in PGAdmin and test

SELECT *
FROM departments
--OK

SELECT *
FROM dept_employees
--OK

SELECT *
FROM dept_managers

SELECT *
FROM employees
--OK

SELECT *
FROM salaries
--OK

SELECT *
FROM titles
--OK

--With All tables loaded, begin queries

-- --1. List the following details of each employee: employee number, last name, first name, gender, and salary.
-- SELECT 
-- 	employees.emp_no, 
-- 	employees.last_name, 
-- 	employees.first_name, 
-- 	employees.gender, 
-- 	salaries.salary
-- FROM employees
-- JOIN salaries
-- ON employees.emp_no = salaries.emp_no
-- --Type of join?

-- --2. List employees who were hired in 1986.
-- SELECT *
-- FROM employees
-- WHERE date_part('year', hire_date) = 1986
-- --ORDER BY --date/emp_no etc for readability, not mandatory.

-- --3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
-- SELECT 
-- 	departments.dept_no, 
-- 	departments.dept_name,
-- 	dept_managers.emp_no,
-- 	employees.last_name,
-- 	employees.first_name,
-- 	dept_managers.from_date,
-- 	dept_managers.to_date
-- FROM employees
-- INNER JOIN dept_managers ON dept_managers.emp_no = employees.emp_no --Match Dept Manager ID to employee ID
-- INNER JOIN departments ON departments.dept_no = dept_managers.dept_no -- Match Dept Number to Dept Manager
-- --INNER JOIN


-- --4. List the department of each employee with the following information: employee number, last name, first name, and department name.
-- SELECT
-- 	employees.emp_no, 
-- 	employees.last_name,
-- 	employees.first_name,
-- 	departments.dept_name
-- FROM employees
-- INNER JOIN dept_employees ON dept_employees.emp_no = employees.emp_no --Match Dept/Employees ID to employee ID
-- INNER JOIN departments ON departments.dept_no = dept_employees.dept_no -- Match Dept Number to Dept Name

-- --5.List all employees whose first name is "Hercules" and last names begin with "B."
-- SELECT *
-- FROM employees
-- WHERE employees.first_name = 'Hercules' and employees.last_name LIKE 'B%'

-- --6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
-- SELECT
-- 	employees.emp_no, 
-- 	employees.last_name,
-- 	employees.first_name,
-- 	departments.dept_name
-- FROM employees
-- INNER JOIN dept_employees ON dept_employees.emp_no = employees.emp_no --Match Dept/Employees ID to employee ID
-- INNER JOIN departments ON departments.dept_no = dept_employees.dept_no -- Match Dept Number to Dept Name
-- WHERE departments.dept_name ='Sales'

-- --7.List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
-- SELECT
-- 	employees.emp_no, 
-- 	employees.last_name,
-- 	employees.first_name,
-- 	departments.dept_name
-- FROM employees
-- INNER JOIN dept_employees ON dept_employees.emp_no = employees.emp_no --Match Dept/Employees ID to employee ID
-- INNER JOIN departments ON departments.dept_no = dept_employees.dept_no -- Match Dept Number to Dept Name
-- WHERE departments.dept_name ='Sales' OR departments.dept_name = 'Development'

-- --8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
-- SELECT 
-- 	employees.last_name,
-- 	COUNT(employees.last_name)
-- FROM employees
-- GROUP BY employees.last_name
-- ORDER BY COUNT(employees.last_name) DESC


