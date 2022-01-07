USE employees;

# Find all employees with the name 'Irena', 'Vidya', or 'Maya'.
# 709 rows returned
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');

# Same as previous query, but using OR instead of IN
# 709 rows returned
SELECT * FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';

# Find all employees with the name 'Irena', 'Vidya', or 'Maya' and who are male.
# 441 rows returned
SELECT * FROM employees WHERE gender = 'M' AND (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya');

# Find all employees whose last name starts with E
# 7330 rows returned
SELECT * FROM employees WHERE last_name LIKE 'E%';

# Find all employees whose last name starts or ends with E
# 30723 rows returned
SELECT * FROM employees WHERE last_name LIKE 'E%' OR last_name LIKE '%E';
# Find all employees whose last name ends with E but does not start with E
# 23393 rows returned
SELECT * FROM employees WHERE last_name LIKE '%E' AND last_name NOT LIKE 'E%';

# Find all employees whose last name starts and ends with E
# 899 rows returned
SELECT * FROM employees WHERE last_name LIKE 'E%E';
# Find all employees whose last name ends with E regardless if they start with E
# 24292 rows returned
SELECT * FROM employees WHERE last_name LIKE '%E';

# Find all employees hired in the 90s
# 135214 rows returned
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

# Find all employees born on Christmas
# 842 rows returned
SELECT * FROM employees WHERE DATE_FORMAT(birth_date, '%m-%d') = DATE_FORMAT('9999-12-25', '%m-%d');

# Find all employees hired in the 90s and born on Christmas
# 362 rows returned
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' AND DATE_FORMAT(birth_date, '%m-%d') = DATE_FORMAT('9999-12-25', '%m-%d');

# Find all employees with a 'q' in their last name
# 1873 rows returned
SELECT * FROM employees WHERE last_name LIKE '%q%';

# Find all employees with a 'q' in their last name but not 'qu'
# 547 rows returned
SELECT * FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';