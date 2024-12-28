CREATE OR REPLACE VIEW vw_actor_filmography AS
SELECT 
    a.id AS actor_id,
    a.first_name || ' ' || a.last_name AS actor_name,
    m.title AS movie_title,
    m.genre,
    m.release_year,
    s.studio_name AS studio,
    m.rating
FROM 
    actor a
    JOIN movie m ON a.id = m.lead_actor_id
    JOIN studio s ON m.studio_id = s.id;
