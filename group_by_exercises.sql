USE employees;

# 2
# Find all unique titles in titles table.
# Total unique titles: 7
SELECT DISTINCT title
FROM titles;

SELECT COUNT(DISTINCT title)
FROM titles;

# 3
# Find all unique last names that start and end with 'E'
SELECT last_name
FROM employees
GROUP BY last_name
HAVING last_name LIKE 'E%E';

# 4
# Find all unique combinations of first and last names where the last name starts and ends with 'E'.
SELECT first_name, last_name
FROM employees
GROUP BY first_name, last_name
HAVING last_name LIKE 'E%E';

# 5
# Find all unique last names with a 'q' but not 'qu'.
# Names:
#	Chleq
#	Lindqvist
#	Qiwen
SELECT last_name
FROM employees
GROUP BY last_name
HAVING last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

# 6
# Find all unique last names with a 'q' but not 'qu' and provide count of employees with those names.
SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
HAVING last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

# 7
# Find all employees with first name 'Irena', 'Vidya', or 'Maya' and provide count of employees with those
# names for each gender.
SELECT first_name, gender, COUNT(*)
FROM employees
GROUP BY first_name, gender
HAVING first_name IN ('Irena', 'Vidya', 'Maya');

# 8
# Generate usernames for all employees and get counts of each unique username.
# There are duplicate usernames generated.
SELECT 
	CONCAT(SUBSTR(LOWER(first_name), 1, 1),
		  SUBSTR(LOWER(last_name), 1, 4),
		  '_',
		  SUBSTR(birth_date, 6, 2),
		  SUBSTR(birth_date, 3, 2)) AS username, 
	COUNT(*) AS counts
FROM employees
GROUP BY username
ORDER BY counts DESC;

# Number of distinct duplicate usernames: 13251
# Total number of duplicate usernames: 27403
# or if total number of duplicates is defined as each duplicate generated after the first
# then number of duplicates is: 27403 - 13251 = 14152 or SUM(counts) - COUNT(username).
SELECT COUNT(username) AS total_distinct_duplicates, SUM(counts) AS total_duplicate_usernames
FROM
	(SELECT 
		CONCAT(SUBSTR(LOWER(first_name), 1, 1),
			  SUBSTR(LOWER(last_name), 1, 4),
		  	  '_',
		  	  SUBSTR(birth_date, 6, 2),
		 	  SUBSTR(birth_date, 3, 2)) AS username,
		COUNT(*) AS counts
	FROM employees
 	GROUP BY username
	HAVING COUNT(*) > 1) AS all_usernames;
	
# 9
# 9.1
# Determine historic average salary for each employee.
SELECT emp_no, AVG(salary)
FROM salaries
GROUP BY emp_no;

# 9.2
# Determine number of employees working in each department from dept_emp table.
SELECT dept_no, COUNT(emp_no)
FROM dept_emp
GROUP BY dept_no;

# 9.3
# Determine how many different salaries each employee has had.
SELECT emp_no, COUNT(salary)
FROM salaries
GROUP BY emp_no;

# 9.4
# Find the maximum salary for each employee.
SELECT emp_no, MAX(salary)
FROM salaries
GROUP BY emp_no;

# 9.5
# Find the minimum salary for each employee.
SELECT emp_no, MIN(salary)
FROM salaries
GROUP BY emp_no;

# 9.6
# Find the standard deviation of salaries for each employee.
SELECT emp_no, STDDEV(salary)
FROM salaries
GROUP BY emp_no;

# 9.7
# Find the max salary for each employee where that max salary is greater than $150,000.
SELECT emp_no, MAX(salary) as maximum
FROM salaries
GROUP BY emp_no
HAVING maximum > 150000;

# 9.8
# Find the average salary for each employee where that average salary is between $80k and $90k.
SELECT emp_no, AVG(salary) AS average
FROM salaries
GROUP BY emp_no
HAVING average BETWEEN 80000 AND 90000;