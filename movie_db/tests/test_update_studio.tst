PL/SQL Developer Test script 3.0
35
DECLARE
    v_studio_id     NUMBER;
    v_studio_name   VARCHAR2(100);
    v_founded_year  NUMBER;
    v_lot_location  VARCHAR2(250);
BEGIN
    SELECT id INTO v_studio_id
    FROM studio
    WHERE ROWNUM = 1;

    SELECT studio_name INTO v_studio_name
    FROM studio
    WHERE id = v_studio_id;

    SELECT founded_year INTO v_founded_year
    FROM studio
    WHERE id = v_studio_id;

    SELECT lot_location INTO v_lot_location
    FROM studio
    WHERE id = v_studio_id;

    studio_pkg.update_studio(
        p_studio_id => v_studio_id,
        p_studio_name => v_studio_name || ' Updated',
        p_founded_year => v_founded_year + 1,
        p_lot_location => v_lot_location || ' - Updated'
    );

    DBMS_OUTPUT.PUT_LINE('Studio details updated successfully.');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error while updating studio details: ' || SQLERRM);
END;
0
0
