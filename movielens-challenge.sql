USE movielens;

-- List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
SELECT * FROM movies 
	WHERE release_date 
		BETWEEN '1983-01-01' AND '1993-01-01' 
	ORDER BY release_date DESC;

-- Without using LIMIT, list the titles of the movies with the lowest average rating.
SELECT movies.title, AVG(ratings.rating) 
	FROM movies
     JOIN ratings
            ON movies.id = ratings.movie_id
		WHERE ratings.rating BETWEEN 0 AND 3
        GROUP BY movies.title
    ORDER BY AVG(ratings.rating);

-- List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
CREATE VIEW 24_m_student
AS
	SELECT users.id, users.age, users.gender, occupations.name
		FROM users
		JOIN occupations ON users.occupation_id = occupations.id
	WHERE users.age = 24 AND users.gender = 'M' AND occupations.name = 'Student';
    
CREATE VIEW 24_m_5starz
AS
	SELECT DISTINCT 24_m_student.id, 24_m_student.age, 24_m_student.gender, 24_m_student.name, ratings.movie_id, ratings.user_id, ratings.rating
		FROM ratings
		JOIN 24_m_student ON ratings.user_id = 24_m_student.id
	WHERE ratings.rating = 5;
    
CREATE VIEW movie_scifi
AS
	SELECT movies.id, movies.title, genres.name
		FROM movies
		LEFT OUTER JOIN genres_movies
			ON movies.id = genres_movies.movie_id
		LEFT OUTER JOIN genres
			ON genres.id = genres_movies.genre_id
		WHERE genres.name = 'Sci-Fi';

SELECT DISTINCT (title), 24_m_5starz.age, 24_m_5starz.gender, 24_m_5starz.name, 24_m_5starz.movie_id, 24_m_5starz.rating
	FROM movie_scifi
    JOIN 24_m_5starz
		ON movie_scifi.id = 24_m_5starz.movie_id
        ORDER BY title;

-- List the unique titles of each of the movies released on the most popular release day.
-- Find the total number of movies in each genre; list the results in ascending numeric order.