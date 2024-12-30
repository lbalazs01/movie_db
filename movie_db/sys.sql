CREATE USER movie_db_manager IDENTIFIED BY "password";

CREATE TABLESPACE movies_db_manager_ts DATAFILE 'Movie_DB' SIZE 100M;
  
ALTER USER movie_db_manager QUOTA UNLIMITED ON movies_db_manager_ts;
ALTER USER movie_db_manager QUOTA UNLIMITED ON users;

GRANT CREATE SESSION TO movie_db_manager;
GRANT CREATE TABLE TO movie_db_manager;
GRANT CREATE VIEW TO movie_db_manager;
GRANT CREATE SEQUENCE TO movie_db_manager;
GRANT CREATE PROCEDURE TO movie_db_manager;
GRANT CREATE TYPE TO movie_db_manager;
GRANT EXECUTE ON dbms_lock TO movie_db_manager;
GRANT CREATE TRIGGER to movie_db_manager;
GRANT CREATE JOB TO movie_db_manager; 
GRANT EXECUTE ON dbms_scheduler TO movie_db_manager;
GRANT RESOURCE TO movie_db_manager;
GRANT DEBUG CONNECT SESSION TO movie_db_manager;


