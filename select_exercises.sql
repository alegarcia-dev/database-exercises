# 2.
USE albums_db;
DESCRIBE albums;
SELECT * FROM albums;

# 3a
# Count the total number of rows in albums: 31 rows
# We could also look at the total number of rows under the content tab in Sequel Ace
SELECT COUNT(*) FROM albums;

# 3b
# Count the number of distinct artist names in albums: 23 rows
# We could also observe the number of rows returned without the COUNT function
SELECT COUNT(DISTINCT artist) FROM albums;

# 3c
# The primary key is id

# 3d
# Get the oldest release date: 1967
# We could also view contents and order by release_date to get both minimum and maximum
SELECT MIN(release_date) FROM albums;

# Get the latest release date: 2011
SELECT MAX(release_date) FROM albums;

# 4a
# Get albums by Pink Floyd
SELECT artist, name FROM albums WHERE artist = 'Pink Floyd';

# 4b
# Get release date for Sgt. Pepper's Lonely Hearts Club Band
SELECT name, release_date FROM albums WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

# 4c
# Get genre for the album Nevermind
SELECT name, genre FROM albums WHERE name = 'Nevermind';

# 4d
# Get albums released in the 1990s
SELECT name, release_date FROM albums WHERE release_date BETWEEN 1990 AND 1999;

# 4e
# Get albums with less than 20 million sales
SELECT name, sales FROM albums WHERE sales < 20;

# 4f
# Get albums in the "Rock" genre
SELECT name, genre FROM albums WHERE genre = 'Rock';
# This query will not include genres like 'Hard rock' or 'Progressive rock' because SQL is checking for an exact match of 'Rock'