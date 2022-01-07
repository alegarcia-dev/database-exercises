USE employees;

# Find all employees with the first name 'Irena', 'Vidya', or 'Maya' ordered by first name.
# Name in first row: Irena Reutenauer
# Name in last row: Vidya Simmen
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name;

# Find all employees with the first name 'Irena', 'Vidya', or 'Maya' ordered by first name and then last name.
# Name in first row: Irena Acton
# Name in last row: Vidya Zweizig
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name, last_name;

# Find all employees with the first name 'Irena', 'Vidya', or 'Maya' ordered by last name and then first name.
# Name in first row: Irena Acton
# Name in last row: Maya Zyda
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name, first_name;

# Find all employees whose last name starts and ends with E ordered by emp_no.
# 899 rows returned
# Name in first row: Ramzi Erde, emp_no: 10021
# Name in last row: Tadahiro Erde, emp_no: 499648
SELECT * FROM employees WHERE last_name LIKE 'E%E' ORDER BY emp_no;

# Find all employees whose last name starts and ends with E ordered by hire date from latest date to earliest date.
# 899 rows returned
# Name of newest employee: Teiji Eldridge, hire date: 1999-11-27
# Name of oldest employee: Sergi Erde, hire date: 1985-02-02
SELECT * FROM employees WHERE last_name LIKE 'E%E' ORDER BY hire_date DESC;

# Find all employees hired in the 90s and born on Christmas sorted
# such that the oldest employee who was hired last is the first result.
# 362 rows returned
# Name of oldest employee hired last: Khun Bernini
# Name of youngest employee hired first: Douadi Pettis
SELECT * FROM employees 
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' 
	AND DATE_FORMAT(birth_date, '%m-%d') = DATE_FORMAT('9999-12-25', '%m-%d') 
ORDER BY birth_date, hire_date DESC;