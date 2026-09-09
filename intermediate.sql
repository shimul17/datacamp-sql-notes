-- 1:	Count the total number of records in the people table, aliasing the result as count_records.
	-- Count the number of records in the people table
	SELECT COUNT(*) AS count_records
	FROM people;

-- 2: Count the number of records with a birthdate in the people table, aliasing the result as count_birthdate.
	SELECT COUNT(birthdate) AS count_birthdate
	FROM people;

-- 3: Count the records for languages and countries in the films table; alias as count_languages and count_countries.
	SELECT COUNT(language) AS count_languages, COUNT(country) AS count_countries
	FROM films;

-- 4 :	Return the unique countries from the films table
--	Select Distinct(country) from films
-- Count the distinct countries from the films table
	Select Count(distinct country) as count_distinct_countries
	from films;

-- 5:	Select film_id and imdb_score with an imdb_score over 7.0
	SELECT film_id, imdb_score
	FROM reviews
	WHERE imdb_score > 7.0;

-- 6: Select film_id and facebook_likes for ten records with less than 1000 likes 
	SELECT film_id, facebook_likes
	FROM reviews
	WHERE facebook_likes < 1000
	LIMIT 10;

-- 7: Count the records with at least 100,000 votes
	Select count(*) As films_over_100K_votes
	From reviews
	Where num_votes >= 100000;

-- 8: Count the Spanish-language films
	Select count(language) As count_spanish
	From films
	Where language = 'Spanish';

-- 9: Update the query to see all German-language films released after 2000
	SELECT title, release_year
	FROM films
	WHERE release_year > 2000
	    AND language = 'German';

-- 10: Select all records for German-language films released after 2000 and before 2010
	Select *
	from films
	where release_year > 2000
	    and release_year < 2010
	    and language = 'German';

-- 11: Find the title and year of films from the 1990 or 1999
	select title, release_year
	from films
	where release_year = 1990 
	    or release_year = 1999;

-- 12:	SELECT title, release_year
	FROM films
	WHERE (release_year = 1990 OR release_year = 1999)
	-- Add a filter to see only English or Spanish-language films
	    AND (language = 'English' OR language = 'Spanish')
	-- Filter films with more than $2,000,000 gross
	    AND gross >= 2000000;

-- 13: Select the title and release_year for films released between 1990 and 2000
Select title, release_year
From films
Where release_year between 1990 and 2000
--  Narrow down your query to films with budgets > $100 million
    AND budget > 100000000
-- Amend the query to include Spanish or French-language films
    AND (language = 'Spanish' or language = 'French');

-- 14: The LIKE and NOT LIKE operators can be used to find records that either match or do not match a specified pattern, respectively. They can be coupled with the wildcards % and _. The % will match zero or many characters, and _ will match a single character.
-- Select the names that start with B
Select name
From people
Where name like 'B%';

-- 15: Select the names that have r as the second letter
Select name
From people
Where name like '_r%';

-- Select names that don't start with A
Select name
From people
Where name not like 'A%';

-- 16: Find the title and release_year for all films over two hours in length released in 1990 and 2000
Select title, release_year
From films
Where release_year in(1990, 2000)
And duration > 120;

-- 17: Find the title and language of all films in English, Spanish, and French
Select title, language
from films
where language in('English', 'Spanish', 'French');

-- 18: Find the title, certification, and language all films certified NC-17 or R that are in English, Italian, or Greek
Select title, certification, language
From films
Where certification in ('NC-17', 'R')
And language in ('English', 'Italian', 'Greek');

-- 19: Time for a little challenge. So far, your SQL vocabulary from this course includes COUNT(), DISTINCT, LIMIT, WHERE, OR, AND, BETWEEN, LIKE, NOT LIKE, and IN. In this exercise, you will try to use some of these together. Writing more complex queries will be standard for you as you become a qualified SQL programmer.
-- Count the unique titles
SELECT Count(Distinct title) AS nineties_english_films_for_teens
FROM films
-- Filter to release_years to between 1990 and 1999
WHERE release_year Between 1990 And 1999
-- Filter to English-language films
And language = 'English'
-- Narrow it down to G, PG, and PG-13 certifications
And certification in ('G', 'PG', 'PG-13');
NULL means missing values;

-- 20: List all film titles with missing budgets
Select title As no_budget_info
From films
Where budget is Null; 


--	NULL Values: In SQL, NULL signifies a missing or unknown value, common in real-world databases due to human error or unavailable information.
--	Filtering with IS NULL: To identify records with NULL values, you can use the IS NULL operator within a WHERE clause. This is useful for understanding the extent of missing data in your dataset.
--	Excluding NULL Values: Conversely, to focus on records with known values, the IS NOT NULL operator filters out any rows containing NULL values in the specified field.
--	Counting Non-Missing Values: Using COUNT with a field name and adding a WHERE clause with IS NOT NULL effectively counts records without missing values. Both methods yield the same result but from different perspectives.
-- For example, to count all people in a database whose birth dates are not missing, you would use:

