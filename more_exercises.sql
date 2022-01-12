# Employees database

USE employees;

# 1
# How much do the current managers of each department get paid, relative to the average salary for the department?
# Is there any department where the department manager gets paid less than the average salary?
# There are two departments (Production and Customer Service) where the manager gets paid less than the department average.
SELECT
	CONCAT(employees.first_name, ' ', employees.last_name) AS Name,
	departments.dept_name AS Department,
	salaries.salary AS Salary,
	averages.average AS Department_Average,
	salaries.salary - averages.average AS Difference
FROM dept_manager
JOIN employees USING (emp_no)
JOIN departments USING (dept_no)
JOIN salaries USING (emp_no)
JOIN 
	(
		SELECT
			AVG(salaries.salary) AS average,
			dept_emp.dept_no
		FROM salaries
		JOIN dept_emp USING (emp_no)
		GROUP BY dept_no
	) AS averages
	USING (dept_no)
WHERE dept_manager.to_date > CURDATE()
	AND salaries.to_date > CURDATE()
ORDER BY Difference;

# World database

USE world;

# 1
# What languages are spoken in Santa Monica?
SELECT
	countrylanguage.Language,
	countrylanguage.Percentage
FROM countrylanguage
JOIN city USING (CountryCode)
WHERE city.Name = 'Santa Monica'
ORDER BY countrylanguage.Percentage;

# 2
# How many different countries are in each region?
SELECT
	Region,
	COUNT(*) AS num_countries
FROM country
GROUP BY Region
ORDER BY num_countries;

# 3
# What is the population for each region?
SELECT
	Region,
	SUM(Population) AS population
FROM country
GROUP BY Region
ORDER BY population DESC;

# 4
# What is the population for each continent?
SELECT
	Continent,
	SUM(Population) AS population
FROM country
GROUP BY Continent
ORDER BY population DESC;

# 5
# What is the average life expectancy globally?
SELECT AVG(LifeExpectancy) FROM country;

# 6
# What is the average life expectancy for each region? Sort the results from shortest to longest.
SELECT
	Region, 
	AVG(LifeExpectancy) AS life_expectancy
FROM country
GROUP BY Region
ORDER BY life_expectancy;

# Each continent? Sort the results from shortest to longest.
SELECT
	Continent, 
	AVG(LifeExpectancy) AS life_expectancy
FROM country
GROUP BY Continent
ORDER BY life_expectancy;

# BONUS

# 1
# Find all the countries whose local name is different from the official name.
SELECT Name, LocalName
FROM country
WHERE Name != LocalName;

# 2
# How many countries have a life expectancy less than x?
SET @x = 40;

SELECT
	COUNT(*) AS Number_Of_Countries_With_Life_Expectancy_Less_Than_X,
	@x AS X
FROM country
WHERE LifeExpectancy < @x;

# 3
# What state is city x located in?
SET @x = 'Miami';

SELECT
	District AS State,
	@x AS X
FROM city
WHERE Name = @x;

# 4
# What region of the world is city x located in?
SET @x = 'San Antonio';

SELECT
	country.Region,
	@x AS X
FROM country
JOIN city
	ON country.Code = city.CountryCode
WHERE city.Name = @x;

# 5
# What country (use the human readable name) city x located in?
SET @x = 'San Antonio';

SELECT
	country.Name,
	@x AS X
FROM country
JOIN city
	ON country.Code = city.CountryCode
WHERE city.Name = @x;

# 6
# What is the life expectancy in city x?
SELECT
	dept_emp.dept_no,
	MAX(salaries.salary) AS salary
FROM salaries
JOIN dept_emp USING(emp_no)
WHERE salaries.to_date > CURDATE()
GROUP BY dept_emp.dept_no;