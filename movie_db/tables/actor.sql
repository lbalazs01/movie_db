CREATE TABLE actor (
    id NUMBER PRIMARY KEY,   
    first_name VARCHAR2(50),       
    last_name VARCHAR2(50),        
    date_of_birth DATE,            
    nationality VARCHAR2(50),
    creation_time DATE,
    creation_user VARCHAR2(250),
    last_mod_time DATE,
    dml_flag      CHAR(1),
    version       NUMBER   
)TABLESPACE users;
