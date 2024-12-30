CREATE OR REPLACE VIEW vw_studio_performance AS
SELECT 
    s.id AS studio_id,
    s.studio_name,
    COUNT(m.id) AS total_movies_produced,
    ROUND(AVG(m.rating), 2) AS average_movie_rating,
    COUNT(DISTINCT m.lead_actor_id) AS unique_lead_actors,
    MIN(m.release_year) AS first_movie_year,
    MAX(m.release_year) AS latest_movie_year,
    s.lot_location
FROM 
    studio s
    LEFT JOIN movie m ON s.id = m.studio_id
GROUP BY 
    s.id, s.studio_name, s.lot_location;