-- 21: 
SELECT COUNT(*) 
FROM people
WHERE birthdate IS NOT NULL;

-- Summarizing data:
-- Aggregate functions: AVG(), SUM(), MAX(), MIN(), COUNT()
-- Non-numerical data: NUMERICAL- AVG(), SUM(). VARIOUS DATA- MAX(), MIN(), COUNT()

-- 22: Query the sum of film durations
SELECT SUM(duration) AS total_duration
FROM films;

-- 23: Calculate the average duration of all films
SELECT AVG(duration) AS average_duration
FROM films;

-- 24: Use the MAX() function to find the latest release_year
SELECT MAX(release_year) AS latest_year
FROM films;

-- 25: Find the duration of the shortest film
SELECT MIN(duration) AS shortest_film
FROM films;

-- 26: Calculate the sum of gross from the year 2000 or later
SELECT SUM(gross) AS total_gross
FROM films
WHERE release_year >= 2000 ;

-- 27: Calculate the lowest gross film in 1994
SELECT MIN(gross) AS lowest_gross
FROM films
WHERE release_year = 1994; 

-- 28: Calculate the highest gross film released between 2000-2012
SELECT MAX(gross) AS highest_gross
FROM films
WHERE release_year BETWEEN 2000 AND 2012; 

-- 29: Round the average number of facebook_likes to one decimal place
SELECT ROUND(AVG(facebook_likes), 1) AS avg_facebook_likes
FROM reviews;

-- 30: Calculate the average budget rounded to the thousands
SELECT ROUND(AVG(budget), -3) AS avg_budget_thousands
FROM films;

-- 31: Calculate the title and duration_hours from films
SELECT title, duration / 60.0  AS duration_hours
FROM films;

-- 32: Calculate the percentage of people who are no longer alive
SELECT COUNT(deathdate) * 100.0 / COUNT(*) AS percentage_dead
FROM people;

-- 33: Find the number of decades in the films table
SELECT (MAX(release_year) - MIN(release_year)) / 10.0 AS number_of_decades
FROM films;

-- 34: Round duration_hours to two decimal places
SELECT title, ROUND(duration / 60.0, 2) AS duration_hours
FROM films;


-- 35: 
SELECT title, budget
FROM films
WHERE budget IS NOT NULL
ORDER BY budget DESC, title ASC;

-- 36: Select the title and duration from longest to shortest film
SELECT title, duration
FROM films
ORDER BY duration DESC;


-- 37: Select the certification, release year, and title sorted by certification and release year
SELECT certification, release_year, title
FROM films
ORDER BY certification, release_year DESC; 

-- 38: 
SELECT certification, COUNT(title) AS title_count
FROM films
GROUP BY certification
ORDER BY title_count DESC;

-- 39: Find the release_year and film_count of each year
SELECT release_year, COUNT(*) AS film_count
FROM films
GROUP BY release_year;

-- 40: Find the release_year and average duration of films for each year
SELECT release_year, AVG(duration) AS avg_duration
FROM films
GROUP BY release_year;

-- 41: Find the release_year, country, and max_budget, then group and order by release_year and country
SELECT release_year, country, MAX(budget) AS max_budget
FROM films
GROUP BY release_year, country
ORDER BY release_year, country;

-- 42:
SELECT release_year, COUNT (DISTINCT language) AS language_diversity
FROM films
GROUP BY release_year
ORDER BY language_diversity DESC;

-- 43: 
SELECT release_year
FROM films
GROUP BY release_year
HAVING AVG(duration) > 120;

-- 44: Select the country and distinct count of certification as certification_count
SELECT country, COUNT(DISTINCT certification) AS certification_count
FROM films
-- Group by country
GROUP BY country
-- Filter results to countries with more than 10 different certifications
HAVING COUNT(DISTINCT certification) > 10;

-- 45: Select the country and average_budget from films
SELECT country, ROUND(AVG(budget), 2) AS average_budget
FROM films
-- Group by country
GROUP BY country
-- Filter to countries with an average_budget of more than one billion
HAVING AVG(budget) > 1000000000
-- Order by descending order of the aggregated budget
ORDER BY average_budget DESC;

-- 46: Select the release_year for films released after 1990 grouped by year
SELECT release_year
FROM films
WHERE release_year > 1990
GROUP BY release_year;

-- 47: Modify the query to also list the average budget and average gross
SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year;

-- 48:
SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year < 1990
GROUP BY release_year;

-- 49:
SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000
-- Order the results from highest to lowest average gross and limit to one
ORDER BY AVG(gross) DESC
LIMIT 1;

-- 50:
SELECT country, COUNT(DISTINCT certification) AS certification_count
FROM films
GROUP BY country
HAVING COUNT(DISTINCT certification) > 10;

--51: 
SELECT department, COUNT(*)
FROM employees
WHERE department IS NOT NULL
GROUP BY department
HAVING COUNT(*) > 5;
