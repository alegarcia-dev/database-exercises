USE employees;

# 2 
# Find all employees whose last name starts and ends with E listed with
# full_name column combining both first and last name.
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees WHERE last_name LIKE 'E%E';

# 3 
# Same as last query with results in all uppercase.
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS full_name FROM employees WHERE last_name LIKE 'E%E';

# 4
# Find all employees hired in the 90s and born on Christmas
# and display total days of employment
SELECT *, DATEDIFF(CURDATE(), hire_date) AS total_days_of_employment FROM employees 
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' 
	AND DATE_FORMAT(birth_date, '%m-%d') = DATE_FORMAT('9999-12-25', '%m-%d');
	
# 5
# Find the smallest and largest current salary from the salaries table
# Smallest salary: 38623
# Largest salary: 158220
SELECT MIN(salary), MAX(salary) FROM salaries;

# 6
# Generate table of usernames with conditions: all lowercase, first character of first name
# first 4 characters of last name, an underscore, month, and last two digits of year.
# Limit 50 so it doesn't take so long to execute.
SELECT 
	CONCAT(SUBSTR(LOWER(first_name), 1, 1),
		 SUBSTR(LOWER(last_name), 1, 4),
		  '_',
		  LPAD(MONTH(birth_date), 2, '0'),
		  SUBSTR(YEAR(birth_date), 3, 2)), 
	first_name,
	last_name,
	birth_date 
FROM employees LIMIT 50;