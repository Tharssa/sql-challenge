USE sakila;

-- List all actors.
SELECT * FROM actor;

-- Find the surname of the actor with the forename 'John'.
SELECT last_name FROM actor WHERE first_name = 'John';

-- Find all actors with surname 'Neeson'.
SELECT first_name FROM actor WHERE last_name = 'Neeson';

-- Find all actors with ID numbers divisible by 10.
SELECT actor_id, first_name, last_name FROM actor WHERE (actor_id % 10) = 0;

-- What is the description of the movie with an ID of 100?
SELECT title, description FROM film WHERE film_id = 100;

-- Find every R-rated movie.
SELECT title, rating FROM film WHERE rating = 'R';

-- Find every non-R-rated movie.
SELECT title, rating FROM film WHERE rating != 'R';

-- Find the ten shortest movies.
SELECT title, length FROM film ORDER BY length LIMIT 10;

-- Find the movies with the longest runtime, without using LIMIT.
SELECT title, length FROM film WHERE film_id <11 ORDER BY length DESC;

-- Find all movies that have deleted scenes.
SELECT title, special_features FROM film WHERE special_features LIKE '%Deleted Scenes%';

-- Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(*) = 1 ORDER BY last_name DESC;

-- Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(*) > 1 ORDER BY COUNT(last_name) DESC;

-- Which actor has appeared in the most films?
SELECT actor_id, COUNT(*) AS Frequency FROM film_actor GROUP BY actor_id ORDER BY COUNT(*) DESC LIMIT 1;
SELECT actor_id, first_name, last_name FROM actor WHERE actor_id = 107;

-- When is 'Academy Dinosaur' due?
SELECT film_id FROM film WHERE title = "Academy Dinosaur";
SELECT inventory_id FROM inventory WHERE film_id = 1;
SELECT inventory_id, return_date FROM rental WHERE inventory_id BETWEEN 1 AND 8;

-- What is the average runtime of all films?
SELECT AVG(length) 'Average Runtime' FROM film;

-- List the average runtime for every film category.
SELECT  film.film_id,
        film_category.category_id,
        category.name,
        AVG(film.length)
    FROM film
        LEFT OUTER JOIN film_category
            ON film.film_id = film_category.film_id
		LEFT OUTER JOIN category
            ON film_category.category_id = category.category_id
    GROUP BY category.name;

-- List all movies featuring a robot.
SELECT title, description FROM film WHERE description LIKE '%robot%';

-- How many movies were released in 2010?
SELECT title, release_year FROM film WHERE release_year = 2010;

-- Find the titles of all the horror movies.
SELECT  film.title,
		category.name
	FROM film
        LEFT OUTER JOIN film_category
            ON film.film_id = film_category.film_id
		LEFT OUTER JOIN category
            ON film_category.category_id = category.category_id
            WHERE category.name = 'Horror';

-- List the full name of the staff member with the ID of 2.
SELECT first_name, last_name FROM staff WHERE staff_id = 2;

-- List all the movies that Fred Costner has appeared in.
SELECT  film.title,
		film.film_id,
        actor.actor_id,
        actor.first_name,
        actor.last_name
	FROM film
        LEFT OUTER JOIN film_actor
            ON film.film_id = film_actor.film_id
		LEFT OUTER JOIN actor
            ON film_actor.actor_id = actor.actor_id
          WHERE actor.last_name = 'Costner';

-- How many distinct countries are there?
SELECT DISTINCT country FROM country;

-- List the name of every language in reverse-alphabetical order.
SELECT name FROM language ORDER BY name;

-- List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%son';

-- Which category contains the most films?
SELECT  MAX(category.name)
	FROM film
        LEFT OUTER JOIN film_category
            ON film.film_id = film_category.film_id
		LEFT OUTER JOIN category
            ON film_category.category_id = category.category_id;
            