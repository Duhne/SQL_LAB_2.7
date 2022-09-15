-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT fc.category_id, sum(f.film_id) FROM sakila.film f
JOIN sakila.film_category fc
ON f.film_id = fc.film_id
GROUP BY category_id
ORDER BY fc.category_id ASC;

-- 2. Display the total amount rung up by each staff member in August of 2005.
SELECT staff_id, sum(amount) FROM sakila.payment
WHERE payment_date BETWEEN '2005-08-01 00:00:00' AND '2005-09-01 00:00:00'
Group by staff_id
order by staff_id ASC;

-- 3. Which actor has appeared in the most films?
SELECT a.actor_id, first_name, last_name, count(film_id) AS 'number_movies' FROM sakila.film_actor fa
JOIN sakila.actor a
ON a.actor_id = fa.actor_id
Group by actor_id
order by count(film_id) ASC;

-- 4. Most active customer (the customer that has rented the most number of films)
SELECT * FROM sakila.customer; -- customer_id, f&l_name
SELECT * FROM sakila.rental; -- customer_id, rental_id

SELECT Count(r.rental_id) AS 'number_movies', r.customer_id, c.first_name, c.last_name
FROM sakila.customer c
JOIN sakila.rental r USING (customer_id)
GROUP BY r.customer_id
ORDER BY count(r.rental_id) DESC
LIMIT 1;

-- 5. Display the first and last names, as well as the address, of each staff member.
SELECT * FROM sakila.staff; -- f&l_name, adress_id
SELECT * FROM sakila.address; -- adress_id, address, district, postal_code

SELECT s.staff_id, s.first_name, s.last_name, a.address_id, a.address, a.district, a.postal_code
FROM sakila.staff s
JOIN sakila.address a USING (address_id)
GROUP BY s.staff_id;

-- 6. List each film and the number of actors who are listed for that film.
SELECT * FROM sakila.film; -- film_id, title
SELECT * FROM sakila.film_actor ORDER BY film_id; -- actor_id, film_id

SELECT f.film_id, f.title, count(fa.actor_id) AS '#_of_actors'
FROM sakila.film f
JOIN sakila.film_actor fa USING (film_id)
GROUP BY f.film_id
ORDER BY f.film_id;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name.
SELECT * FROM sakila.payment; -- customer_id, amount
SELECT * FROM sakila.customer; -- customer_id, f&l_name

SELECT c.customer_id, c.first_name, c.last_name, sum(p.amount) 
FROM sakila.customer c
JOIN sakila.payment p USING (customer_id)
GROUP BY c.customer_id;

-- 8. List number of films per category.
SELECT * FROM sakila.film_category; -- category_id, film_id
SELECT * FROM sakila.category; -- category_id, name

SELECT category_id, c.name, COUNT(distinct film_id) AS '#_of_films' FROM sakila.film_category fc
JOIN sakila.category c USING (category_id)
group by category_id;