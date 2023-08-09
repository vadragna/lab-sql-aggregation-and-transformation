USE sakila;

-- Challenge 1

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 1;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: look for floor and round functions.