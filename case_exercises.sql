# 1
# Write a query that returns all employees, their department number, their start date,
# their end date, and a new column 'is_current_employee' that is a 1 if the employee is
# still with the company and 0 if not.
SELECT
    CONCAT(employees.first_name, ' ', employees.last_name) AS Name,
    dept_emp.dept_no AS Department_Number,
    employees.hire_date AS Start_Date,
    dept_emp.to_date AS End_Date,
    IF(dept_emp.to_date > CURDATE(), 1, 0) AS is_current_employee
FROM employees
JOIN dept_emp USING (emp_no)
ORDER BY Name;

# This query will get only the most recent position held by each employee. Start date is
# the hiring date.
SELECT
    CONCAT(employees.first_name, ' ', employees.last_name) AS Name,
    most_recent.dept_no AS Department_Number,
    employees.hire_date AS Start_Date,
    most_recent.to_date AS End_Date,
    IF(most_recent.to_date > CURDATE(), 1, 0) AS is_current_employee
FROM employees
JOIN
    (
        # Get the dept_no corresponding to each employee's most recent to_date
        SELECT
            dept_emp.emp_no,
            dept_emp.dept_no,
            most_recent.to_date
        FROM dept_emp
        JOIN
            (
                # Get the most recent to_date for each emp_no
                SELECT
                    emp_no,
                    MAX(to_date) AS to_date
                FROM dept_emp
                GROUP BY emp_no
            ) AS most_recent
            USING (emp_no, to_date)
    ) AS most_recent
    USING (emp_no)
ORDER BY Name;

# 2
# Write a query that returns all employee names (previous and current), and a new column 
# 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT
	CONCAT(first_name, ' ', last_name) AS Name,
	CASE 
		WHEN last_name REGEXP '^[A-H].*' THEN 'A-H'
		WHEN last_name REGEXP '^[I-Q].*' THEN 'I-Q'
		ELSE 'R-Z'
	END AS Alpha_Group
FROM employees
ORDER BY last_name;

# 3
# How many employees (current or previous) were born in each decade?
# Results:
# 40s: 0, 50s: 182886, 60s: 117138, 70s: 0
SELECT
	SUM(IF(birth_date LIKE '194%', 1, 0)) AS Born_in_the_40s,
	SUM(IF(birth_date LIKE '195%', 1, 0)) AS Born_in_the_50s,
	SUM(IF(birth_date LIKE '196%', 1, 0)) AS Born_in_the_60s,
	SUM(IF(birth_date LIKE '197%', 1, 0)) AS Born_in_the_70s
FROM employees;

# 4
# What is the current average salary for each of the following department groups: 
# R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT
	CASE
		WHEN departments.dept_name IN ('Research', 'Development') THEN 'R&D'
		WHEN departments.dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
		WHEN departments.dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
		WHEN departments.dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
		ELSE 'Customer Service'
	END AS Department_Group,
	AVG(salaries.salary) AS Average_Salary
FROM salaries
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
WHERE salaries.to_date > CURDATE()
	AND dept_emp.to_date > CURDATE()
GROUP BY Department_Group
ORDER BY Average_Salary DESC;