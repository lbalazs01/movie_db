CREATE OR REPLACE VIEW vw_studio_productions AS
SELECT 
    s.id AS studio_id,
    s.studio_name,
    m.title AS movie_title,
    m.genre,
    m.release_year,
    m.rating,
    a.first_name || ' ' || a.last_name AS lead_actor
FROM 
    studio s
    JOIN movie m ON s.id = m.studio_id
    JOIN actor a ON m.lead_actor_id = a.id;
