CREATE TABLE movie (
    id NUMBER PRIMARY KEY,  
    title VARCHAR2(100),          
    genre VARCHAR2(50),           
    release_year NUMBER,          
    rating NUMBER,                
    studio_id NUMBER,             
    lead_actor_id NUMBER,
    creation_time DATE,
    creation_user VARCHAR2(250),
    last_mod_time DATE,
    dml_flag      CHAR(1),
    version       NUMBER
)TABLESPACE users;
