USE albums_db;
DESCRIBE albums;
SELECT * FROM albums;

# Count the total number of rows in albums: 31 rows
# We could also look at the total number of rows under the content tab in Sequel Ace
SELECT COUNT(*) FROM albums;

# Count the number of distinct artist names in albums: 23 rows
# We could also observe the number of rows returned without the COUNT function
SELECT COUNT(DISTINCT artist) FROM albums;

# The primary key is id

# Get the oldest release date: 1967
# We could also view contents and order by release_date to get both minimum and maximum
SELECT MIN(release_date) FROM albums;

# Get the latest release date: 2011
SELECT MAX(release_date) FROM albums;

# Get albums by Pink Floyd
SELECT artist, name FROM albums WHERE artist = 'Pink Floyd';

# Get release date for Sgt. Pepper's Lonely Hearts Club Band
SELECT name, release_date FROM albums WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

# Get genre for the album Nevermind
SELECT name, genre FROM albums WHERE name = 'Nevermind';

# Get albums released in the 1990s
SELECT name, release_date FROM albums WHERE release_date BETWEEN 1990 AND 1999;

# Get albums with less than 20 million sales
SELECT name, sales FROM albums WHERE sales < 20;

# Get albums in the "Rock" genre
SELECT name, genre FROM albums WHERE genre = 'Rock';
# This query will not include genres like 'Hard rock' or 'Progressive rock' because SQL is checking for an exact match of 'Rock'