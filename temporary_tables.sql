# 1
# Create a temporary table called employees_with_departments that contains 
# first_name, last_name, and dept_name for employees currently with that department.
USE employees;

CREATE TEMPORARY TABLE innis_1653.employees_with_departments AS
	SELECT
		employees.first_name,
		employees.last_name,
		departments.dept_name
	FROM employees
	JOIN dept_emp USING (emp_no)
	JOIN departments USING (dept_no)
    WHERE dept_emp.to_date > CURDATE();

# Switch to database with full permissions
USE innis_1653;

# 1a
# Add a column named full_name to this table. It should be a VARCHAR 
# whose length is the sum of the lengths of the first name and last name columns.
# Length of full_name is the sum of the lengths of first_name and last_name
# plus 1 to account for the space between each name.
ALTER TABLE employees_with_departments
ADD full_name VARCHAR(31);

# 1b
# Update the table so that full name column contains the correct data.
UPDATE employees_with_departments
SET full_name = 
	CONCAT(first_name, ' ', last_name);

# 1c
# Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments
DROP COLUMN first_name,
DROP COLUMN last_name;

# 1d
# What is another way you could have ended up with this same table?
# This method automatically sets the full_name column to the correct length.
USE employees;

CREATE TEMPORARY TABLE innis_1653.employees_with_departments AS
	SELECT
		CONCAT(employees.first_name, ' ', employees.last_name) AS full_name,
		departments.dept_name
	FROM employees
	JOIN dept_emp USING (emp_no)
	JOIN departments USING (dept_no)
    WHERE dept_emp.to_date > CURDATE();

# 2
# Create a temporary table based on the payment table from the sakila database.
# Write the SQL necessary to transform the amount column such that it is stored
# as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
USE sakila;

# Create new temporary table based on payment table
CREATE TEMPORARY TABLE innis_1653.payment_modified
AS SELECT * FROM payment;

USE innis_1653;

# Add new column for amount in cents as an integer
ALTER TABLE payment_modified
ADD amount_cents INT;

# Update values for amount_cents column
UPDATE payment_modified
SET amount_cents = amount * 100;

# Remove original amount column and rename amount_cents to amount
ALTER TABLE payment_modified
DROP COLUMN amount;

ALTER TABLE payment_modified
RENAME COLUMN amount_cents TO amount;

# 3
# Find out how the current average pay in each department compares to the overall, 
# historical average pay. In order to make the comparison easier, you should use the 
# Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?
# Best department to work in: Sales
# Worst department to work in: Human Resources
USE employees;

# Create table of current average salaries for each deparment
CREATE TEMPORARY TABLE innis_1653.current_average_salaries
AS
	SELECT
		departments.dept_name AS Department,
		AVG(salaries.salary) AS Current_Average_Salary
	FROM salaries
	JOIN dept_emp USING (emp_no)
	JOIN departments USING (dept_no)
	WHERE salaries.to_date > CURDATE()
	GROUP BY Department;

# Calculate the overall average salary
CREATE TEMPORARY TABLE innis_1653.overall_average_salary
AS SELECT AVG(salary) FROM salaries;

 # Calculate the overall standard deviation
CREATE TEMPORARY TABLE innis_1653.overall_standard_deviation
AS SELECT STDDEV(salary) FROM salaries;

# Calculate the z_scores
USE innis_1653;

SELECT
	Department,
	ROUND((Current_Average_Salary - (SELECT * FROM overall_average_salary))
	/
	(SELECT * FROM overall_standard_deviation), 6) AS Z_Score
FROM current_average_salaries
ORDER BY Z_Score;