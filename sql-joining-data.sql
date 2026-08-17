-- Exercise 1: Basic Left Join
SELECT name, region, gdp_percapita
FROM countries AS c
LEFT JOIN economies AS e
-- Match on code fields
ON c.code = e.code
-- Filter for the year 2010
WHERE year = 2010;

-- Exercise 2: Average GDP by Region
-- Select region, and average gdp_percapita as avg_gdp
SELECT region, AVG(gdp_percapita) AS avg_gdp
FROM countries AS c
LEFT JOIN economies AS e
USING(code)
WHERE year = 2010
-- Group by region
GROUP BY region;

-- Exercise 3: Top 10 Regions by Average GDP (2010)
SELECT region, AVG(gdp_percapita) AS avg_gdp
FROM countries AS c
LEFT JOIN economies AS e
USING(code)
WHERE year = 2010
GROUP BY region
-- Order by descending avg_gdp
ORDER BY AVG(gdp_percapita) DESC 
-- Return only first 10 records
LIMIT 10

-- Exercise 4: use of right join
-- Modify the query to use RIGHT JOIN instead of LEFT JOIN
SELECT countries.name AS country, languages.name AS language, percent
FROM languages
RIGHT JOIN countries
USING(code)
ORDER BY language;

-- Exercise 5: Full Join
SELECT name AS country, code, region, basic_unit
FROM countries
-- Join to currencies
FULL JOIN currencies
USING (code)
-- Where region is North America or null
WHERE region = 'North America'
	OR name IS NULL
ORDER BY region;

-- Exercise 6: Full Join
SELECT name AS country, code, region, basic_unit
FROM countries
-- Join to currencies
LEFT JOIN currencies
USING (code)
WHERE region = 'North America' 
	OR name IS NULL
ORDER BY region;

-- Exercise 7: Full Join
SELECT name AS country, code, region, basic_unit
FROM countries
-- Join to currencies
INNER JOIN currencies 
USING (code)
WHERE region = 'North America' 
	OR name IS NULL
ORDER BY region;

-- Exercise 8: Full Join
SELECT 
	c1.name AS country, 
    region, 
    l.name AS language,
	basic_unit, 
    frac_unit
FROM countries as c1 
-- Full join with languages (alias as l)
FULL JOIN languages AS l
USING(code) 
-- Full join with currencies (alias as c2)
FULL JOIN currencies AS c2 
USING(code)
WHERE region LIKE 'M%esia';

-- Exercise 9: Cross Join
SELECT c.name AS country, l.name AS language
-- Inner join countries as c with languages as l on code
FROM countries AS c
INNER JOIN languages AS l
USING(code)
WHERE c.code IN ('PAK','IND')
	AND l.code in ('PAK','IND');

-- Exercise 10: Cross Join
SELECT c.name AS country, l.name AS language
FROM countries AS c        
-- Perform a cross join to languages (alias as l)
CROSS JOIN languages AS l
WHERE c.code in ('PAK','IND')
	AND l.code in ('PAK','IND');

--Exercise 11: Lowest Life Expectancy in 2010
SELECT 
	c.name AS country,
    region,
    life_expectancy AS life_exp
FROM countries AS c
-- Join to populations (alias as p) using an appropriate join
INNER JOIN populations AS p 
ON c.code = p.country_code
-- Filter for only results in the year 2010
WHERE year= 2010
-- Sort by life_exp
ORDER BY life_exp
-- Limit to five records
LIMIT 5;

--Exercise 12: Self Join on Populations Table
-- Select aliased fields from populations as p1
SELECT 
    p1.country_code, 
    p1.size AS size2010,
    p2.size AS size2015
FROM populations AS p1 
-- Join populations as p1 to itself, alias as p2, on country code
INNER JOIN populations AS p2
ON p1.country_code = p2.country_code;

-- Exercise 13: Comparing Population Growth Over 5 Years
SELECT 
	p1.country_code, 
    p1.size AS size2010, 
    p2.size AS size2015
FROM populations AS p1
INNER JOIN populations AS p2
ON p1.country_code = p2.country_code
WHERE p1.year = 2010
-- Filter such that p1.year is always five years before p2.year
    AND p1.year = p2.year -5;
