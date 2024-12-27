CREATE USER movie_manager IDENTIFIED BY "password";

CREATE TABLESPACE movie_manager_ts DATAFILE 'Movie' SIZE 100M;
  
ALTER USER movie_manager QUOTA UNLIMITED ON movie_manager_ts;
ALTER USER movie_manager QUOTA UNLIMITED ON users;

GRANT CREATE SESSION TO movie_manager;
GRANT CREATE TABLE TO movie_manager;
GRANT CREATE VIEW TO movie_manager;
GRANT CREATE SEQUENCE TO movie_manager;
GRANT CREATE PROCEDURE TO movie_manager;
GRANT CREATE TYPE TO movie_manager;
GRANT EXECUTE ON dbms_lock TO movie_manager;
GRANT CREATE TRIGGER to movie_manager;
GRANT CREATE JOB TO movie_manager; 
GRANT EXECUTE ON dbms_scheduler TO movie_manager;
GRANT RESOURCE TO movie_manager;

