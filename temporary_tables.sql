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
