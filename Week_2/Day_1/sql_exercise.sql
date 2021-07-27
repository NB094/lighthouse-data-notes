/* SQL Exercise
====================================================================
We will be working with database imdb.db
You can download it here: https://drive.google.com/file/d/1E3KQDdGJs4a0i1RoYb8DEq0PFxCgI6cN/view?usp=sharing
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE


.tables
SELECT * FROM distributors;
SELECT * FROM movie_distributors;
SELECT * FROM movies ORDER BY year;
SELECT * FROM movie_genres;
SELECT * FROM genres;

--==================================================================
/* TASK I
 Find the id's of movies that have been distributed by “Universal Pictures”.
*/
SELECT movie_distributors.movie_id, distributors.name FROM movie_distributors
  JOIN distributors ON movie_distributors.distributor_id = distributors.distributor_id
  WHERE distributors.name = 'Universal Pictures';


/* TASK II
 Find the name of the companies that distributed movies released in 2006.
*/
SELECT distributors.name, movies.year FROM distributors
  JOIN movie_distributors ON movie_distributors.distributor_id = distributors.distributor_id
  JOIN movies ON movies.movie_id = movie_distributors.movie_id
  WHERE movies.year = 2006;


/* TASK III
Find all pairs of movie titles released in the same year, after 2010.
hint: use self join on table movies.
*/
SELECT movies.title, blahTable.title FROM movies
  JOIN movies blahTable
  ON movies.year = blahTable.year
  WHERE movies.year > 2010;

/* TASK IV
 Find the names and movie titles of directors that also acted in their movies.
*/
select p.name, movies.title, roles.role from directors dir
join people p on dir.person_id=p.person_id join roles on dir.person_id=roles.person_id
join movies on roles.movie_id=movies.movie_id
group by dir.person_id;


SELECT DISTINCT people.name, movies.title FROM people
  JOIN directors ON directors.person_id = people.person_id
  JOIN movies ON movies.movie_id = directors.movie_id
  JOIN roles ON roles.person_id = directors.person_id
  WHERE directors.person_id IN (SELECT roles.person_id FROM roles);

/* TASK V
Find ALL movies realeased in 2011 and their aka titles.
hint: left join
*/
SELECT movies.title, aka_titles.title, movies.year FROM movies
  LEFT JOIN aka_titles ON aka_titles.movie_id = movies.movie_id
  WHERE movies.year = 2011;



/* TASK VI
Find ALL movies realeased in 1976 OR 1977 and their composer's name.
*/
SELECT movies.title, movies.year, people.name as 'composer name' FROM movies
  JOIN composers ON composers.movie_id = movies.movie_id
  JOIN people ON people.person_id = composers.person_id
  WHERE movies.year = 1976 OR movies.year = 1977;



/* TASK VII       ###############
Find the most popular movie genres.
*/
SELECT * FROM movie_genres;

SELECT genres.label, COUNT(genres.genre_id) FROM genres
  JOIN movie_genres ON movie_genres.genre_id = genres.genre_id
  GROUP BY genres.label
  ORDER BY COUNT(genres.genre_id) DESC;

/* TASK VIII       #################
Find the people that achieved the 10 highest average ratings for the movies 
they cinematographed.
*/
SELECT * FROM people;

SELECT people.name, movies.rating FROM people
  JOIN cinematographers ON people.person_id = cinematographers.person_id
  JOIN movies ON cinematographers.movie_id = movies.movie_id
  WHERE cinematographers.person_id = people.person_id
  ORDER BY people.name;

SELECT DISTINCT people.name, AVG(movies.rating) OVER (PARTITION BY people.name ) FROM people
  JOIN cinematographers ON people.person_id = cinematographers.person_id
  JOIN movies ON movies.movie_id = cinematographers.movie_id
  ORDER BY movies.rating DESC LIMIT 10;


/* TASK IX
Find all countries which have produced at least one movie with a rating higher than
8.5.
hint: subquery
*/

/*SELECT countries.name, movies.title, movies.rating as 'movies better than 8.5' FROM countries
  JOIN movie_countries ON movie_countries.country_id = countries.country_id
  JOIN movies ON movies.movie_id = movie_countries.movie_id
  WHERE countries.name = 'Germany';*/

SELECT countries.name, COUNT(movies.rating) as 'movies better than 8.5' FROM countries
  JOIN movie_countries ON movie_countries.country_id = countries.country_id
  JOIN movies ON movies.movie_id = movie_countries.movie_id
  WHERE movies.rating > 8.5
  GROUP BY countries.name
  ORDER BY COUNT(movies.rating) DESC;



/* TASK X
Find the highest-rated movie, and report its title, year, rating, and country. There
can be ties; if so, you should report for each of them.
*/
SELECT movies.title, movies.year, movies.rating, countries.name FROM movies
  JOIN movie_countries ON movie_countries.movie_id = movies.movie_id
  JOIN countries ON countries.country_id = movie_countries.country_id
  WHERE movies.rating = (SELECT MAX(movies.rating) FROM movies);



/* STRETCH BONUS
Find the pairs of people that have directed at least 5 movies and whose 
carees do not overlap (i.e. The release year of a director's last movie is 
lower than the release year of another director's first movie).
*/
