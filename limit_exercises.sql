USE employees;

# 2
# List the first 10 distinct last names in employees sorted in descending order
SELECT DISTINCT last_name FROM employees ORDER BY last_name DESC LIMIT 10;

# 3
# Find employees hired in the 90s and born on Christmas
# sorted by hire date and limited to just the first 5 results
# Names returned:
#	Alselm Cappello
#	Utz Mandell
#	Bouchung Schreiter
#	Baocai Kushner
#	Petter Stroustrup
SELECT * FROM employees 
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' 
	AND DATE_FORMAT(birth_date, '%m-%d') = DATE_FORMAT('9999-12-25', '%m-%d')
ORDER BY hire_date LIMIT 5;

# 4
# Find employees hired in the 90s and born on Christmas
# sorted by hire date and limited to just 5 results
# and offset to provide the tenth page of results given
# that each page has 5 results. Offset is 45 because the
# tenth page will be at offset 10 * 5 - 5 since the offset
# for the first page is 0.
# Names returned:
#	Pranay Narwekar
#	Marjo Farrow
#	Ennio Karcich
#	Dines Lubachevsky
#	Ipke Fontan
SELECT * FROM employees 
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' 
	AND DATE_FORMAT(birth_date, '%m-%d') = DATE_FORMAT('9999-12-25', '%m-%d')
ORDER BY hire_date LIMIT 5 OFFSET 45;

# LIMIT will specify the number of rows to show on a page and OFFSET will specify the page number in the form
# (page number * number of rows per page - number of rows per page).