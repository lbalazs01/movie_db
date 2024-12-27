ALTER TABLE actor MODIFY(first_name NOT NULL);
ALTER TABLE actor MODIFY(last_name NOT NULL);
ALTER TABLE actor MODIFY(date_of_birth NOT NULL);
ALTER TABLE actor MODIFY(nationality NOT NULL);


COMMENT ON TABLE actor is 'Actors';
COMMENT ON COLUMN actor.first_name is 'Actor first name';
COMMENT ON COLUMN actor.last_name is 'Actor last name';
COMMENT ON COLUMN actor.date_of_birth is 'Date of birth';
COMMENT ON COLUMN actor.nationality is 'Actor nationality';
COMMENT ON COLUMN actor.creation_time is 'New entry creation time';
COMMENT ON COLUMN actor.creation_user is 'User that executed the creation';
COMMENT ON COLUMN actor.last_mod_time is 'Lat time the entry was modified';
COMMENT ON COLUMN actor.version is 'Version';
