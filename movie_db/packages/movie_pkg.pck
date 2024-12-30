CREATE OR REPLACE PACKAGE movie_pkg AS
    exc_movie_exists EXCEPTION;
    PRAGMA EXCEPTION_INIT(exc_movie_exists, -60001);

    exc_movie_not_found EXCEPTION;
    PRAGMA EXCEPTION_INIT(exc_movie_not_found, -60002);

    PROCEDURE add_movie(p_title VARCHAR2, p_genre VARCHAR2, p_release_year NUMBER, p_studio_id NUMBER, p_lead_actor_id NUMBER);
    PROCEDURE update_movie(p_movie_id NUMBER, p_title VARCHAR2, p_genre VARCHAR2, p_release_year NUMBER, p_studio_id NUMBER, p_lead_actor_id NUMBER);
    PROCEDURE delete_movie(p_movie_id NUMBER);
    PROCEDURE get_movie_details(p_movie_id NUMBER, o_title OUT VARCHAR2, o_genre OUT VARCHAR2, o_release_year OUT NUMBER, o_studio_name OUT VARCHAR2, o_actor_name OUT VARCHAR2);
END movie_pkg;
/
CREATE OR REPLACE PACKAGE BODY movie_pkg AS

    PROCEDURE add_movie(p_title VARCHAR2, p_genre VARCHAR2, p_release_year NUMBER, p_studio_id NUMBER, p_lead_actor_id NUMBER) IS
        dummy NUMBER;  
    BEGIN
        BEGIN
            SELECT 1
            INTO   dummy
            FROM   movie
            WHERE  title = p_title;

            RAISE exc_movie_exists; 
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                NULL; 
        END;

        INSERT INTO movie (id, title, genre, release_year, studio_id, lead_actor_id, creation_time, creation_user, last_mod_time, dml_flag, version)
        VALUES (movie_seq.NEXTVAL, p_title, p_genre, p_release_year, p_studio_id, p_lead_actor_id, SYSDATE, 'SYSTEM', SYSDATE, 'A', 1);
    EXCEPTION
        WHEN exc_movie_exists THEN
            DBMS_OUTPUT.PUT_LINE('Movie already exists. Error Code: -60001');
        WHEN OTHERS THEN
            RAISE;
    END add_movie;

    PROCEDURE update_movie(p_movie_id NUMBER, p_title VARCHAR2, p_genre VARCHAR2, p_release_year NUMBER, p_studio_id NUMBER, p_lead_actor_id NUMBER) IS
    BEGIN
        DECLARE
            v_exists NUMBER;
        BEGIN
            SELECT COUNT(*) INTO v_exists
            FROM movie
            WHERE id = p_movie_id;

            IF v_exists = 0 THEN
                RAISE exc_movie_not_found;
            END IF;
        END;

        UPDATE movie
        SET title = p_title,
            genre = p_genre,
            release_year = p_release_year,
            studio_id = p_studio_id,
            lead_actor_id = p_lead_actor_id,
            last_mod_time = SYSDATE
        WHERE id = p_movie_id;
    EXCEPTION
        WHEN exc_movie_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Movie not found for update. Error Code: -60002');
        WHEN OTHERS THEN
            RAISE; 
    END update_movie;

    PROCEDURE delete_movie(p_movie_id NUMBER) IS
    BEGIN
        DECLARE
            v_exists NUMBER;
        BEGIN
            SELECT COUNT(*) INTO v_exists
            FROM movie
            WHERE id = p_movie_id;

            IF v_exists = 0 THEN
                RAISE exc_movie_not_found;
            END IF;
        END;

        DELETE FROM movie
        WHERE id = p_movie_id;
    EXCEPTION
        WHEN exc_movie_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Movie not found for deletion. Error Code: -60002');
        WHEN OTHERS THEN
            RAISE;
    END delete_movie;

    PROCEDURE get_movie_details(p_movie_id NUMBER, o_title OUT VARCHAR2, o_genre OUT VARCHAR2, o_release_year OUT NUMBER, o_studio_name OUT VARCHAR2, o_actor_name OUT VARCHAR2) IS
    BEGIN
        SELECT m.title, m.genre, m.release_year, s.studio_name, a.first_name || ' ' || a.last_name
        INTO o_title, o_genre, o_release_year, o_studio_name, o_actor_name
        FROM movie m
        JOIN studio s ON m.studio_id = s.id
        JOIN actor a ON m.lead_actor_id = a.id
        WHERE m.id = p_movie_id;
    EXCEPTION
        WHEN exc_movie_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Movie not found. Error Code: -60002');
        WHEN OTHERS THEN
            RAISE; 
    END get_movie_details;

END movie_pkg;
/
