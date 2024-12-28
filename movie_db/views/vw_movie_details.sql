CREATE OR REPLACE VIEW vw_movie_details AS
SELECT 
    m.id AS movie_id,
    m.title AS movie_title,
    m.genre,
    m.release_year,
    m.rating,
    s.studio_name AS studio,
    a.first_name || ' ' || a.last_name AS lead_actor,
    m.creation_time,
    m.creation_user
FROM 
    movie m
    JOIN studio s ON m.studio_id = s.id
    JOIN actor a ON m.lead_actor_id = a.id;
