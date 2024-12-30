CREATE OR REPLACE VIEW vw_actor_statistics AS
SELECT 
    a.id AS actor_id,
    a.first_name || ' ' || a.last_name AS actor_name,
    COUNT(m.id) AS total_movies_starred,
    ROUND(AVG(m.rating), 2) AS average_movie_rating,
    MIN(m.release_year) AS first_movie_year,
    MAX(m.release_year) AS latest_movie_year,
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM a.date_of_birth) AS current_age,
    a.nationality
FROM 
    actor a
    LEFT JOIN movie m ON a.id = m.lead_actor_id
GROUP BY 
    a.id, a.first_name, a.last_name, a.date_of_birth, a.nationality;
