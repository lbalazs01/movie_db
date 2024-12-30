CREATE OR REPLACE TYPE ty_actor_stats AS OBJECT (
    actor_id          NUMBER,
    actor_name        VARCHAR2(100),
    total_movies_starred NUMBER,
    average_movie_rating NUMBER,
    actor_age         NUMBER
);

CREATE OR REPLACE TYPE ty_actor_stats_l AS TABLE OF ty_actor_stats;
