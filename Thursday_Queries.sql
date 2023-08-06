--1.List all customers who live in Texas (use JOINs)
-- Output: 5 
SELECT first_name, last_name, postal_code, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
-- WHERE postal_code BETWEEN '73301' AND '88595';
WHERE district = 'Texas';

--2. Get all payments above $6.99 with the Customer's Full Name
-- Output: 1406 payments
SELECT first_name, last_name, amount
FROM customer
INNER JOIN payment 
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY amount;

--3. Show all customers names who have made payments over $175
-- Output: 6 customers
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);

--4. List all customers that live in Nepal
--Output: 1 customer
SELECT first_name, last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

-- 5. Which staff member had the most transactions?
-- Output: Jon Stephens with 7304 transactions
SELECT first_name, last_name, COUNT(payment_id)
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY first_name, last_name
ORDER BY COUNT(payment_id) DESC
LIMIT 1;

--6.SELECT rating, COUNT(title)
--Output: G: 178, PG: 194, PG-13: 223, R: 195, NC-17:210
SELECT rating, COUNT(title)
FROM film
GROUP BY rating
ORDER BY rating;

-- 7. Show all customers who have made a single payment above $6.99 (Use Subqueries)
-- Output: 130 customers made a single payment over $6.99
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
	GROUP BY customer_id
	HAVING COUNT(customer_id) = 1
);

-- 8. How many free rentals did our stores give away?
-- Output: 24 free rentals
SELECT COUNT(rental.rental_id) AS free_rentals
FROM rental
INNER JOIN payment
ON rental.rental_id = payment.rental_id
WHERE payment.amount = 0;
