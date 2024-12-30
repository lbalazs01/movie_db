CREATE OR REPLACE PACKAGE studio_pkg AS
    exc_studio_exists EXCEPTION;
    PRAGMA EXCEPTION_INIT(exc_studio_exists, -50001);

    exc_studio_not_found EXCEPTION;
    PRAGMA EXCEPTION_INIT(exc_studio_not_found, -50002);

    PROCEDURE add_studio(p_studio_name VARCHAR2, p_founded_year NUMBER, p_lot_location VARCHAR2);
    PROCEDURE update_studio(p_studio_id NUMBER, p_studio_name VARCHAR2, p_founded_year NUMBER, p_lot_location VARCHAR2);
    PROCEDURE delete_studio(p_studio_id NUMBER);
END studio_pkg;
/
CREATE OR REPLACE PACKAGE BODY studio_pkg AS

    PROCEDURE add_studio(p_studio_name VARCHAR2, p_founded_year NUMBER, p_lot_location VARCHAR2) IS
        dummy NUMBER;
    BEGIN
        BEGIN
            SELECT 1
            INTO   dummy
            FROM   studio
            WHERE  studio_name = p_studio_name;

            RAISE exc_studio_exists;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                NULL;
        END;

        INSERT INTO studio (id, studio_name, founded_year, lot_location, creation_time, creation_user, last_mod_time, dml_flag, version)
        VALUES (studio_seq.NEXTVAL, p_studio_name, p_founded_year, p_lot_location, SYSDATE, 'SYSTEM', SYSDATE, 'A', 1);
    EXCEPTION
        WHEN exc_studio_exists THEN
            DBMS_OUTPUT.PUT_LINE('Studio already exists. Error Code: -50001');
        WHEN OTHERS THEN
            RAISE;
    END add_studio;

    PROCEDURE update_studio(p_studio_id NUMBER, p_studio_name VARCHAR2, p_founded_year NUMBER, p_lot_location VARCHAR2) IS
        v_exists NUMBER;
    BEGIN
        BEGIN
            SELECT COUNT(*) INTO v_exists
            FROM studio
            WHERE id = p_studio_id;

            IF v_exists = 0 THEN
                RAISE exc_studio_not_found;
            END IF;
        END;

        UPDATE studio
        SET studio_name = p_studio_name,
            founded_year = p_founded_year,
            lot_location = p_lot_location,
            last_mod_time = SYSDATE
        WHERE id = p_studio_id;
    EXCEPTION
        WHEN exc_studio_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Studio not found for update. Error Code: -50002');
        WHEN OTHERS THEN
            RAISE;
    END update_studio;

    PROCEDURE delete_studio(p_studio_id NUMBER) IS
        v_exists NUMBER;
    BEGIN
        BEGIN
            SELECT COUNT(*) INTO v_exists
            FROM studio
            WHERE id = p_studio_id;

            IF v_exists = 0 THEN
                RAISE exc_studio_not_found;
            END IF;
        END;

        DELETE FROM studio
        WHERE id = p_studio_id;
    EXCEPTION
        WHEN exc_studio_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Studio not found for deletion. Error Code: -50002');
        WHEN OTHERS THEN
            RAISE;
    END delete_studio;

END studio_pkg;
/
