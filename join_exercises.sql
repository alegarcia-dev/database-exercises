# Join Example Database

# 1
USE join_example_db;

# 2
# inner join
SELECT users.name, roles.name
FROM users
JOIN roles
	ON users.role_id = roles.id;
	
# left join
SELECT users.name, roles.name
FROM users
LEFT JOIN roles
	ON users.role_id = roles.id;
	
# right join
SELECT users.name, roles.name
FROM users
RIGHT JOIN roles
	ON users.role_id = roles.id;
	
# 3
# Get list of roles along with the number of users that has that role.
SELECT roles.name, COUNT(users.id)
FROM roles
LEFT JOIN users
	ON users.role_id = roles.id
GROUP BY roles.name;

# Employees Database

# 1
USE employees;

# 2
# Show each department along with the name of the current manager for that department.
SELECT d.dept_name, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
JOIN dept_manager AS dm
	ON dm.emp_no = e.emp_no
JOIN departments AS d
	ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01'
ORDER BY d.dept_name;

# 3
# Find the name of all departments currently managed by women.
SELECT 
	departments.dept_name AS department_name, 
	CONCAT(employees.first_name, ' ', employees.last_name) AS full_name,
	employees.gender AS gender
FROM employees
JOIN dept_manager
	ON employees.emp_no = dept_manager.emp_no
JOIN departments
	ON dept_manager.dept_no = departments.dept_no
WHERE gender = 'F' AND dept_manager.to_date > CURDATE()
ORDER BY departments.dept_name;

# 4
# Find the current titles of employees currently working in the Customer Service department.
SELECT titles.title, COUNT(*)
FROM titles
JOIN dept_emp
	ON titles.emp_no = dept_emp.emp_no
JOIN departments
	ON dept_emp.dept_no = departments.dept_no
WHERE titles.to_date > CURDATE()
	AND dept_emp.to_date > CURDATE()
	AND departments.dept_name = 'Customer Service'
GROUP BY titles.title
ORDER BY titles.title;

# 5
# Find the current salary of all current managers.
SELECT 
	departments.dept_name as Department_Name,
	CONCAT(employees.first_name, ' ', employees.last_name) AS Name,
	salaries.salary AS Salary
FROM dept_manager
JOIN departments
	ON dept_manager.dept_no = departments.dept_no
JOIN employees
	ON dept_manager.emp_no = employees.emp_no
JOIN salaries
	ON dept_manager.emp_no = salaries.emp_no
WHERE dept_manager.to_date > CURDATE()
	AND salaries.to_date > CURDATE()
ORDER BY departments.dept_name;

# 6
# Find the number of current employees in each department.
SELECT dept_emp.dept_no, departments.dept_name, COUNT(*) as num_employees
FROM dept_emp
JOIN departments
	ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date > CURDATE()
GROUP BY dept_emp.dept_no
ORDER BY dept_emp.dept_no;

# 7
# Which department has the highest average salary? Hint: Use current not historic information.
SELECT departments.dept_name, AVG(salaries.salary) AS average_salary
FROM salaries
JOIN dept_emp
	ON salaries.emp_no = dept_emp.emp_no
JOIN departments
	ON dept_emp.dept_no = departments.dept_no
WHERE salaries.to_date > CURDATE()
	AND dept_emp.to_date > CURDATE()
GROUP BY dept_emp.dept_no
ORDER BY average_salary DESC
LIMIT 1;

# 8
# Who is the highest paid employee in the Marketing department?
SELECT
	employees.first_name,
	employees.last_name
FROM dept_emp
JOIN departments
	ON dept_emp.dept_no = departments.dept_no
JOIN salaries
	ON dept_emp.emp_no = salaries.emp_no
JOIN employees
	ON dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name = 'Marketing'
	AND salaries.to_date > CURDATE()
	AND dept_emp.to_date > CURDATE()
ORDER BY salaries.salary DESC
LIMIT 1;

# 9
# Which current department manager has the highest salary?
SELECT
	employees.first_name,
	employees.last_name,
	salaries.salary,
	departments.dept_name
FROM employees
JOIN dept_manager
	ON employees.emp_no = dept_manager.emp_no
JOIN salaries
	ON employees.emp_no = salaries.emp_no
JOIN departments
	ON dept_manager.dept_no = departments.dept_no
WHERE dept_manager.to_date > CURDATE()
	AND salaries.to_date > CURDATE()
ORDER BY salaries.salary DESC
LIMIT 1;

# 10
# Determine the average salary for each department. Use all salary information and round your results.
SELECT departments.dept_name, ROUND(AVG(salaries.salary), 0) AS average_salary
FROM salaries
JOIN dept_emp
	ON salaries.emp_no = dept_emp.emp_no
JOIN departments
	ON dept_emp.dept_no = departments.dept_no
GROUP BY dept_emp.dept_no
ORDER BY average_salary DESC;

# 11
# Find the names of all current employees, their department name, and their current manager's name.
SELECT 
	CONCAT(employees.first_name, ' ', employees.last_name) AS Employee_Name,
	departments.dept_name AS Department_Name,
	managers.Manager_Name
FROM employees
JOIN dept_emp
	ON employees.emp_no = dept_emp.emp_no
JOIN departments
	ON dept_emp.dept_no = departments.dept_no
JOIN
	(
		SELECT
			CONCAT(employees.first_name, ' ', employees.last_name) AS Manager_Name,
			departments.dept_name AS Department_Name
		FROM employees
		JOIN dept_emp
			ON employees.emp_no = dept_emp.emp_no
		JOIN departments
			ON dept_emp.dept_no = departments.dept_no
		JOIN dept_manager
			ON employees.emp_no = dept_manager.emp_no
		WHERE dept_manager.to_date > CURDATE()
	) AS managers
	ON departments.dept_name = managers.Department_Name
WHERE dept_emp.to_date > CURDATE()
ORDER BY departments.dept_name, Employee_Name;

# 12
# Who is the highest paid employee within each department.
SELECT 
	CONCAT(employees.first_name, ' ', employees.last_name) AS Name,
	departments.dept_name AS Department,
	highest_salaries.salary AS Salary
FROM dept_emp
JOIN salaries USING(emp_no)
JOIN departments USING(dept_no)
JOIN employees USING(emp_no)
JOIN (
		SELECT
			dept_emp.dept_no AS dept_number,
			MAX(salaries.salary) AS salary
		FROM salaries
		JOIN dept_emp USING(emp_no)
		WHERE salaries.to_date > CURDATE()
		GROUP BY dept_emp.dept_no
	) AS highest_salaries
	ON highest_salaries.salary = salaries.salary
	AND highest_salaries.dept_number = dept_emp.dept_no;