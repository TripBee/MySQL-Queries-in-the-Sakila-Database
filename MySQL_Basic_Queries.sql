-- 1A
USE sakila;
SELECT last_name 
FROM actor; 

-- 1B  
SELECT UPPER(CONCAT(first_name, " ", last_name)) AS uppercase_names
FROM actor;


-- 2A
SELECT actor_id, first_name, last_name 
FROM actor
WHERE first_name = 'JOE';

-- 2B
SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';

-- 2C
SELECT * 
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name ASC;

-- 2D
SELECT country_id, country
FROM country 
WHERE country.country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a 
ALTER TABLE actor
ADD COLUMN description BLOB;

-- 3b 
ALTER TABLE actor
DROP COLUMN description;

-- 4a I'm not sure how to solve this one
SELECT  last_name, COUNT(last_name)
FROM actor
GROUP BY last_name;

-- 4b
SELECT CONCAT(first_name, ' ', last_name)
FROM actor 
WHERE first_name = "HARPO";

-- 4c
SET SQL_SAFE_UPDATES = 0;
  UPDATE actor 
  SET first_name = 'HARPO'
  WHERE first_name ="GROUCHO" AND last_name = "WILLIAMS";
SET SQL_SAFE_UPDATES = 1;

-- 4d
SET SQL_SAFE_UPDATES = 0;
  UPDATE actor 
  SET first_name = 'GROUCHO'
  WHERE first_name ="HARPO" AND last_name = "WILLIAMS";
SET SQL_SAFE_UPDATES = 1;

-- 5a
DESC address;

-- 6a
SELECT staff.first_name, staff.last_name, address.address
FROM address 
INNER JOIN staff
ON address.address_id = staff.address_id;

-- 6b wow this one took a while to figure out what order in which to put the words
SELECT staff.first_name, staff.last_name, 
   SUM(payment.amount) AS total_amount 
FROM  staff 
JOIN payment 
ON staff.staff_id = payment.staff_id
WHERE (payment.payment_date >= '2005-08-01 12:00:00' AND 
			      payment.payment_date < '2005-09-01 12:00:00') 
GROUP BY staff.last_name, staff.first_name; 

-- 6c
SELECT film.title, COUNT(CONCAT(actor.first_name, ' ', actor.last_name)) AS number_of_actors
FROM film 
INNER JOIN film_actor ON film.film_id = film_actor.film_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY film.title;



-- 6d
SELECT film.title, COUNT(inventory.inventory_id)
FROM film 
INNER JOIN inventory ON film.film_id = inventory.film_id
WHERE film.title = "Hunchback Impossible"
GROUP BY film.title;

-- 6e
SELECT customer.first_name, customer.last_name, 
   SUM(payment.amount) AS total_amount 
FROM  customer 
JOIN payment 
ON customer.customer_id = payment.customer_id
GROUP BY customer.last_name, customer.first_name
ORDER BY  customer.last_name, customer.first_name; 

-- 7a
SELECT title 
FROM film
WHERE title LIKE "K%" OR title LIKE "Q%";

-- 7b
SELECT first_name, last_name 
FROM actor 
WHERE actor_id IN (SELECT actor_id 
								FROM film_actor 
                                WHERE film_id = (SELECT film_id 
															 FROM film 
                                                             WHERE title = "Alone Trip"));

-- 7c
SELECT C.first_name, C.last_name, address.address;
SELECT C.first_name, C.last_name, C.email, CI.city, CO.country
FROM customer C
INNER JOIN address A on C.address_id = A.address_id
inner join city CI on A.city_id = CI.city_id
inner join country CO on CI.country_id = CO.country_id
WHERE CO.country = "Canada";

-- 7d
 SELECT title
 FROM film 
 WHERE rating = "G"
 LIMIT 10;

-- 7e
USE sakila;
SELECT F.title, COUNT(R.rental_id)
FROM film F
INNER JOIN inventory I ON F.film_id = I.film_id 
INNER JOIN rental R ON I.inventory_id = R.inventory_id
GROUP BY F.title DESC;

-- 7f
SELECT S.store_id, SUM(p.amount)
FROM payment P
JOIN customer C ON P.customer_id = C.customer_id
JOIN store S ON S.store_id = C.store_id
GROUP BY S.store_id;

-- 7g
SELECT S.store_id, C.city, CO.country
FROM store S
JOIN address A ON S.address_id = A.address_id
JOIN city C on A.city_id = C.city_id
JOIN country CO on C.country_id = CO.country_id;

-- 7h
SELECT C.name, SUM(P.amount)
FROM category C 
JOIN film_category FC ON C.category_id = FC.category_id
JOIN inventory I ON FC.film_id = I.film_id
JOIN rental R ON I.inventory_id = R.inventory_id
JOIN payment P ON R.rental_id = P.rental_id 
GROUP BY C.name
ORDER BY SUM(P.amount) DESC
LIMIT 5;

-- 8a
CREATE VIEW TOP5 AS SELECT C.name,
SUM(P.amount)
FROM category C JOIN film_category FC ON C.category_id = FC.category_id
JOIN inventory I ON FC.film_id = I.film_id
JOIN rental R ON I.inventory_id = R.inventory_id
JOIN payment P ON R.rental_id = P.rental_id 
GROUP BY C.name
ORDER BY SUM(amount) DESC
LIMIT 5;

-- 8b
SELECT *
FROM TOP5;

-- 8c
DROP VIEW TOP5;







WHERE (payment.payment_date >= '2005-08-01 12:00:00' AND 
			      payment.payment_date < '2005-09-01 12:00:00') 
ORDER BY payment_date DESC


LIMIT 50;









