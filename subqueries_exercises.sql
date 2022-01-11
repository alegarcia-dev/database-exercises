# 1
# Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT
	employees.emp_no,
	employees.hire_date
FROM employees
JOIN dept_emp
    ON employees.emp_no = dept_emp.emp_no
WHERE employees.hire_date = 
	(SELECT hire_date FROM employees WHERE emp_no = 101010)
    AND dept_emp.to_date > CURDATE();

# 2
# Find all the titles ever held by all current employees with the first name Aamod.
SELECT
	title,
	emp_no
FROM titles
WHERE emp_no IN
	(SELECT emp_no FROM employees WHERE first_name = 'Aamod')
	AND to_date > CURDATE();

# 3
# How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
# Number of non-current employees: 85108
SELECT COUNT(*)
FROM employees
WHERE emp_no IN
	(
		SELECT emp_no
		FROM dept_emp
		WHERE to_date < CURDATE()
	);

# 4
# Find all the current department managers that are female. List their names in a comment in your code.
# Names:
#   Isamu Legleitner
#   Karsten Sigstam
#   Leon DesSarma
#   Hilary Kambil
SELECT CONCAT(first_name, ' ', last_name)
FROM employees
WHERE emp_no IN
	(SELECT emp_no FROM dept_manager WHERE to_date > CURDATE())
	AND gender = 'F';

# 5
# Find all the employees who currently have a higher salary than the company's overall, historical average salary.
SELECT
	CONCAT(employees.first_name, ' ', employees.last_name),
	salaries.salary
FROM employees
JOIN salaries
	ON employees.emp_no = salaries.emp_no
WHERE salaries.to_date > CURDATE()
	AND salaries.salary > (SELECT AVG(salary) FROM salaries);

# 6
# How many current salaries are within 1 standard deviation of the current highest salary? 
# (Hint: you can use a built in function to calculate the standard deviation.) 
# What percentage of all salaries is this?
SELECT COUNT(*)
FROM salaries
WHERE (SELECT STDDEV(salary) FROM salaries) >
	(SELECT MAX(salary) FROM salaries) - salary;

# BONUS

# 1
# Find all the department names that currently have female managers.
SELECT departments.dept_name
FROM departments
JOIN dept_manager
	ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date > CURDATE()
	AND dept_manager.emp_no IN
		(SELECT emp_no FROM employees WHERE gender = 'F');

# 2
# Find the first and last name of the employee with the highest salary.
SELECT CONCAT(first_name, ' ', last_name)
FROM employees
WHERE emp_no = 
(
	SELECT emp_no
	FROM salaries
	WHERE salary = 
	(
		SELECT MAX(salary)
		FROM salaries
		WHERE to_date > CURDATE()
	)
);

# 3
# Find the department name that the employee with the highest salary works in.
SELECT dept_name
FROM departments
WHERE dept_no =
(
	SELECT dept_no
	FROM dept_emp
	WHERE emp_no = 
	(
		SELECT emp_no
		FROM salaries
		WHERE salary = 
		(
			SELECT MAX(salary)
			FROM salaries
			WHERE to_date > CURDATE()
		)
	)
);