# Lab | SQL Queries 8
use sakila;

# 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

select title,length, dense_rank() over (order by length desc) as 'rank'
from film
where length >0;

# 2.Rank films by length within the rating category (filter out the rows with nulls or zeros in length column).
# In your output, only select the columns title, length, rating and rank.

select title,length,rating, dense_rank() over (partition by rating order by length desc) as 'rank' from film where length > 0;

# 3.How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
select cat.category_id ,cat.name, count(*) as total_films 
from category as cat
join film_category as f_cat
on cat.category_id = f_cat.category_id
group by category_id;

# 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select act.actor_id,act.first_name,act.last_name,count(*) as total_films
from actor as act
join film_actor as f_act
on act.actor_id = f_act.actor_id
group by act.actor_id,act.first_name,act.last_name
order by total_films desc limit 1;

# 5.Which is the most active customer (the customer that has rented the most number of films)?
# Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select c.customer_id,c.first_name,c.last_name,count(*) as total_rental
from customer as c
join rental as r
on c.customer_id=r.customer_id
group by c.customer_id
order by total_rental desc limit 1;

# Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
# Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.

select fil.film_id, fil.title, count(*) as total_rentals
from film as fil
inner join inventory as inv on fil.film_id = inv.film_id
inner join rental as rent on inv.inventory_id = rent.inventory_id
group by fil.film_id
order by total_rentals desc limit 1;

