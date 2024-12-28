CREATE OR REPLACE TRIGGER trg_movie_h
AFTER INSERT OR UPDATE OR DELETE ON movie
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO movie_h (
            id, title, genre, release_year, rating, studio_id, lead_actor_id, creation_time, creation_user, last_mod_time, dml_flag, version
        ) VALUES (
            :NEW.id, :NEW.title, :NEW.genre, :NEW.release_year, :NEW.rating, :NEW.studio_id, :NEW.lead_actor_id, SYSDATE, USER, SYSDATE, 'I', :NEW.version
        );
    ELSIF UPDATING THEN
        INSERT INTO movie_h (
            id, title, genre, release_year, rating, studio_id, lead_actor_id, creation_time, creation_user, last_mod_time, dml_flag, version
        ) VALUES (
            :OLD.id, :OLD.title, :OLD.genre, :OLD.release_year, :OLD.rating, :OLD.studio_id, :OLD.lead_actor_id, SYSDATE, USER, SYSDATE, 'U', :OLD.version
        );
    ELSIF DELETING THEN
        INSERT INTO movie_h (
            id, title, genre, release_year, rating, studio_id, lead_actor_id, creation_time, creation_user, last_mod_time, dml_flag, version
        ) VALUES (
            :OLD.id, :OLD.title, :OLD.genre, :OLD.release_year, :OLD.rating, :OLD.studio_id, :OLD.lead_actor_id, SYSDATE, USER, SYSDATE, 'D', :OLD.version
        );
    END IF;
END;
/
