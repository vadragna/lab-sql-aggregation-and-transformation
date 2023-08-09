USE sakila;

-- Challenge 1

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 1;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: look for floor and round functions.
SELECT SEC_TO_TIME(ROUND(AVG(LENGTH))*60)
FROM film;

-- 2.1 Calculate the number of days that the company has been operating. Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT DATEDIFF(max(rental_date), min(rental_date))
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, MONTH(rental_date) as month, DAYNAME(rental_date) as weekday
FROM rental
LIMIT 20;

-- 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. Hint: use a conditional expression
SELECT *, MONTH(rental_date) as month, DAYNAME(rental_date) as weekday,
    CASE
        WHEN DAYNAME(rental_date) = 'Saturday' OR DAYNAME(rental_date) = 'Sunday' THEN 'Weekend'
        ELSE 'Workday'
    END AS day_type
    FROM rental;
    
-- 3
-- Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results by the film title in ascending order.
SELECT title, COALESCE(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY Title asc;

-- 4
-- We want to retrieve the concatenated first and last names of our customers, along with the first 3 characters of their email address
SELECT concat(first_name, last_name, left(email, 3))
FROM customer;

-- Challenge 2 
-- 1.1 Using the film table, determine: The total number of films that have been released.
SELECT COUNT(release_year)
FROM film;

-- 1.2 The number of films for each rating.
SELECT COUNT(film_id) as n_of_film_per_rating, rating
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, and sort the results in descending order of the number of films. This will help us better understand the popularity of different film ratings and adjust our purchasing decisions accordingly.
SELECT COUNT(film_id) as n_of_film_per_rating, rating
FROM film
GROUP BY rating
ORDER BY rating desc;

-- 2
-- Using the rental table, determine the number of rentals processed by each employee. 
SELECT staff_id, COUNT(rental_id) AS n_of_rentals_per_employee
FROM rental
GROUP BY staff_id;

-- 3
-- 3.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places
SELECT rating, SEC_TO_TIME(ROUND(AVG(length), 2)*60) as avg_duration_per_rating
FROM film
GROUP BY rating
ORDER BY rating desc;

-- 3.2 Identify which ratings have a mean duration of over two hours
SELECT rating, SEC_TO_TIME(ROUND(AVG(length), 2)*60) as avg_duration_per_rating
FROM film
GROUP BY rating
HAVING avg_duration_per_rating > TIME('02:00:00')
ORDER BY rating desc;

-- 4 Determine which last names are not repeated in the table actor.
SELECT COUNT(last_name), last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name)= 1;

