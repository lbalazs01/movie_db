CREATE OR REPLACE PACKAGE actor_pkg AS

    TYPE actor_stats_type IS OBJECT (
        actor_id          NUMBER,
        actor_name        VARCHAR2(100),
        total_movies_starred NUMBER,
        average_movie_rating NUMBER,
        actor_age         NUMBER
    );

    TYPE actor_stats_list_type IS TABLE OF actor_stats_type;

    -- Declare custom exceptions with custom error codes starting from 1
    exc_actor_not_found_code CONSTANT NUMBER := -10001;
    exc_actor_not_found EXCEPTION;
    PRAGMA EXCEPTION_INIT(exc_actor_not_found, -10001);

    exc_actor_duplicate_code CONSTANT NUMBER := -10002;
    exc_actor_duplicate EXCEPTION;
    PRAGMA EXCEPTION_INIT(exc_actor_duplicate, -10002);

    exc_actor_data_error_code CONSTANT NUMBER := -10003;
    exc_actor_data_error EXCEPTION;
    PRAGMA EXCEPTION_INIT(exc_actor_data_error, -10003);

    FUNCTION list_actor_stats RETURN actor_stats_list_type;

    PROCEDURE add_actor(
        p_first_name      IN VARCHAR2,
        p_last_name       IN VARCHAR2,
        p_date_of_birth   IN DATE,
        p_nationality     IN VARCHAR2
    );
/
CREATE OR REPLACE PACKAGE BODY actor_pkg AS

    FUNCTION list_actor_stats RETURN ty_actor_stats_l IS
        v_actor_stats ty_actor_stats_l := ty_actor_stats_l();
    BEGIN
        SELECT ty_actor_stats(
                   a.id,
                   a.first_name || ' ' || a.last_name,
                   COUNT(m.id),
                   ROUND(AVG(m.rating), 2),
                   EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM a.date_of_birth)
               )
        BULK COLLECT INTO v_actor_stats
        FROM actor a
        JOIN movie m ON a.id = m.lead_actor_id
        GROUP BY a.id, a.first_name, a.last_name, a.date_of_birth;

        RETURN v_actor_stats;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in list_actor_stats: ' || SQLERRM);
            RAISE;
    END list_actor_stats;

    PROCEDURE add_actor(
        p_first_name      IN VARCHAR2,
        p_last_name       IN VARCHAR2,
        p_date_of_birth   IN DATE,
        p_nationality     IN VARCHAR2
    ) IS
    BEGIN
        BEGIN
            INSERT INTO actor (id, first_name, last_name, date_of_birth, nationality, creation_time, creation_user, last_mod_time, dml_flag, version)
            VALUES (
                actor_seq.NEXTVAL,
                p_first_name,
                p_last_name,
                p_date_of_birth,
                p_nationality,
                SYSDATE,
                USER,
                SYSDATE,
                'N',
                1
            );
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                RAISE exc_actor_duplicate;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error in add_actor: ' || SQLERRM);
                RAISE;
        END;
    EXCEPTION
        WHEN exc_actor_duplicate THEN
            DBMS_OUTPUT.PUT_LINE('Actor already exists.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in add_actor: ' || SQLERRM);
            RAISE;
    END add_actor;

    PROCEDURE update_actor(
        p_actor_id        IN NUMBER,
        p_first_name      IN VARCHAR2,
        p_last_name       IN VARCHAR2,
        p_date_of_birth   IN DATE,
        p_nationality     IN VARCHAR2
    ) IS
    BEGIN
        BEGIN
            UPDATE actor
            SET first_name = p_first_name,
                last_name = p_last_name,
                date_of_birth = p_date_of_birth,
                nationality = p_nationality,
                last_mod_time = SYSDATE,
                version = version + 1
            WHERE id = p_actor_id;

            IF SQL%ROWCOUNT = 0 THEN
                RAISE exc_actor_not_found;
            END IF;
        EXCEPTION
            WHEN exc_actor_not_found THEN
                DBMS_OUTPUT.PUT_LINE('Actor not found with ID: ' || p_actor_id);
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error in update_actor: ' || SQLERRM);
                RAISE;
        END;
    EXCEPTION
        WHEN exc_actor_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Actor not found with ID: ' || p_actor_id);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in update_actor: ' || SQLERRM);
            RAISE;
    END update_actor;

    PROCEDURE delete_actor(
        p_actor_id        IN NUMBER
    ) IS
    BEGIN
        BEGIN
            DELETE FROM actor WHERE id = p_actor_id;

            IF SQL%ROWCOUNT = 0 THEN
                RAISE exc_actor_not_found;
            END IF;
        EXCEPTION
            WHEN exc_actor_not_found THEN
                DBMS_OUTPUT.PUT_LINE('Actor not found with ID: ' || p_actor_id);
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error in delete_actor: ' || SQLERRM);
                RAISE;
        END;
    EXCEPTION
        WHEN exc_actor_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Actor not found with ID: ' || p_actor_id);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in delete_actor: ' || SQLERRM);
            RAISE;
    END delete_actor;

    FUNCTION get_actor_details(p_actor_id IN NUMBER) RETURN ty_actor_stats IS
        v_actor_stat ty_actor_stats;
    BEGIN
        BEGIN
            SELECT ty_actor_stats(
                       a.id,
                       a.first_name || ' ' || a.last_name,
                       COUNT(m.id),
                       ROUND(AVG(m.rating), 2),
                       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM a.date_of_birth)
                   )
            INTO v_actor_stat
            FROM actor a
            LEFT JOIN movie m ON a.id = m.lead_actor_id
            WHERE a.id = p_actor_id
            GROUP BY a.id, a.first_name, a.last_name, a.date_of_birth;

            RETURN v_actor_stat;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('No actor found with ID: ' || p_actor_id);
                RETURN NULL;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error in get_actor_details: ' || SQLERRM);
                RAISE;
        END;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in get_actor_details: ' || SQLERRM);
            RAISE;
    END get_actor_details;

END actor_pkg;
/
