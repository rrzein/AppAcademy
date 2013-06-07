# 16/16 - great job

Question 1
SELECT actor.name
FROM actor
JOIN casting
ON actor.id = casting.actorid
JOIN movie
ON casting.movieid = movie.id
WHERE movie.title = 'Casablanca'
ORDER BY actor.name;

Question 8
SELECT actor.name
FROM actor
JOIN casting
ON actor.id = casting.actorid
JOIN movie
ON casting.movieid = movie.id
WHERE movie.title = 'Alien'
ORDER by actor.name;

Question 9
SELECT movie.title
FROM actor
JOIN casting
ON actor.id = casting.actorid
JOIN movie
ON casting.movieid = movie.id
WHERE 'Harrison Ford' in (actor.name)
ORDER BY movie.title;

Question 10
SELECT harrysmovies.title
FROM
(SELECT movie.title, movie.id
FROM actor
JOIN casting
ON actor.id = casting.actorid
JOIN movie
ON casting.movieid = movie.id
WHERE 'Harrison Ford' in (actor.name)
ORDER BY movie.title) as harrysmovies
JOIN casting
ON harrysmovies.id = casting.movieid
JOIN actor
ON actor.id = casting.actorid
WHERE casting.ord = 1 AND actor.name != 'Harrison Ford'
ORDER BY harrysmovies.title;

Question 11
SELECT DISTINCT films.movtitle, actor.name
FROM casting
JOIN
(SELECT movie.title as movtitle, movie.id as movid
FROM movie
JOIN casting
ON movie.id = casting.movieid
WHERE movie.yr = 1962) as films
ON casting.movieid = films.movid
JOIN actor
ON casting.actorid = actor.id
WHERE casting.ord = 1
ORDER BY films.movtitle, actor.name;

Question 12
SELECT movie.yr, COUNT(movie.title) as counts
FROM movie
JOIN casting
ON movie.id = casting.movieid
JOIN actor
ON actor.id = casting.actorid
WHERE actor.name = 'John Travolta'
GROUP BY movie.yr
HAVING counts > 2;

Question 13
SELECT m1.title, a1.name
FROM
(SELECT movie.*
FROM movie
JOIN casting
ON movie.id = casting.movieid
JOIN actor
ON actor.id = casting.actorid
WHERE actor.name = 'Julie Andrews') as m1
JOIN
(SELECT actor.*, casting.movieid
FROM actor
JOIN casting
ON actor.id = casting.actorid
WHERE casting.ord = 1) as a1
ON m1.id = a1.movieid
GROUP BY m1.title;

Question 14
SELECT actor.name
FROM actor
JOIN casting
ON actor.id = casting.actorid
JOIN movie
ON movie.id = casting.movieid
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(casting.movieid) >= 30;