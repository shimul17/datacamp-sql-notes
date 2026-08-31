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

-- Exercise 14: uses of union
-- Select all fields from economies2015
SELECT *
FROM economies2015    
-- Set operation
UNION
-- Select all fields from economies2019
SELECT *
FROM economies2019
ORDER BY code, year;

--Exercise 15: uses of Intersect
SELECT name 
FROM cities
INTERSECT
SELECT name
FROM countries;

-- Exercise 16: Uses of Except
-- Return all cities that do not have the same name as a country
SELECT name
FROM cities
EXCEPT
SELECT name
FROM countries
ORDER BY name;

-- Exercise 17: Subquery inside WHERE part 1 (Semi Join)
SELECT DISTINCT name
FROM languages
-- Add syntax to use bracketed subquery below as a filter
WHERE code IN
    (SELECT code
    FROM countries
    WHERE region = 'Middle East')
ORDER BY name;

-- Exercise 18: Subquery inside WHERE part 2 (Anti Join)
SELECT code, name
FROM countries
WHERE continent = 'Oceania'
-- Filter for countries not included in the bracketed subquery
  AND code NOT IN
    (SELECT code
    FROM currencies);

-- Exercise 19: Subquery inside WHERE part 3
SELECT *
FROM populations
WHERE year = 2015
-- Filter for only those populations where life expectancy is 1.15 times higher than average
  AND life_expectancy >  1.15 *
  (SELECT AVG(life_expectancy)
   FROM populations
   WHERE year = 2015);

-- Exercise 20: Subquery inside SELECT part 1
SELECT countries.name AS country, COUNT(*) AS cities_num
FROM countries
LEFT JOIN cities
ON countries.code = cities.country_code 
-- Order by count of cities as cities_num
GROUP BY country
ORDER BY cities_num DESC, country ASC
-- Limit the results
LIMIT 9;

-- Exercise 21: Subquery inside SELECT part 2
SELECT countries.name AS country,
-- Subquery that provides the count of cities   
  (SELECT COUNT(*)
  FROM cities
  WHERE cities.country_code = countries.code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;

-- Exercise 22: Subquery inside FROM
-- Select local_name and lang_num from appropriate tables
SELECT local_name, sub.lang_num
FROM countries,
  (SELECT code, COUNT(*) AS lang_num
  FROM languages
  GROUP BY code) AS sub
-- Where codes match
WHERE countries.code = sub.code
ORDER BY lang_num DESC;

-- Exercise 23: Subquery challenge 
-- Select relevant fields
SELECT code, inflation_rate, unemployment_rate
FROM economies
WHERE year = 2015 
  AND code IN
-- Subquery returning country codes filtered on gov_form
    (SELECT code
    FROM countries
    WHERE gov_form LIKE '%Republic%' OR gov_form LIKE '%Monarchy%')
ORDER BY inflation_rate;

-- Exercise 24: Final challenge
-- Select fields from cities
SELECT name, country_code,city_proper_pop, metroarea_pop, city_proper_pop / metroarea_pop * 100 AS city_perc 
FROM cities
WHERE name IN
-- Use subquery to filter city name
    (SELECT capital
    FROM countries
    WHERE continent LIKE '%Europe%' OR continent LIKE '%America%')
-- Add filter condition such that metroarea_pop does not have null values
AND metroarea_pop IS NOT NULL 
ORDER BY city_perc DESC
-- Sort and limit the result
LIMIT 10;




