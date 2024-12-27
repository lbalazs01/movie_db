CREATE TABLE studio_h (
    id NUMBER PRIMARY KEY,  
    studio_name VARCHAR2(100),     
    founded_year NUMBER,           
    lot_location VARCHAR2(250),
    creation_time DATE,
    creation_user VARCHAR2(250),
    last_mod_time DATE,
    dml_flag      CHAR(1),
    version       NUMBER     
)TABLESPACE users;
