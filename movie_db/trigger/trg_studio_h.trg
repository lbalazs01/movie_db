CREATE OR REPLACE TRIGGER trg_studio_h
AFTER INSERT OR UPDATE OR DELETE ON studio
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO studio_h (
            id, studio_name, founded_year, lot_location, creation_time, creation_user, last_mod_time, dml_flag, version
        ) VALUES (
            :NEW.id, :NEW.studio_name, :NEW.founded_year, :NEW.lot_location, SYSDATE, USER, SYSDATE, 'I', :NEW.version
        );
    ELSIF UPDATING THEN
        INSERT INTO studio_h (
            id, studio_name, founded_year, lot_location, creation_time, creation_user, last_mod_time, dml_flag, version
        ) VALUES (
            :OLD.id, :OLD.studio_name, :OLD.founded_year, :OLD.lot_location, SYSDATE, USER, SYSDATE, 'U', :OLD.version
        );
    ELSIF DELETING THEN
        INSERT INTO studio_h (
            id, studio_name, founded_year, lot_location, creation_time, creation_user, last_mod_time, dml_flag, version
        ) VALUES (
            :OLD.id, :OLD.studio_name, :OLD.founded_year, :OLD.lot_location, SYSDATE, USER, SYSDATE, 'D', :OLD.version
        );
    END IF;
END;
/
