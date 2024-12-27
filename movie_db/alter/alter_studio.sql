ALTER TABLE studio ADD CONSTRAINT uk_studio_name unique(studio_name);
ALTER TABLE studio MODIFY(studio_name NOT NULL);
ALTER TABLE studio MODIFY(lot_location NOT NULL);

COMMENT ON TABLE studio is 'Movie Studios';
COMMENT ON COLUMN studio.studio_name is 'Studio Name';
COMMENT ON COLUMN studio.founded_year is 'Year the studio was founded';
COMMENT ON COLUMN studio.lot_location is 'Studio lot location';
COMMENT ON COLUMN studio.creation_time is 'New entry creation time';
COMMENT ON COLUMN studio.creation_user is 'User that executed the creation';
COMMENT ON COLUMN studio.last_mod_time is 'Lat time the entry was modified';
COMMENT ON COLUMN studio.version is 'Version';

