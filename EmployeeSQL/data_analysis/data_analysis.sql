-- 1. List the employee number, last name, first name, sex, and salary of
--    each employee.
DROP VIEW IF EXISTS data_analysis1;
CREATE VIEW data_analysis1 AS
SELECT emp_no, last_name, first_name, sex,
(SELECT salaries.salary
	FROM salaries
	WHERE employees.emp_no = salaries.emp_no ) AS "salary"
FROM employees;
SELECT * FROM data_analysis1;

-- 2. List the first name, last name, and hire date for the employees who were
--    hired in 1986.
DROP VIEW IF EXISTS data_analysis2;
CREATE VIEW data_analysis2 AS
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%1986';
SELECT * FROM data_analysis2;

-- 3. List the manager of each department along with their department number,
--	  department name, employee number, last name, and first name.
DROP VIEW IF EXISTS data_analysis3;
CREATE VIEW data_analysis3 AS
SELECT dept_no,
(SELECT departments.dept_name
	FROM departments
	WHERE departments.dept_no = dept_manager.dept_no),
	emp_no,
(SELECT employees.last_name
	FROM employees
	WHERE employees.emp_no = dept_manager.emp_no),
(SELECT employees.first_name
	FROM employees
	WHERE employees.emp_no = dept_manager.emp_no)
FROM dept_manager;
SELECT * FROM data_analysis3;

-- 4. List the department number for each employee along with that employee’s
--	  employee number, last name, first name, and department name.
DROP VIEW IF EXISTS data_analysis4;
CREATE VIEW data_analysis4 AS
SELECT dept_no, emp_no,
(SELECT employees.last_name
	FROM employees
	WHERE employees.emp_no = dept_emp.emp_no),
(SELECT employees.first_name
	FROM employees
	WHERE employees.emp_no = dept_emp.emp_no),
(SELECT departments.dept_name
	FROM departments
	WHERE departments.dept_no = dept_emp.dept_no)
FROM dept_emp;
SELECT * FROM data_analysis4;

-- 5. List first name, last name, and sex of each employee whose first name is
--	  Hercules and whose last name begins with the letter B.
DROP VIEW IF EXISTS data_analysis5;
CREATE VIEW data_analysis5 AS
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
SELECT * FROM data_analysis5;

-- 6. List each employee in the Sales department, including their employee
--	  number, last name, and first name.
DROP VIEW IF EXISTS data_analysis6;
CREATE VIEW data_analysis6 AS
SELECT emp_no, last_name, first_name
FROM employees
WHERE emp_no IN
 (SELECT emp_no
  FROM dept_emp
  WHERE dept_no IN
   (SELECT dept_no
    FROM departments
    WHERE dept_name = 'Sales'));
SELECT * FROM data_analysis6;

-- 7. List each employee in the Sales and Development departments, including
--	  their employee number, last name, first name, and department name.
DROP VIEW IF EXISTS data_analysis7;
CREATE VIEW data_analysis7 AS
SELECT emp_no,
(SELECT employees.last_name
	FROM employees
	WHERE employees.emp_no = dept_emp.emp_no),
(SELECT employees.first_name
	FROM employees
	WHERE employees.emp_no = dept_emp.emp_no),
(SELECT departments.dept_name
	FROM departments
	WHERE departments.dept_no = dept_emp.dept_no)
FROM dept_emp
WHERE dept_no IN
 (SELECT dept_no
  FROM departments
  WHERE dept_name = 'Sales' OR dept_name = 'Development');
SELECT * FROM data_analysis7;

-- 8. List the frequency counts, in descending order, of all the employee
--    last names (that is, how many employees share each last name).
DROP VIEW IF EXISTS data_analysis8;
CREATE VIEW data_analysis8 AS
SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
ORDER BY count DESC;
SELECT * FROM data_analysis8;