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
SET @x = 'San Antonio';

SELECT
	country.LifeExpectancy,
	@x As X
FROM country
JOIN city
	ON country.Code = city.CountryCode
WHERE city.Name = @x;

# Sakila Database

USE Sakila;

# First group of exercises

# 1a
# Select all columns from the actor table.
SELECT * FROM actor;

# 1b
# Select only the last_name column from the actor table.
SELECT last_name FROM actor;

# 1c
# Select only the film_id, title, and release_year columns from the film table.
SELECT film_id, title, release_year FROM film;

# 2a
# Select all distinct (different) last names from the actor table.
SELECT DISTINCT last_name FROM actor;

# 2b
# Select all distinct (different) postal codes from the address table.
SELECT DISTINCT postal_code FROM address;

# 2c
# Select all distinct (different) ratings from the film table.
SELECT DISTINCT rating FROM film;

# 3a
# Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
SELECT title, description, rating, length
FROM film
WHERE length >= (3 * 60);

# 3b
# Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >= '2005-05-27';

# 3c
# Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date LIKE '2005-05-27%';

# 3d
# Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
SELECT * FROM customer 
WHERE first_name LIKE '%n'
	AND last_name LIKE 'S%';

# 3e
# Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
SELECT * FROM customer 
WHERE NOT active
	OR last_name LIKE 'M%';

# 3f
# Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
SELECT * FROM category
WHERE category_id > 4
	AND name REGEXP '^[C|S|T].*';

# 3g
# Select all columns minus the password column from the staff table for rows that contain a password.
# Solution found here:
# https://stackoverflow.com/questions/2365972/how-can-i-select-from-a-table-in-mysql-but-omit-certain-columns/13808457#13808457
SET @sql = 
	CONCAT('SELECT ',
			(SELECT GROUP_CONCAT(COLUMN_NAME)
			FROM information_schema.columns
			WHERE table_schema = 'sakila'
				AND table_name = 'staff' 
				AND column_name NOT IN ('password')),
			' FROM staff WHERE password IS NOT NULL');  
PREPARE stmt1 FROM @sql;
EXECUTE stmt1;

# 3h
# Select all columns minus the password column from the staff table for rows that do not contain a password.
# I must be overthinking this solution, or are we actually supposed to type out each column name?
SET @sql = 
	CONCAT('SELECT ',
			(SELECT GROUP_CONCAT(COLUMN_NAME)
			FROM information_schema.columns
			WHERE table_schema = 'sakila'
				AND table_name = 'staff' 
				AND column_name NOT IN ('password')),
			' FROM staff WHERE password IS NULL');  
PREPARE stmt1 FROM @sql;
EXECUTE stmt1;

# 4a
# Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
SELECT phone, district
FROM address
WHERE district IN ('California', 'England', 'Taipei', 'West Java');

# 4b
# Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, 
# and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
SELECT payment_id, amount, payment_date
FROM payment
WHERE DATE(payment_date) IN ('2005-05-25', '2005-05-27', '2005-05-29');

# 4c
# Select all columns from the film table for films rated G, PG-13 or NC-17.
SELECT * FROM film
WHERE rating IN ('G', 'PG-13', 'NC-17');

# 5a
# Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
SELECT * FROM payment
WHERE payment_date BETWEEN '2005-05-25 00:00:00' AND '2005-05-25 23:59:59';

# 5b
# Select the film_id, title, and description columns from the film table for films where the length of the description is between 100 and 120.
SELECT film_id, title, description
FROM film
WHERE length BETWEEN 100 AND 120;

# 6a
# Select all columns from the film table for rows where the description begins with "A Thoughtful".
SELECT * FROM film
WHERE description LIKE 'A Thoughtful%';

# 6b
# Select all columns from the film table for rows where the description ends with the word "Boat".
SELECT * FROM film
WHERE description LIKE '%Boat';

# 6c
# Select all columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
SELECT * FROM film
WHERE description LIKE '%Database%'
	AND length > (3 * 60);

# 7a
# Select all columns from the payment table and only include the first 20 rows.
SELECT * FROM payment LIMIT 20;

# 7b
# Select the payment date and amount columns from the payment table for rows where the payment amount 
# is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
SELECT payment_date, amount
FROM payment
WHERE amount > 5
LIMIT 1001 OFFSET 1000;

# 7c
# Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.
SELECT * FROM customer LIMIT 100 OFFSET 101;

# 8a
# Select all columns from the film table and order rows by the length field in ascending order.
SELECT * FROM film ORDER BY length;

# 8b
# Select all distinct ratings from the film table ordered by rating in descending order.
SELECT DISTINCT rating FROM film ORDER BY rating DESC;

# 8c
# Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
SELECT payment_date, amount
FROM payment
ORDER BY amount DESC
LIMIT 20;

# 8d
# Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with 
# behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
SELECT
	title,
	description,
	special_features,
	length,
	rental_duration
FROM film
WHERE special_features LIKE '%Behind the Scenes'
	AND length < (2 * 60)
	AND rental_duration BETWEEN 5 AND 7
ORDER BY length DESC
LIMIT 10;

# 9a
# Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer 
# and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name).
SELECT
	customer.first_name AS customer_first_name,
	customer.last_name AS customer_last_name,
	actor.first_name AS actor_first_name,
	actor.last_name AS actor_last_name
FROM customer
LEFT JOIN actor USING (last_name);

# 9b
# Select the customer first_name/last_name and actor first_name/last_name columns from performing a /right join between the 
# customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name).
SELECT
	customer.first_name AS customer_first_name,
	customer.last_name AS customer_last_name,
	actor.first_name AS actor_first_name,
	actor.last_name AS actor_last_name
FROM customer
RIGHT JOIN actor USING (last_name);

# 9c
# Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the 
# customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name).
SELECT
	customer.first_name AS customer_first_name,
	customer.last_name AS customer_last_name,
	actor.first_name AS actor_first_name,
	actor.last_name AS actor_last_name
FROM customer
JOIN actor USING (last_name);

# 9d
# Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
SELECT
	city.city,
	country.country
FROM city
LEFT JOIN country USING (country_id);

# 9e
# Select the title, description, release year, and language name columns from the film table, performing a left join with the 
# language table to get the "language" column.
SELECT
	film.title,
	film.description,
	film.release_year,
	language.name AS language
FROM film
LEFT JOIN language USING (language_id);

# 9f
# Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 
# 2 left joins with the address table then the city table to get the address and city related columns.
SELECT
	staff.first_name,
	staff.last_name,
	address.address,
	address.address2,
	address.district,
	address.postal_code,
	city.city
FROM staff
LEFT JOIN address USING (address_id)
LEFT JOIN city USING (city_id);