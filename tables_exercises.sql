USE employees;

# List all the tables
SHOW TABLES;

# Exploring the employees table
DESCRIBE employees;
# Data types in the employees table: int, date, varchar(14), varchar(16), enum('M', 'F'), date

# Exploring all the other tables
DESCRIBE current_dept_emp;
DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE dept_emp_latest_date;
DESCRIBE dept_manager;
DESCRIBE salaries;
DESCRIBE titles;
# All tables except 'departments' have numeric types
# All tables except 'dept_emp_latest_date' and 'salaries' have string types
# All tables except 'departments' have date types

# The employees and departments tables don't seem to have any relationship other than that they are both in the same database

# Show SQL to create dept_manager table
SHOW CREATE TABLE dept_manager;