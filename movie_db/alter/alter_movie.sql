ALTER TABLE movie MODIFY(title NOT NULL);
ALTER TABLE movie MODIFY(genre NOT NULL);
ALTER TABLE movie MODIFY(release_year NOT NULL);

ALTER TABLE movie ADD CONSTRAINT fk_studio_id FOREIGN KEY(studio_id) REFERENCES studio(id);
ALTER TABLE movie ADD CONSTRAINT fk_actor_id FOREIGN KEY(lead_actor_id) REFERENCES actor(id);

ALTER TABLE movie ADD CONSTRAINT uq_movie UNIQUE (studio_id, lead_actor_id);

COMMENT ON TABLE actor is 'Movies';
COMMENT ON COLUMN actor.title is 'Movie title';
COMMENT ON COLUMN actor.genre is 'Movie genre';
COMMENT ON COLUMN actor.release_year is 'Date the movie premiered';
COMMENT ON COLUMN actor.rating is 'IMDB movie rating';
COMMENT ON COLUMN actor.studio_id is 'Studio id from studio table';
COMMENT ON COLUMN actor.lead_actor_id is 'Lead actor id from actor table';
COMMENT ON COLUMN actor.creation_time is 'New entry creation time';
COMMENT ON COLUMN actor.creation_user is 'User that executed the creation';
COMMENT ON COLUMN actor.last_mod_time is 'Lat time the entry was modified';
COMMENT ON COLUMN actor.version is 'Version';