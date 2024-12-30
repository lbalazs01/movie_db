PL/SQL Developer Test script 3.0
27
DECLARE
    v_studio_id   NUMBER;
    v_actor_id    NUMBER;
BEGIN
    SELECT id INTO v_studio_id
    FROM studio
    WHERE ROWNUM = 1
    ORDER BY id;

    SELECT id INTO v_actor_id
    FROM actor
    WHERE ROWNUM = 1
    ORDER BY id;  

    movie_pkg.add_movie(
        p_title => 'Interstellar',
        p_genre => 'Sci-Fi',
        p_release_year => 2014,
        p_studio_id => v_studio_id,
        p_lead_actor_id => v_actor_id
    );

    DBMS_OUTPUT.PUT_LINE('Movie added successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error while adding movie: ' || SQLERRM);
END;
0
0
