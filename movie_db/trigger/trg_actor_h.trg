CREATE OR REPLACE TRIGGER trg_actor_h
AFTER INSERT OR UPDATE OR DELETE ON actor
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO actor_h (
            id, first_name, last_name, date_of_birth, nationality, creation_time, creation_user, last_mod_time, dml_flag, version
        ) VALUES (
            :NEW.id, :NEW.first_name, :NEW.last_name, :NEW.date_of_birth, :NEW.nationality, SYSDATE, USER, SYSDATE, 'I', :NEW.version
        );
    ELSIF UPDATING THEN
        INSERT INTO actor_h (
            id, first_name, last_name, date_of_birth, nationality, creation_time, creation_user, last_mod_time, dml_flag, version
        ) VALUES (
            :OLD.id, :OLD.first_name, :OLD.last_name, :OLD.date_of_birth, :OLD.nationality, SYSDATE, USER, SYSDATE, 'U', :OLD.version
        );
    ELSIF DELETING THEN
        INSERT INTO actor_h (
            id, first_name, last_name, date_of_birth, nationality, creation_time, creation_user, last_mod_time, dml_flag, version
        ) VALUES (
            :OLD.id, :OLD.first_name, :OLD.last_name, :OLD.date_of_birth, :OLD.nationality, SYSDATE, USER, SYSDATE, 'D', :OLD.version
        );
    END IF;
END;
/
